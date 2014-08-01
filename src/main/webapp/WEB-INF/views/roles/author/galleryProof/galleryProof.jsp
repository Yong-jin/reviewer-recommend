<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/includes/headerForAjax.jsp" %>
<html>
<c:if test="${manuscript.galleryProofConfirm == false}">
	<h4><spring:message code="author.action.confirmGalleryProof"/></h4>
</c:if>
<c:if test="${manuscript.galleryProofConfirm == true}">
	<h4><spring:message code="galleryProof.title"/></h4>
</c:if>
<div class="form-section_noborder">
	<div class="row form-group">
		<label class="control-label col-md-2"></label>
		<div class="col-md-9">
			<c:forEach var="index" items="${revisionIndices}">
				<c:if test="${index < maxRevision}">
					<br/>
					<hr class="soften"/>
				</c:if>
				<h5 class="marginLeft0">
					<c:if test="${index == 0}"><spring:message code="galleryProof.title"/> <spring:message code="system.original"/></c:if> 
					<c:if test="${index > 0}"><spring:message code="galleryProof.title"/> <spring:message code="system.revision"/> #${index}</c:if> 
				</h5>
		
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
							</tr>
						</c:if>
					</c:forEach>
					<c:if test="${fileCount == 0 }">
						<tr>
							<td class="cellCenter" colspan="3"><spring:message code="system.notAvailable"/></td>
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
		</div>
	</div>
</div>
<c:if test="${manuscript.status == 'G' and manuscript.galleryProofConfirm == false}">
	<div class="form-section_noborder">
		<div class="row">
			<div class="col-md-offset-2 col-md-10">
				<div class="row">
					<div class="col-md-5 formRight">
						<button id="galleryProofReturnBack" class="btn btn-default"><i class="fa fa-undo"></i> Send Correction</button>
					</div>
					<div class="col-md-offset-1 col-md-6 pull-left">
						<button type="submit" id="confirmButton" class="btn green">
							 <spring:message code="author.action.confirmGalleryProof"/> <i class="m-icon-swapright m-icon-white"></i>
						</button>
					</div>
				</div>
			</div>
		</div>
	</div>
</c:if>
<script>
var errorMessages = new Array();
errorMessages['author.newPaperSubmit.uploadSuccess'] = "<spring:message code='author.newPaperSubmit.uploadSuccess' javaScriptEscape='true' />";
errorMessages['system.areYouSure'] = "<spring:message code='system.areYouSure' javaScriptEscape='true' />";
errorMessages['system.fileUpload.fileSizeExceed'] = "<spring:message code='system.fileUpload.fileSizeExceed' javaScriptEscape='true' />";
errorMessages['system.fileUpload.fileTypeNotAllowed'] = "<spring:message code='system.fileUpload.fileTypeNotAllowed' javaScriptEscape='true' />";
errorMessages['manager.action.writeReason'] = "<spring:message code='manager.action.writeReason' javaScriptEscape='true' />";
$("#confirmButton").click(function(event) {
	bootbox.confirm(errorMessages['system.areYouSure'], function(result) {
		if(result == true) {
			var url = "${baseUrl}/journals/${jnid}/author/manuscripts/galleryProof/confirm";
			var data = "manuscriptId=${manuscript.id}";
			$.ajax({
				type:"POST",
				url: url,
				data: data,
				success:function(html){
					location.href = "${baseUrl}/journals/${jnid}/author/manuscripts?pageType=accepted";
				}
			});
		}
	});
});

$('#galleryProofReturnBack').click(function(event){
	event.preventDefault();
	var manuscriptId = "${manuscript.id}";
	$.ajax({
		type:"GET",
			url: "${baseUrl}/journals/${jnid}/author/manuscripts/galleryProof/returnBack",
			data: "manuscriptId=" + manuscriptId,
			success: function(html){
					$("#galleryProofReturnBackDisplay").html(html);
			}
	});	
	$("#galleryProofReturnBackDisplay").show();
	$("#galleryProofReturnBackDisplay").dialog("open");
	
	
});
$("#galleryProofReturnBackDisplay").dialog({
	width: currentWidth * 0.8,
	height: currentHeight * 0.8,
	resizable: true,
	modal:true,
	autoOpen: false,
 	show: {
		 effect: "slide",
		 duration: 500
	}
	
});
</script>

</html>