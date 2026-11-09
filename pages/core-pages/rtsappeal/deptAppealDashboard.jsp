<jsp:directive.include file="/pages/common/include.jsp" />
<jsp:directive.include file="/pages/core-pages/rtsappeal/rtsAppealStyles.jspf" />
<%-- Dashboard: appeal applications, department wise (rows: department, service, level, total, submitted, remark, closed delivered, closed by officer) --%>

<div class="ap-page">
	<div class="ap-head">
		<div>
			<h3>Appeal Applications - Department wise</h3>
			<p class="ap-sub">Appeals are counted separately and are not part of "Applications Received".</p>
		</div>
		<div class="ap-actions">
			<a class="ap-btn ap-btn-blue" href="<c:out value='${contextRoot}'/>/rtsappeal/listAppeals.do">My Appeal Applications</a>
			<a class="ap-btn ap-btn-light" href="<c:out value='${contextRoot}'/>/dashBoard/openDashBoard.do">Back to Dashboard</a>
		</div>
	</div>

	<div class="ap-card">
		<div class="ap-table-wrap">
			<table class="ap-table">
				<thead>
					<tr>
						<th>Department</th>
						<th>Service</th>
						<th>Appeal</th>
						<th style="text-align: right">Total</th>
						<th style="text-align: right">With Appellate Officer</th>
						<th style="text-align: right">Sent back to department</th>
						<th style="text-align: right">Closed - Service Delivered</th>
						<th style="text-align: right">Closed by Appellate Officer</th>
						<th style="text-align: right">Closed - Rejected again</th>
					</tr>
				</thead>
				<tbody>
					<c:if test="${empty rows}">
						<tr><td colspan="9" class="ap-empty">No appeals yet.</td></tr>
					</c:if>
					<c:set var="sumTotal" value="0"/><c:set var="sumSub" value="0"/><c:set var="sumRem" value="0"/>
					<c:set var="sumDel" value="0"/><c:set var="sumOff" value="0"/><c:set var="sumRej" value="0"/>
					<c:forEach items="${rows}" var="r">
						<tr>
							<td><c:out value="${r[0]}"/></td>
							<td><c:out value="${r[1]}"/></td>
							<td><c:out value="${r[2] == 2 ? 'Second Appeal' : 'First Appeal'}"/></td>
							<td style="text-align: right"><b><c:out value="${r[3]}"/></b></td>
							<td style="text-align: right"><c:out value="${r[4]}"/></td>
							<td style="text-align: right"><c:out value="${r[5]}"/></td>
							<td style="text-align: right"><c:out value="${r[6]}"/></td>
							<td style="text-align: right"><c:out value="${r[7]}"/></td>
							<td style="text-align: right"><c:out value="${r[8]}"/></td>
						</tr>
						<c:set var="sumTotal" value="${sumTotal + r[3]}"/><c:set var="sumSub" value="${sumSub + r[4]}"/>
						<c:set var="sumRem" value="${sumRem + r[5]}"/><c:set var="sumDel" value="${sumDel + r[6]}"/>
						<c:set var="sumOff" value="${sumOff + r[7]}"/><c:set var="sumRej" value="${sumRej + r[8]}"/>
					</c:forEach>
					<c:if test="${not empty rows}">
						<tr>
							<td colspan="3"><b>Total</b></td>
							<td style="text-align: right"><b><c:out value="${sumTotal}"/></b></td>
							<td style="text-align: right"><b><c:out value="${sumSub}"/></b></td>
							<td style="text-align: right"><b><c:out value="${sumRem}"/></b></td>
							<td style="text-align: right"><b><c:out value="${sumDel}"/></b></td>
							<td style="text-align: right"><b><c:out value="${sumOff}"/></b></td>
							<td style="text-align: right"><b><c:out value="${sumRej}"/></b></td>
						</tr>
					</c:if>
				</tbody>
			</table>
		</div>
	</div>
</div>
