<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/includes/headerForAjax.jsp" %>
<link href="${baseUrl}/assets/plugins/jquery-file-upload/blueimp-gallery/blueimp-gallery.min.css" rel="stylesheet"/>
<link href="${baseUrl}/assets/plugins/jquery-file-upload/css/jquery.fileupload.css" rel="stylesheet"/>
<link href="${baseUrl}/assets/plugins/jquery-file-upload/css/jquery.fileupload-ui.css" rel="stylesheet"/>
<html>
<c:if test="${manuscript.status == 'A' }">
	<h4><spring:message code="author.action.submitCameraReady.long"/></h4>
	<div class="form-section_noborder">
		<div class="row form-group">
			<label class="control-label col-md-2"></label>
			<div class="col-md-9">
				<br/><br/>
				<div id="${pageType}cameraReadyUploadedFileView"><div class="loadingCenter"><img src="images/loading.gif"/></div></div>
				<br/><br/>
			</div>
		</div>
		<div class="row form-group fileupload-buttonbar">
			<label class="control-label col-md-2">
			</label>
			<div class="col-md-9">
				<form id="cameraReadyFileupload" enctype="multipart/form-data">
					<input type="hidden" name="manuscriptId" value="${manuscript.id }"/>
					<div class="panel panel-normal">
						<div class="panel-heading">
							<h3 class="panel-title"><spring:message code="author.action.submitCameraReady.long"/></h3>
						</div>
						<div class="panel-body">
							<div class="col-md-9">
								<select id="${pageType}cameraReadyFileDesignationSelect" name="fileDesignationId" class="form-control input-sm select2 fileDesignationSelect">
									<c:forEach var="fileDesignation" items="${fileDesignations }">
										<option value="${fileDesignation.id}"><spring:message code="author.newPaperSubmit.fileDesignation.${fileDesignation.id}"/></option>
									</c:forEach>
								</select>
								<span id="${pageType}fileDesignationSelect-help-block" class="help-block">
								</span>
							</div>
							<div class="col-md-offset-1 col-md-2">
								<!-- The fileinput-button span is used to style the file input field as button -->
								<span class="btn btn-default fileinput-button marginLeft-19">
									<i class="fa fa-plus"></i>
									<span>
										 <spring:message code="author.newPaperSubmit.addAndUpload"/>
									</span>
									<input type="file" name="files">

								</span>
							</div>
							<br/><br/><br/>
							<ul class="panel-text-ul">
								<li>
									 <spring:message code="system.fileUpload.fileSize"/>: <strong>10 MBytes</strong>
								</li>
								<li>
									 <spring:message code="system.fileUpload.fileType"/>: <strong>pdf, doc, docx, zip, tar, gzip</strong>
								</li>
							</ul>
						</div>
					</div>
				</form>
			</div>
		</div>
		<div class="row form-group">
			<div class="col-md-offset-6 col-md-8">
				<button type="submit" id="confirmButton" class="btn green">
					<spring:message code="author.action.submitCameraReady.confirm"/> <i class="m-icon-swapright m-icon-white"></i>
				</button>
			</div>
		</div>
	</div>
</c:if>
<c:if test="${manuscript.status != 'A' }">
	<h4><spring:message code="system.titleM"/></h4>
	<div class="form-section_noborder">
		<div class="row form-group">
			<label class="control-label col-md-2"></label>
			<div class="col-md-9">
				<br/><br/>
				<div id="${pageType}cameraReadyUploadedFileView"><div class="loadingCenter"><img src="images/loading.gif"/></div></div>
				<br/><br/>
			</div>
		</div>
	</div>
</c:if>
<script>
var url = "${baseUrl}/journals/${jnid}";
var status = "${manuscript.status}";
var errorMessages = new Array();
errorMessages['author.newPaperSubmit.uploadSuccess'] = "<spring:message code='author.newPaperSubmit.uploadSuccess' javaScriptEscape='true' />";
errorMessages['system.fileUpload.fileSizeExceed'] = "<spring:message code='system.fileUpload.fileSizeExceed' javaScriptEscape='true' />";
errorMessages['system.fileUpload.fileTypeNotAllowed'] = "<spring:message code='system.fileUpload.fileTypeNotAllowed' javaScriptEscape='true' />";
errorMessages['system.areYouSure'] = "<spring:message code='system.areYouSure' javaScriptEscape='true' />";

$("select.fileDesignationSelect").select2({
	allowClear: true,
	dropdownAutoWidth: true,
	escapeMarkup: function (m) {
		return m;
	},
	containerCssClass: "muted"
});

$('#cameraReadyFileupload').fileupload({
	url : "${baseUrl}/journals/${jnid}/author/manuscripts/cameraReady/upload.action",
	dataType: 'json',
	//replaceFileInput: false,
	add: function(e, data){
		var isValid = true;
		var uploadFile = data.files[0];
		if (!(/\.(pdf|doc|docx|tar|gzip)$/i).test(uploadFile.name)) {
			alert(errorMessages['system.fileUpload.fileTypeNotAllowed']);
			isValid = false;
		} else if (uploadFile.size > 10000000) { // 10mb
			alert(errorMessages['system.fileUpload.fileSizeExceed']);
			isValid = false;
		} 
		if(isValid)
			data.submit();
	},
	progressall: function(e,data) {
		var progress = parseInt(data.loaded / data.total * 100, 10);
		$('#uploadProgress .bar').css(
			'width',
			progress + '%'
		);
	},
	done: function (e, data) {
		$.ajax({
			type:"GET",
			url: "${baseUrl}/journals/${jnid}/author/manuscripts/${pageType}/cameraReady/uploadedFileTable",
			data: "manuscriptId=${manuscript.id}",
			success:function(html) {
				bootbox.alert(errorMessages['author.newPaperSubmit.uploadSuccess'], function() {
					$("#" + "${pageType}" + "cameraReadyUploadedFileView").html(html).show();
				}); 
			}
		});
	},
	fail: function(){
		alert("server problem");
	}
});

$.ajax({
	type:"GET",
	url: "${baseUrl}/journals/${jnid}/author/manuscripts/${pageType}/cameraReady/uploadedFileTable",
	data: "manuscriptId=${manuscript.id}",
	success:function(html) {
		$("#" + "${pageType}" + "cameraReadyUploadedFileView").html(html).show();
	}
});

$("#confirmButton").click(function(event) {
	bootbox.confirm(errorMessages['system.areYouSure'], function(result) {
		if(result == true) {
			var url = "${baseUrl}/journals/${jnid}/author/manuscripts/cameraReady/uploadedFileCount?manuscriptId=${manuscript.id}";
			$.ajax({
				type:"GET",
				url: url,
				success:function(html){
					var uploadedCount = Number(html);
					if(uploadedCount == 0)
						bootbox.alert(errorMessages['author.newPaperSubmit.checkFiles']);
					else {
						var confirmUrl = "${baseUrl}/journals/${jnid}/author/manuscripts/cameraReady/confirm";
						var data = "manuscriptId=${manuscript.id}";
						$.ajax({
							type:"POST",
							url: confirmUrl,
							data: data,
							success:function(html){
								location.href = "${baseUrl}/journals/${jnid}/author/manuscripts?pageType=accepted";
							}
						});
					}
				}
			});
		}
	});
});
</script>
</html>