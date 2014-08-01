<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/includes/headerForAjax.jsp" %>
<link href="${baseUrl}/assets/plugins/jquery-file-upload/blueimp-gallery/blueimp-gallery.min.css" rel="stylesheet"/>
<link href="${baseUrl}/assets/plugins/jquery-file-upload/css/jquery.fileupload.css" rel="stylesheet"/>
<link href="${baseUrl}/assets/plugins/jquery-file-upload/css/jquery.fileupload-ui.css" rel="stylesheet"/>

<div id ="modal-header" class="modal-header">
	<h4 class="modal-title"><spring:message code="author.action.galleryProofCorrection"/></h4>
</div>
<div class="modal-body">
	<form:form commandName="comment" class="form-horizontal" id="commentForm">
	<div class="row">
		<label class="control-label col-md-2">
			<spring:message code="mail.subject"/>:
		</label>
		<div class="col-md-10">
			<fieldset class="col-md-11">
				<div class="form-group">
					<input type="text" id="subject" name="subject" maxlength="10000" value="${emailMessage.subject}" class="form-control" readonly>
				</div>
			</fieldset>
		</div>
	</div>
	<div class="row">
		<label class="control-label col-md-2">
			<spring:message code="mail.text"/>:
		</label>
		<div class="col-md-10">
			<fieldset class="col-md-11">
				<div class="form-group">
					<textarea rows="15" cols="" id="body" name="body" class="form-control" readonly>
${emailMessage.body}
					</textarea>
					<span class="required">(<spring:message code="system.replaceCommentMessage"/>)</span>
				</div>
			</fieldset>
		</div>
	</div>
	<div class="row">
		<label class="control-label col-md-2">
			<spring:message code="author.action.galleryProofCorrectionMessage"/>:
		</label>
		<div class="col-md-9">
			<textarea rows="7" cols="" id="text" name="text" maxlength="10000" class="form-control"></textarea>
		</div>
	</div>
	</form:form>
	<br/><br/>
	<div class="row">
		<label class="control-label col-md-2">
			<spring:message code="author.action.uploadedGalleryProofCorrection"/>:
		</label>
		<div class="col-md-9">
			<div id="galleryProofCorrectionUploadedFileView"><div class="loadingCenter"><img src="images/loading.gif"/></div></div>
			
		</div>
	</div>
	<br/><br/>
	<div class="row fileupload-buttonbar">
		<label class="control-label col-md-2">
		</label>
		<div class="col-md-9">
			<form id="galleryProofFileupload" enctype="multipart/form-data">
				<input type="hidden" name="manuscriptId" value="${manuscript.id }"/>
				<div class="panel panel-normal">
					<div class="panel-heading">
						<h3 class="panel-title"><spring:message code="author.action.uploadGalleryProof"/></h3>
					</div>
					<div class="panel-body">
						<div class="col-md-8">
							<select id="galleryProofFileDesignationSelect" class="form-control input-sm select2 fileDesignationSelect">
								<option value="GalleryProof Correction"><spring:message code="author.action.galleryProofCorrection"/></option>
							</select>
							<span id="fileDesignationSelect-help-block" class="help-block">
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
								 <spring:message code="system.fileUpload.fileSize"/>: <strong>10 MB</strong>
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
	<div class="row">
		<div class="col-md-12">
			<div class="col-md-offset-5 col-md-7">
				<button id="returnBack" class="btn btn-default"><i class="fa fa-undo"></i> <spring:message code="author.action.sendCorrection"/></button>
			</div>
		</div>
	</div>
</div>
<script>
$(document).ready(function() {
	$(".fileDesignationSelect").select2({
		allowClear: true,
		dropdownAutoWidth: true,
		escapeMarkup: function (m) {
			return m;
		},
		containerCssClass: "muted"
	});
	
	$('.select2-choice').css("color", "#000 !important");
	$('.select2-choice:hover').css("color", "#000 !important");
	$('.select2-chosen').css("color", "#000 !important");
	$('.select2-chosen:hover').css("color", "#000 !important");
	$('#galleryProofFileupload').fileupload({
		url : "${baseUrl}/journals/${jnid}/author/manuscripts/additionalCorrection/upload.action",
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
				url: "${baseUrl}/journals/${jnid}/author/manuscripts/additionalCorrection/uploadedFileTable",
				data: "manuscriptId=${manuscript.id}",
				success:function(html) {
					$("#galleryProofCorrectionUploadedFileView").html(html).show();
				}
			});
		},
		fail: function(){
			alert("server problem");
		}
	});
		
		
	$.ajax({
		type:"GET",
		url: "${baseUrl}/journals/${jnid}/author/manuscripts/additionalCorrection/uploadedFileTable",
		data: "manuscriptId=${manuscript.id}",
		success:function(html) {
			$("#galleryProofCorrectionUploadedFileView").html(html).show();
		},
		error:function(request, status, error) {
			$("#galleryProofCorrectionUploadedFileView").html(html).show();
		}
	});
	
	
	$("#returnBack").click(function(event) {
		event.preventDefault();
		var text = $('#text').val();
		if(text.trim() == "")
			alert("<spring:message code='manager.action.writeReason' javaScriptEscape='true' />");
		else
			$('#commentForm').submit();
	
	}); 
});
</script>
