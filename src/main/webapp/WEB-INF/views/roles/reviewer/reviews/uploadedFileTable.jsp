<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/includes/headerForAjax.jsp" %>
<script>
$('.fileDeleteButton').click(function(event){
	event.preventDefault();
	var t = $(this);
	bootbox.confirm("<spring:message code='system.areYouSure' javaScriptEscape='true' />", function(result) {
		if(result == true) {
			var fileId = t.attr("data-fileId");
			var url = "${baseUrl}/journals/${jnid}/delete/additionalReview/" +  fileId;
			$.ajax({
				type: "POST",
				url: url,
				success:function(html) {
					$.ajax({
						type:"GET",
						url: "${baseUrl}/journals/${jnid}/reviewer/reviews/uploadedFileTable",
						data: "manuscriptId=${manuscript.id}",
						success:function(html) {
							$("#uploadedFileView").html(html).show();
						}
					});
				}
			});
		}
	});
});

</script>
<table class="table table-bordered">
	<thead>
		<tr>
			<th class="cellCenter">
				 <spring:message code="system.fileName"/>
			</th>
			<th class="cellCenter">
				 <spring:message code="system.fileDesignation"/>
			</th>
			<th class="cellCenter">
				 <spring:message code="system.uploadDate"/>
			</th>
			<th class="cellCenter">
				 <spring:message code="system.action"/>
			</th>
		</tr>
	</thead>
	<tbody>
	<c:choose>
		<c:when test="${not empty additionalReviewFiles }">
			<c:forEach var="f" items="${additionalReviewFiles}">
				<tr>
					<td class="cellCenter">
					<a href="${baseUrl}/journals/${jnid}/download/${f.id}">${f.originalName}</a>
					</td>
					<td class="cellCenter">
						<c:choose>
							<c:when test="${f.designation == 'additionalReviewResults'}">
								<spring:message code="reviewer.additionalReviewResult.fileDesignation.0"/>
							</c:when>
							<c:when test="${f.designation == 'others'}">
								<spring:message code="reviewer.additionalReviewResult.fileDesignation.1"/>
							</c:when>
						</c:choose>
					</td>
					<td class="cellCenter">
					${f.date}
					</td>
					<td class="cellCenter">
						<button class="btn btn-default btn-xs fileDeleteButton" data-fileId="${f.id }">
							<spring:message code="system.delete"/>
						</button>
					</td>
				</tr>
			</c:forEach>
		</c:when>
		<c:otherwise>
			<tr>
				<td colspan="4" class="cellCenter">
					<spring:message code="system.noDataInTable"/>
				</td>
			</tr>
		</c:otherwise>
	</c:choose>
	</tbody>
</table>