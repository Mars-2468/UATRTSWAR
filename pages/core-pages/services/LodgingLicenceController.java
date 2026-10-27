package com.mars.rti.controller;

import java.io.ByteArrayInputStream;
import java.io.UnsupportedEncodingException;
import java.time.Year;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.w3c.dom.Document;
import org.w3c.dom.NodeList;
import org.xml.sax.SAXException;

import com.mars.common.controller.AapleSarkarPortalIntegrationNagpur;
import com.mars.common.model.UserRegistrationDetails;
import com.mars.common.service.UserRegistrationService;
import com.mars.common.utils.CommonUtils;
import com.mars.rti.model.LodgingLicence;
import com.mars.rti.model.RTIApplication;
import com.mars.rti.model.RTIApplicationDetails;
import com.mars.rti.service.LodgingLicenceService;
import com.mars.rti.service.RTIApplicationService;
import com.mars.rti.ws.model.AuthenticationResponseDTO;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUpload;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.json.JSONObject;
import org.springframework.web.bind.annotation.RequestMethod;
import com.mars.rti.utils.CoreConstants;
import java.time.LocalDate;
import java.beans.PropertyEditorSupport;
import org.springframework.web.bind.ServletRequestDataBinder;
import org.springframework.web.bind.annotation.InitBinder;

/**
 * LODGING-LICENCE - citizen application form.
 *
 * Built to the same shape as BirthCertificateController, which is the reference for an Aaple Sarkar
 * RTS service: the citizen must be signed in, the application is linked to their registered account,
 * and an application arriving from the Aaple Sarkar portal is pushed back to the portal and then
 * handed to MahaOnline for payment.
 */
@Controller
public class LodgingLicenceController {

	private static Log log = LogFactory.getLog(LodgingLicenceController.class);

	/* document upload limits - 2 MB per file, as stated on the form */
	private static final int MAX_FILE_SIZE = 2 * 1024 * 1024;
	private static final int REQUEST_SIZE = 20 * 1024 * 1024;

	/*
	 * TO BE CONFIRMED BEFORE GO-LIVE.
	 *
	 * RTI_SERVICE_ID is the id this service is registered under in the RTS service master. It drives
	 * the dashboards, the departmental routing and the reports. 105-114 were allocated as the next
	 * free numbers after the highest in use (104) and must be checked against the master.
	 *
	 * DEPT_CODE is the department segment of the application number, e.g. RTS/MD/1234/2026.
	 */
	private static final int RTI_SERVICE_ID = 108;
	private static final String DEPT_CODE = "MD";
	private static final String DEPARTMENT = "MARKET-DEPARTMENT";
	private static final String SUBJECT = "LODGING-LICENCE";
	private static final String TEMPLATE_NAME = "lodgingLicenceApplication";

	@Autowired
	private LodgingLicenceService lodgingLicenceService;

	@Autowired
	private RTIApplicationService rtiApplicationService;

	@Autowired
	private UserRegistrationService userService;

	@Autowired
	private AapleSarkarPortalIntegrationNagpur aapleSarkarPortalIntegrationNagpur;

	/**
	 * Opens the blank form. Refused when the citizen is not signed in, which is also how an Aaple
	 * Sarkar visitor is sent back to the portal login.
	 */
	@RequestMapping("ws/rtiapplication/newRTILodgingLicence.do")
	public ModelAndView newRTILodgingLicence(HttpServletRequest request, HttpServletResponse response)
			throws ServletException {
		HttpSession session = request.getSession();
		String name = (String) session.getAttribute("name");
		session.removeAttribute("as_status");
		request.setAttribute("name", name);

		if (name != null) {
			setFormReferenceData(request);
			return new ModelAndView("newRTILodgingLicence");
		}
		session.removeAttribute("mobileNo");
		return new ModelAndView("redirect:/ws/user/login.do");
	}

