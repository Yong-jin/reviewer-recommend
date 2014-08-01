<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/includes/headerForAjax.jsp" %>
<script>
var errorMessages = new Array();
errorMessages['author.newPaperSubmit.uploadSuccess'] = "<spring:message code='author.newPaperSubmit.uploadSuccess' javaScriptEscape='true' />";
errorMessages['system.areYouSure'] = "<spring:message code='system.areYouSure' javaScriptEscape='true' />";
$('.fileDeleteButton').click(function(event){
	event.preventDefault();
	var t = $(this);
	var fileId = t.attr("data-fileId");
	var url = "${baseUrl}/journals/${jnid}/delete/additionalCorrection/" + fileId;
	var data = "manuscriptId=${manuscript.id}";
	$.ajax({
		type:"POST",
		url: url,
		success:function(html) {
			$.ajax({
				type:"GET",
				url: "${baseUrl}/journals/${jnid}/author/manuscripts/additionalCorrection/uploadedFileTable",
				data: data,
				success:function(html) {
					$("#galleryProofCorrectionUploadedFileView").html(html).show();
				}
			});
		}
	});
});

</script>
<c:choose>
	<c:when test="${not empty additionalCorrectionFiles }">
		<table class="table table-bordered">
			<thead>
				<tr>				
					<th class="cellCenter height10 fontSize12">
						 <spring:message code="system.version"/>
					</th>
					<th class="cellCenter height10 fontSize12">
						 <spring:message code="system.fileName"/>
					</th>
					<th class="cellCenter height10 fontSize12">
						 <spring:message code="system.uploadDate"/>
					</th>
					<th class="cellCenter height10 fontSize12">
						 <spring:message code="system.action"/>
					</th>
				</tr>
			</thead>
			<tbody>
			<c:forEach var="f" items="${additionalCorrectionFiles}">
				<tr>
					<td class="cellCenter height10 fontSize12">
						<c:if test="${f.galleryProofRevision == 0 }">
							<spring:message code="system.original"/>
						</c:if>
						<c:if test="${f.galleryProofRevision > 0 }">
							<spring:message code="system.revision"/> #${f.galleryProofRevision }
						</c:if>
					</td>
					<td class="cellCenter height10 fontSize12">
					<a href="${baseUrl}/journals/${jnid}/download/${f.id}">${f.originalName}</a>
					</td>
					<td class="cellCenter height10 fontSize12">
					${f.date}
					</td>
					<td class="cellCenter height10 fontSize12">
						<c:if test="${f.galleryProofRevision == manuscript.galleryProofRevision}">
							<button class="btn btn-default btn-xs fileDeleteButton" data-fileId="${f.id }">
								<spring:message code="system.delete"/>
							</button>
						</c:if>
					</td>
				</tr>
			</c:forEach>
			</tbody>
		</table>
	</c:when>
</c:choose>

