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
						url: "${baseUrl}/journals/${jnid}/manager/manuscripts/uploadedFileTable",
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
<c:choose>
	<c:when test="${not empty manuscript.files }">
		<c:set var="fileExist" value="false"/>
		<c:forEach var="f" items="${manuscript.files}">
			<c:if test="${f.revisionCount == manuscript.revisionCount and (f.designation != 'frontCover' and f.designation != 'checkList')}">
				<c:set var="fileExist" value="true"/>
			</c:if>
		</c:forEach>
		<c:choose>
			<c:when test="${fileExist == true }">
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
						<c:forEach var="f" items="${manuscript.files}">
							<c:if test="${f.revisionCount == manuscript.revisionCount and (f.designation != 'frontCover' and f.designation != 'checkList')}">
								<tr>
									<td class="cellCenter">
										<a href="${baseUrl}/journals/${jnid}/download/${f.id}">${f.originalName}</a>
									</td>
									<td class="cellCenter">
										<c:choose>
											<c:when test="${f.designation == 'mainDocument'}">
												<spring:message code="author.newPaperSubmit.fileDesignation.0"/> (<spring:message code="system.required"/>)
											</c:when>
											<c:when test="${f.designation == 'figureImageDocument'}">
												<spring:message code="author.newPaperSubmit.fileDesignation.1"/> (<spring:message code="system.optional"/>)
											</c:when>
											<c:when test="${f.designation == 'tableDocument'}">
												<spring:message code="author.newPaperSubmit.fileDesignation.2"/> (<spring:message code="system.optional"/>)
											</c:when>
											<c:when test="${f.designation == 'supplementaryFile'}">
												<spring:message code="author.newPaperSubmit.fileDesignation.3"/> (<spring:message code="system.optional"/>)
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
					</tbody>
				</table>
			</c:when>
		</c:choose>
	</c:when>
</c:choose>

