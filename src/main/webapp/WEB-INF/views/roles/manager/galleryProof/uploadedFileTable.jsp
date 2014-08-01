<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/includes/headerForAjax.jsp" %>
<script>
$('.fileDeleteButton').click(function(event){
	event.preventDefault();
	var t = $(this);
	bootbox.confirm(errorMessages['system.areYouSure'], function(result) {
		if(result == true) {
			var fileId = t.attr("data-fileId");
			var url = "${baseUrl}/journals/${jnid}/delete/galleryProof/" + fileId;
			var data = "manuscriptId=${manuscript.id}";
			$.ajax({
				type:"POST",
				url: url,
				success:function(html) {
					$.ajax({
						type:"GET",
						url: "${baseUrl}/journals/${jnid}/manager/manuscripts/${pageType}/galleryProof/uploadedFileTable",
						data: data,
						success:function(html) {
							$("#" + "${pageType}" + "uploadedFileView").html(html).show();
						}
					});
				}
			});
		}
	});
});

</script>
<c:forEach var="index" items="${revisionIndices}">
	<c:if test="${index < maxRevision}">
		<br/>
		<hr class="soften"/>
	</c:if>
	<h5 class="marginLeft0">
		<c:if test="${index == 0}"><spring:message code="galleryProof.title"/> <spring:message code="system.original"/></c:if> 
		<c:if test="${index > 0}"><spring:message code="galleryProof.title"/> <spring:message code="system.revision"/> #${index}</c:if> 
	</h5>

	<table class="table table-bordered" id="${pageType }uploadedGalleryProofFiles">
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
				<c:if test="${manuscript.status == 'M' and index == maxRevision}">
				<th class="cellCenter">
					 <spring:message code="system.action"/>
				</th>
				</c:if>
			</tr>
		</thead>
		<tbody>
		<c:set var="fileCount" value="0"/>
		<c:forEach var="f" items="${galleryProofFiles}">
			<c:if test="${f.galleryProofRevision == index}">
				<c:set var="fileCount" value="${fileCount+1 }"/>
				<tr>
					<td class="cellCenter">
						<a href="${baseUrl}/journals/${jnid}/download/${f.id}">${f.originalName}</a>
					</td>
					<td class="cellCenter">
						<spring:message code="galleryProof.title"/>
					</td>
					<td class="cellCenter">
						${f.date}
					</td>
					<c:if test="${manuscript.status == 'M' and index == maxRevision}">
					<td class="cellCenter">
						
						<button class="btn btn-default btn-xs fileDeleteButton" data-fileId="${f.id }">
							<spring:message code="system.delete"/>
						</button>
					</td>
					</c:if>
				</tr>
			</c:if>
		</c:forEach>
		<c:if test="${fileCount == 0 }">
			<tr>
				<c:set var="colspanSize" value="3"/>
				<c:if test="${manuscript.status == 'M' and index == maxRevision}">
					<c:set var="colspanSize" value="4"/>
				</c:if>
				<td class="cellCenter" colspan = "${colspanSize }"><spring:message code="system.noDataInTable"/></td>
			</tr>
		</c:if>
		</tbody>
	</table>
	<c:set var="correctionExist" value="false"/>
	<c:if test="${not empty galleryProofCorrectionFiles}">
		<c:forEach var="gpcf" items="${galleryProofCorrectionFiles}">
			<c:if test="${gpcf.galleryProofRevision == index}">
				<c:set var="correctionExist" value="true"/>
			</c:if>
		</c:forEach>
	</c:if>

	<c:if test="${correctionExist == true}">
		<br/><br/>
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
				</tr>
			</thead>
			<tbody>
				<c:forEach var="gpcf" items="${galleryProofCorrectionFiles}">
					<c:if test="${gpcf.galleryProofRevision == index}">
						<tr>
							<td class="cellCenter">
								<a href="${baseUrl}/journals/${jnid}/download/${gpcf.id}">${gpcf.originalName}</a>
							</td>
							<td class="cellCenter">
								<spring:message code="author.action.galleryProofCorrection"/>
							</td>
							<td class="cellCenter">
								${gpcf.date}
							</td>
						</tr>
						<c:set var="commentExist" value="false"/>
						<c:if test="${not empty comments}">
							<c:forEach var="comment" items="${comments }">
								<c:if test="${comment.galleryProofRevision == index and comment.fromRole == 'ROLE_MEMBER' and comment.toRole == 'ROLE_MANAGER' and comment.status == 'G' }">
									<c:set var="commentExist" value="true"/>
								</c:if>
							</c:forEach>
						</c:if>
						<c:if test="${commentExist == true}">
							<tr>
								<td colspan="3">
									<c:forEach var="comment" items="${comments }">
										<c:if test="${comment.galleryProofRevision == index and comment.fromRole == 'ROLE_MEMBER' and comment.toRole == 'ROLE_MANAGER' and comment.status == 'G' }">
											${comment.textHtml } <small>(${comment.date} ${comment.time})</small><br/>
										</c:if>
									</c:forEach>
								</td>
							</tr>
						</c:if>
					</c:if>
				</c:forEach>
			</tbody>
		</table>
	</c:if>
	<c:if test="${correctionExist == false }">
		<c:set var="commentExist" value="false"/>
		<c:if test="${not empty comments}">
			<c:forEach var="comment" items="${comments }">
				<c:if test="${comment.galleryProofRevision == index and comment.fromRole == 'ROLE_MEMBER' and comment.toRole == 'ROLE_MANAGER' and comment.status == 'G' }">
					<c:set var="commentExist" value="true"/>
				</c:if>
			</c:forEach>
		</c:if>
		<c:if test="${commentExist == true}">
			<br/><br/>
			<table class="table table-bordered">
				<tr>
					<td>
						<c:forEach var="comment" items="${comments }">
							<c:if test="${comment.galleryProofRevision == index and comment.fromRole == 'ROLE_MEMBER' and comment.toRole == 'ROLE_MANAGER' and comment.status == 'G' }">
								${comment.textHtml } <small>(${comment.date} ${comment.time})</small><br/>
							</c:if>
						</c:forEach>
					</td>
				</tr>
			</table>
		</c:if>
	</c:if>
</c:forEach>

