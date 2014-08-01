<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/includes/headerForAjax.jsp" %>
<a onClick='backToStatistics();' style='text-decoration:none'><i class="fa fa-chevron-left"></i> <spring:message code="system.gotoback"/></a><br/><br/><br/>
<div class="row">
	<div class="col-md-12">
		<table class="table table-bordered" id="reviewerHistoryTable">
			<thead>
			<tr>
				<th class="cellCenter">
				</th>
				<th class="cellCenter">
					<spring:message code='system.manuscriptId'/>
				</th>
				<th class="cellCenter">
					<spring:message code='system.version'/>
				</th>
				<th class="cellCenter">
					<spring:message code='manuscript.title'/>
				</th>
				<th class="cellCenter">
					<spring:message code='manuscript.submitDate'/>
				</th>
				<th class="cellCenter">
					<c:if test="${status == 'I' }">
						<spring:message code='reviewer.inviteDate'/>
					</c:if>
					<c:if test="${status == 'A' }">
						<spring:message code='reviewer.assignDate'/>
					</c:if>
					<c:if test="${status == 'C' }">
						<spring:message code='reviewer.completeDate'/>
					</c:if>
				</th>
			</tr>
			</thead>
			<tbody>
			</tbody>
		</table>
	</div>
</div>
<script>
$(document).ready(function() {
	var requestUrl = "${baseUrl}/journals/${jnid}/${currentPageRole}/reviewers/getReviewerHistoryPapers?reviewerUserId=${reviewerUserId}&status=${status}&t=${t}&j=${j}";
	ReviwerHistoryTableAjax.init(requestUrl);
});
</script>