	@RequestMapping("/rtsapplication/saveLodgingLicence.do")
	public ModelAndView saveLodgingLicence(HttpServletRequest request, HttpServletResponse response,
			LodgingLicence lodgingLicence) throws ServletException {

		HttpSession session = request.getSession();

		if (log.isDebugEnabled()) {
			log.debug("Invoking LODGING-LICENCE");
		}

		String userName = null;
		Object userLogin = session.getAttribute("name");
		if (userLogin != null) {
			userName = (String) userLogin;
		}

		Object sessionMobile = session.getAttribute("mobileNo");
		String mobileNumber = String.valueOf(sessionMobile);
		Object asStatus = session.getAttribute("as_status");

		if (sessionMobile == null || lodgingLicence == null) {
			return new ModelAndView("redirect:/ws/user/login.do");
		}

		UserRegistrationDetails user = userService.getUserByMobileNo(mobileNumber);

		RTIApplication rtiApplication = new RTIApplication();
		rtiApplication.setCreatedDate(CommonUtils.getCurrentStringDateAndTime());
		rtiApplication.setRegistrationDate(CommonUtils.getCurrentStringDateAndTime());
		rtiApplication.setTemplateName(TEMPLATE_NAME);
		rtiApplication.setSubject(SUBJECT);
		rtiApplication.setDepartment(DEPARTMENT);
		rtiApplication.setWorkFlowStatus(0);
		rtiApplication.setFinalStatus("0");
		rtiApplication.setRtiserviceid(RTI_SERVICE_ID);
		rtiApplication.setApplicantName(lodgingLicence.getApplicantName());
		rtiApplication.setPhoneNumber(lodgingLicence.getMobileNo());
		rtiApplication.setMobileNumber(lodgingLicence.getMobileNo());
		rtiApplication.setEmail(lodgingLicence.getEmail());
		rtiApplication.setZone(lodgingLicence.getZoneNo());
		rtiApplication.setPdfUploadFromPortal(lodgingLicence.getFilesPath());
		rtiApplication.setUserRegistrationDetails(user);
		rtiApplication.setIsApleSarkarApp(0);

		/*
		 * Fees are not calculated for this service yet, so the application carries no cost. When the
		 * fee rules are configured this is where FeesMasterController is called, as the other
		 * services do.
		 */
		double amount = 0.0;
		rtiApplication.setApplicationCost(amount);

		if (asStatus != null && userName == null) {
			rtiApplication.setAapleSarkarUserMobileNo(mobileNumber);
		}

		List<RTIApplicationDetails> rtiApplicationDetailsList = new ArrayList<RTIApplicationDetails>();
		RTIApplicationDetails rtiApplicationDetails = new RTIApplicationDetails();
		rtiApplicationDetails.setRtiApplication(rtiApplication);
		rtiApplicationDetails.setStatus(0);
		rtiApplicationDetails.setAssignToStatus(1);
		rtiApplicationDetails.setAssignedStartDate(rtiApplication.getCreatedDate());
		rtiApplicationDetails.setAssignedEndDate(CommonUtils.getCurrentStringDateAndTime());
		rtiApplicationDetails.setComments("Form Submitted");
		rtiApplicationDetails.setWorkflowLevel(0);
		rtiApplicationDetailsList.add(rtiApplicationDetails);
		rtiApplication.setRtiApplicationDetails(rtiApplicationDetailsList);

		RTIApplication savedRti = rtiApplicationService.merge(rtiApplication);
		RTIApplication returnRti = null;

		if (savedRti.getRtiApplicationId() > 0) {

			RTIApplication rti = rtiApplicationService.get(savedRti.getRtiApplicationId());
			rti.setRtiApplnNumber("RTS/" + DEPT_CODE + "/" + savedRti.getRtiApplicationId() + "/" + Year.now());

			lodgingLicence.setRtiapplrefno(rti.getRtiApplnNumber());
			lodgingLicence.setRti_ref_id(savedRti.getRtiApplicationId());

			long formId = lodgingLicenceService.lodgingLicence(lodgingLicence);
			rti.setRtiApplicationRefId(formId);

			if (asStatus != null && userName == null) {
				rti.setAaple_service_id(request.getParameter("serviceId"));
				rti.setAaple_user_id(request.getParameter("user"));
				rti.setAaple_user_track_id(request.getParameter("trackid"));
				rti.setAapleSarkarUserMobileNo(request.getParameter("mobile"));
				rti.setIsApleSarkarApp(1);
				rti.setApplication_status(2);
			}

			returnRti = rtiApplicationService.merge(rti);

			String applnNo = rti.getRtiApplnNumber();
			SendSMSEmailController.sendApplicationSubmitted(lodgingLicence.getApplicantName(),
					lodgingLicence.getMobileNo(), applnNo, lodgingLicence.getEmail());

			log.info("LODGING-LICENCE saved, application " + applnNo + ", form id " + formId);
		}

		if (returnRti == null) {
			return new ModelAndView("redirect:/ws/user/login.do");
		}

		/*
		 * An application that came in from Aaple Sarkar is pushed back to the portal with its status,
		 * then handed to MahaOnline for payment. A citizen applying directly goes straight to the
		 * success page.
		 */
		if (asStatus != null && userName == null) {
			return redirectToAapleSarkar(request, returnRti, amount);
		}

		return new ModelAndView("redirect:/ws/rtsapplication/newLodgingLicenceSuccess.do?rtsAppNo="
				+ returnRti.getRtiApplnNumber() + "&isApleSarkar=" + returnRti.getIsApleSarkarApp());
	}

