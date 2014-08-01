<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/includes/headerForAjax.jsp" %>
<script>
$('.fileDeleteButton').click(function(event){
	event.preventDefault();
	var t = $(this);
	var designation = t.attr("data-designation");
	bootbox.confirm("<spring:message code='system.areYouSure'/>", function(result) {
		if(result == true) {
			var fileId = t.attr("data-fileId");
			var url = "${baseUrl}/journals/${jnid}/delete/" + designation + "/" + fileId;
			$.ajax({
				type:"POST",
				url: url,
				success:function(html) {
					$.ajax({
						type:"GET",
						url: "${baseUrl}/journals/${jnid}/author/submitManuscript/uploadedFileTable",
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
<c:set var="fileExist" value="false"/>
<c:if test="${not empty manuscript.files }">
	
	<c:forEach var="f" items="${manuscript.files}">
		<c:if test="${f.revisionCount == manuscript.revisionCount and (f.designation != 'frontCover' and f.designation != 'checkList')}">
			<c:set var="fileExist" value="true"/>
		</c:if>
	</c:forEach>
</c:if>
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
		<c:if test="${fileExist == true }">
			<c:forEach var="f" items="${manuscript.files}">
				<c:if test="${f.revisionCount == manuscript.revisionCount and (f.designation != 'frontCover' and f.designation != 'checkList')}">
					<tr>
						<td class="cellCenter">
							<a href="${baseUrl}/journals/${jnid}/download/${f.id}">${f.originalName}</a>
						</td>
						<td class="cellCenter">
							<c:choose>
								<c:when test="${f.designation == 'mainDocument'}">
									<spring:message code="author.newPaperSubmit.fileDesignation.0"/>
								</c:when>
								<c:when test="${f.designation == 'figureImageDocument'}">
									<spring:message code="author.newPaperSubmit.fileDesignation.1"/>
								</c:when>
								<c:when test="${f.designation == 'tableDocument'}">
									<spring:message code="author.newPaperSubmit.fileDesignation.2"/>
								</c:when>
								<c:when test="${f.designation == 'supplementaryFile'}">
									<spring:message code="author.newPaperSubmit.fileDesignation.3"/>
								</c:when>
							</c:choose>
						</td>
						<td class="cellCenter">
							${f.date}
						</td>
						<td class="cellCenter">
							<button class="btn btn-default btn-xs fileDeleteButton" data-fileId="${f.id }" data-designation="${f.designation }">
								<spring:message code="system.delete"/>
							</button>
						</td>
					</tr>
				</c:if>
			</c:forEach>
		</c:if>
		<c:if test="${fileExist == false }">
			<tr>
				<td colspan="4" class="cellCenter">
					<spring:message code="system.noDataInTable"/>
				</td>
			</tr>
		</c:if>
	</tbody>
</table>