	/**
	 * Pushes the saved application back to the Aaple Sarkar portal and, when that succeeds, redirects
	 * the citizen to MahaOnline to pay.
	 */
	private ModelAndView redirectToAapleSarkar(HttpServletRequest request, RTIApplication returnRti, double amount) {

		String str = request.getParameter("str");
		String serviceId = request.getParameter("serviceId");
		String distric = request.getParameter("distric");
		String trackid = request.getParameter("trackid");
		String userid = request.getParameter("user");
		String mobile = request.getParameter("mobile");
		String name = request.getParameter("name");

		String appId = returnRti.getRtiApplnNumber().replace("/", "");
		String returnUrl = "https://nmcnagpur.gov.in/RTSservices/ws/rtsapplication/newLodgingLicenceSuccess.do?rtsAppNo="
				+ appId + "&isApleSarkar=" + returnRti.getIsApleSarkarApp();

		String pushBackResponse = aapleSarkarPortalIntegrationNagpur.redirectPushApi(distric, trackid, userid, mobile,
				name, str, serviceId, appId, returnUrl, "N", "NA", "N", "NA", 1, "NA", amount, 0, 2, "NA", distric,
				returnRti.getMobileNumber());

		log.debug("LODGING-LICENCE push back response: " + pushBackResponse);

		String statusValue = null;
		AuthenticationResponseDTO authenticationResponseDTO = null;
		try {
			DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
			DocumentBuilder builder = factory.newDocumentBuilder();
			ByteArrayInputStream input = new ByteArrayInputStream(pushBackResponse.getBytes("UTF-8"));
			Document doc = builder.parse(input);
			NodeList nodeList = doc.getElementsByTagName("status");
			if (nodeList.getLength() > 0) {
				statusValue = nodeList.item(0).getTextContent();
			}
		} catch (ParserConfigurationException e) {
			log.error("LODGING-LICENCE push back - parser error", e);
		} catch (UnsupportedEncodingException e) {
			log.error("LODGING-LICENCE push back - encoding error", e);
		} catch (SAXException e) {
			log.error("LODGING-LICENCE push back - malformed response", e);
		} catch (Exception e) {
			log.error("LODGING-LICENCE push back failed", e);
		}

		if (statusValue != null && statusValue.equals("Success")) {
			authenticationResponseDTO = aapleSarkarPortalIntegrationNagpur.redirectForAapleSarkarPaymentFinal(distric,
					trackid, userid, mobile, name, str, serviceId, returnRti.getRtiApplnNumber(), returnUrl);
		}

		/*
		 * Checked before use. The original form of this code read the key off the DTO without testing
		 * it, so a failed push back threw a NullPointerException instead of showing the error page.
		 */
		if (authenticationResponseDTO != null && authenticationResponseDTO.getKey() != null
				&& authenticationResponseDTO.getKey().length() > 0) {

			String redirectUrl = "https://aaplesarkar.mahaonline.gov.in/en/OutPayment/Pay?webstr="
					+ authenticationResponseDTO.getWebstring()
					+ "&DeptCode=NMCDeptN"
					+ "&Authentication=" + authenticationResponseDTO.getKey();

			log.debug("LODGING-LICENCE redirecting to Aaple Sarkar payment: " + redirectUrl);
			return new ModelAndView("redirect:" + redirectUrl);
		}

		log.error("LODGING-LICENCE - Aaple Sarkar push back did not succeed, status " + statusValue);
		request.getSession().removeAttribute("mobileNo");
		return new ModelAndView("userError");
	}

	/**
	 * The success page, reached by redirect so a refresh cannot resubmit the form.
	 */
	@RequestMapping("ws/rtsapplication/newLodgingLicenceSuccess.do")
	public ModelAndView newLodgingLicenceSuccess(HttpServletRequest request, HttpServletResponse response) {
		String appNo = request.getParameter("rtsAppNo");
		String isApleSarkar = request.getParameter("isApleSarkar");
		log.debug("LODGING-LICENCE success, application " + appNo);

		ModelAndView model = new ModelAndView("newRTILodgingLicenceSucess");
		model.addObject("appNo", appNo);
		model.addObject("isApleSarkar", isApleSarkar);
		return model;
	}

	@RequestMapping("/rtiapplication/editLodgingLicence.do")
	public ModelAndView editLodgingLicence(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, Exception {

		LodgingLicence lodgingLicence = null;
		RTIApplication rtiapplication = null;
		long rtiApplicationRefId = 0;
		long rtiApplicationId = 0;

		if (request.getParameter("rtiApplicationRefId") != null
				&& request.getParameter("rtiApplicationRefId").length() > 0) {

			rtiApplicationRefId = Long.parseLong(request.getParameter("rtiApplicationRefId"));
			lodgingLicence = lodgingLicenceService.get(rtiApplicationRefId);

			if (lodgingLicence != null && lodgingLicence.getRti_ref_id() > 0) {
				rtiApplicationId = lodgingLicence.getRti_ref_id();
				rtiapplication = rtiApplicationService.get(rtiApplicationId);
			} else {
				List<RTIApplication> listRTI = rtiApplicationService.findByProperty("rtiApplicationRefId",
						rtiApplicationRefId);
				if (listRTI != null && !listRTI.isEmpty()) {
					rtiApplicationId = listRTI.get(0).getRtiApplicationId();
					rtiapplication = listRTI.get(0);
				}
			}
		}

		request.setAttribute("rtiApplication", rtiapplication);
		request.setAttribute("rtiApplicationRefId", rtiApplicationId);
		request.setAttribute("lodgingLicence", lodgingLicence);

		ModelAndView model = new ModelAndView("manageLodgingLicence");
		model.addObject("lodgingLicence", lodgingLicence);
		return model;
	}

	/**
	 * Receives the supporting documents the citizen attached to the form. Called by
	 * uploadDocuments() in newRTILodgingLicence.jsp before the application itself is saved, so a
	 * failed upload stops the save. Only .pdf up to 2 MB is accepted; each file is stored
	 * as <id><name>.pdf under UPLOAD_PATH/lodginglicence, which is the path the form records
	 * against the matching document property.
	 */
	@RequestMapping(value = "/rtiapplication/uploadLodgingLicence.do", method = RequestMethod.POST)
	public void uploadLodgingLicence(HttpServletRequest request, HttpServletResponse response) throws IOException {

		JSONObject json = new JSONObject();
		response.setContentType("application/json");
		PrintWriter out = response.getWriter();

		try {
			String id = request.getParameter("id");
			if (id == null || id.trim().isEmpty()) {
				throw new Exception("Upload reference id is missing");
			}
			id = id.trim().replaceAll("[^0-9]", "");
			if (id.isEmpty()) {
				throw new Exception("Upload reference id is not valid");
			}

			if (!FileUpload.isMultipartContent(request)) {
				throw new Exception("Invalid request");
			}

			String baseDir = CoreConstants.UPLOAD_PATH + "lodginglicence";
			File dir = new File(baseDir);
			if (!dir.exists()) {
				dir.mkdirs();
			}

			DiskFileItemFactory factory = new DiskFileItemFactory();
			factory.setSizeThreshold(MAX_FILE_SIZE);
			ServletFileUpload upload = new ServletFileUpload(factory);
			upload.setFileSizeMax(MAX_FILE_SIZE);
			upload.setSizeMax(REQUEST_SIZE);

			List<FileItem> items = upload.parseRequest(request);
			int saved = 0;

			for (FileItem item : items) {

				if (item.isFormField() || item.getName() == null || item.getName().isEmpty()) {
					continue;
				}

				String originalName = new File(item.getName()).getName();

				if (!originalName.toLowerCase().endsWith(".pdf")) {
					throw new Exception("Only .pdf files are allowed");
				}
				if (originalName.substring(0, originalName.lastIndexOf(".")).contains(".")) {
					throw new Exception("Invalid file (double extension not allowed)");
				}
				if (item.getSize() > MAX_FILE_SIZE) {
					throw new Exception("File " + originalName + " is larger than 2 MB");
				}

				// same name the form recorded: <id> + name stripped of punctuation + .pdf
				String cleanName = originalName.substring(0, originalName.lastIndexOf("."))
						.replaceAll("[^a-zA-Z0-9]", "");
				File storeFile = new File(baseDir, id + "_" + item.getFieldName() + "_" + cleanName + ".pdf");
				item.write(storeFile);
				saved++;
			}

			json.put("status", true);
			json.put("count", saved);
			json.put("message", saved + " document(s) uploaded successfully");

		} catch (Exception e) {
			log.error("uploadLodgingLicence failed", e);
			json.put("status", false);
			json.put("message", e.getMessage());
		}

		out.print(json);
		out.flush();
	}

	/**
	 * Values the blank form needs: today's date, which caps the pickers that must not take a
	 * future date, and the financial years offered on the Sky Sign section.
	 */
	private void setFormReferenceData(HttpServletRequest request) {
		LocalDate today = LocalDate.now();
		request.setAttribute("today", today.toString());

		// a financial year runs April to March, so before April we are still in the previous one
		int startYear = today.getMonthValue() >= 4 ? today.getYear() : today.getYear() - 1;
		List<String> financialYears = new ArrayList<String>();
		for (int i = 0; i < 5; i++) {
			financialYears.add((startYear + i) + "-" + (startYear + i + 1));
		}
		request.setAttribute("financialYears", financialYears);
	}

	/**
	 * An empty number box posts the empty string. Spring cannot convert that to a
	 * primitive, and with no BindingResult on the handler the request would fail as
	 * 400 Bad Request before any of our code runs. Treat blank as zero, and let a
	 * genuinely malformed number still be rejected.
	 */
	@InitBinder
	protected void initBinder(HttpServletRequest request, ServletRequestDataBinder binder) {
		binder.registerCustomEditor(double.class, new BlankAsZero());
		binder.registerCustomEditor(Double.class, new BlankAsZero());
		binder.registerCustomEditor(long.class, new BlankAsZeroLong());
		binder.registerCustomEditor(Long.class, new BlankAsZeroLong());
		binder.registerCustomEditor(int.class, new BlankAsZeroInt());
		binder.registerCustomEditor(Integer.class, new BlankAsZeroInt());
		// trim what the citizen typed so a stray space is not stored or validated against
		binder.registerCustomEditor(String.class, new org.springframework.beans.propertyeditors.StringTrimmerEditor(true));
	}

	private static final class BlankAsZero extends PropertyEditorSupport {
		@Override
		public void setAsText(String text) {
			setValue(text == null || text.trim().isEmpty()
					? Double.valueOf(0) : Double.valueOf(text.trim()));
		}
	}

	private static final class BlankAsZeroLong extends PropertyEditorSupport {
		@Override
		public void setAsText(String text) {
			setValue(text == null || text.trim().isEmpty()
					? Long.valueOf(0) : Long.valueOf(text.trim()));
		}
	}

	private static final class BlankAsZeroInt extends PropertyEditorSupport {
		@Override
		public void setAsText(String text) {
			setValue(text == null || text.trim().isEmpty()
					? Integer.valueOf(0) : Integer.valueOf(text.trim()));
		}
	}
}
