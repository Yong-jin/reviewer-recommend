<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/includes/headerForAjax.jsp" %>
<link href="${baseUrl}/css/jquery-ui.css" rel="stylesheet" type="text/css"/>
<link href="${baseUrl}/assets/plugins/jquery-file-upload/blueimp-gallery/blueimp-gallery.min.css" rel="stylesheet"/>
<link href="${baseUrl}/assets/plugins/jquery-file-upload/css/jquery.fileupload.css" rel="stylesheet"/>
<link href="${baseUrl}/assets/plugins/jquery-file-upload/css/jquery.fileupload-ui.css" rel="stylesheet"/>
<html>
<c:choose>
	<c:when test="${manuscript.status == 'G'}">
		<h4><spring:message code="galleryProof.title"/></h4>
		<div class="form-section_noborder">
			<div class="row form-group">
				<label class="control-label col-md-2"></label>
				<div class="col-md-9">
					<div id="${pageType}uploadedFileView"><div class="loadingCenter"><img src="images/loading.gif"/></div></div>
				</div>
			</div>
		</div>
		<c:if test="${manuscript.galleryProofConfirm == true}">
			<div class="row form-group">
				<label class="control-label col-md-4"></label>
				<div class="col-md-8">
					<div>
						<span class="required"><spring:message code="manager.action.publish"/></span><br/><br/>
					</div>
					<div class="col-md-offset-2 col-md-8">
						
						<button id="publish" class="btn green"><spring:message code="manager.action.confirmAndPublish"/> <i class="m-icon-swapright m-icon-white"></i></button>
					</div>
				</div>
			</div>
		</c:if>
	</c:when>
	<c:when test="${manuscript.status == 'P'}">
		<h4><spring:message code="galleryProof.title"/></h4>
		<div class="form-section_noborder">
			<div class="row form-group">
				<label class="control-label col-md-2"></label>
				<div class="col-md-9">
					<div id="${pageType}uploadedFileView"><div class="loadingCenter"><img src="images/loading.gif"/></div></div>
				</div>
			</div>
		</div>
	</c:when>
	<c:otherwise>
		<h4><spring:message code="manager.action.uploadGalleryProof"/></h4>
		<div class="form-section_noborder">
			<div class="row form-group">
				<label class="control-label col-md-2"></label>
				<div class="col-md-9">
					<div id="${pageType}uploadedFileView"><div class="loadingCenter"><img src="images/loading.gif"/></div></div>
					<br/><br/>
				</div>
			</div>
			<div class="row form-group fileupload-buttonbar">
				<label class="control-label col-md-2">
				</label>
				<div class="col-md-9">
					<form id="fileupload" enctype="multipart/form-data">
						<input type="hidden" name="manuscriptId" value="${manuscript.id }"/>
						<div class="panel panel-normal">
							<div class="panel-heading">
								<h3 class="panel-title"><spring:message code="system.uploadFiles"/></h3>
							</div>
							<div class="panel-body">
								<div class="col-md-9">
									<select id="${pageType }fileDesignationSelect" name="fileDesignationId" class="form-control input-sm select2 fileDesignationSelect">
										<option value="galleryProof"><spring:message code="galleryProof.title"/></option>
									</select>
									<span id="${pageType }fileDesignationSelect-help-block" class="help-block">
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
			<div class="row form-group">
				<div class="col-md-offset-5 col-md-8">
					<button type="submit" id="galleryProofConfirmButton" class="btn green">
						<spring:message code="manager.action.sendGalleryProof"/> <i class="m-icon-swapright m-icon-white"></i>
					</button>
				</div>
			</div>
		</div>
	</c:otherwise>
</c:choose> 

<script>
var url = "${baseUrl}/journals/${jnid}";
var status = "${manuscript.status}";
var errorMessages = new Array();
errorMessages['author.newPaperSubmit.uploadSuccess'] = "<spring:message code='author.newPaperSubmit.uploadSuccess' javaScriptEscape='true' />";
errorMessages['system.areYouSure'] = "<spring:message code='system.areYouSure' javaScriptEscape='true' />";

$("select.fileDesignationSelect").select2({
	allowClear: true,
	dropdownAutoWidth: true,
	escapeMarkup: function (m) {
		return m;
	},
	containerCssClass: "muted"
});

$('#fileupload').fileupload({
    url : "${baseUrl}/journals/${jnid}/manager/manuscripts/galleryProof/upload.action",
    dataType: 'json',
    //replaceFileInput: false,
    add: function(e, data){
    	var isValid = true;
        var uploadFile = data.files[0];
        if (!(/pdf|jpe?g|gif/i).test(uploadFile.name)) {
            alert('png, jpg, gif only');
            isValid = false;
        } else if (uploadFile.size > 10000000) { // 5mb
            alert('File size exceeds 10MB');
            isValid = false;
        } 
        if(isValid) {
        	data.submit();
        	App.scrollTo($('#' + "${pageType}" + 'uploadedGalleryProofFiles tr:last'));
    	}
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
			url: "${baseUrl}/journals/${jnid}/manager/manuscripts/${pageType}/galleryProof/uploadedFileTable",
			data: "manuscriptId=${manuscript.id}",
			success:function(html) {
	           $("#" + "${pageType}" + "uploadedFileView").html(html).show();
			}
		});
    },
    fail: function(){
        alert("server problem");
    }
});

$.ajax({
	type:"GET",
	url: "${baseUrl}/journals/${jnid}/manager/manuscripts/${pageType}/galleryProof/uploadedFileTable",
	data: "manuscriptId=${manuscript.id}",
	success:function(html) {
		$("#" + "${pageType}" + "uploadedFileView").html(html).show();
	}
});

$("#galleryProofConfirmButton").click(function(event) {
	bootbox.confirm(errorMessages['system.areYouSure'], function(result) {
		
		if(result == true) {
			var url = "${baseUrl}/journals/${jnid}/manager/manuscripts/galleryProof/uploadedFileCount?manuscriptId=${manuscript.id}";
			$.ajax({
				type:"GET",
				url: url,
				success:function(html){
					var uploadedCount = Number(html);
					if(uploadedCount == 0)
						bootbox.alert("File not uploaded");
					else {
						var confirmUrl = "${baseUrl}/journals/${jnid}/manager/manuscripts/galleryProof/confirm";
						var data = "manuscriptId=${manuscript.id}";
						$.ajax({
							type:"POST",
							url: confirmUrl,
							data: data,
							success:function(html){
								location.href = "${baseUrl}/journals/${jnid}/manager/manuscripts?pageType=accepted";
							}
						});
					}
				}
			});
			

		}
	});
});

$('#publish').click(function(event){
	event.preventDefault();
	bootbox.confirm(errorMessages['system.areYouSure'], function(result) {
		if(result == true) {
			var manuscriptId = "${manuscript.id}";
			$.ajax({
				type:"POST",
				url: "${baseUrl}/journals/${jnid}/manager/manuscripts/galleryProof/publish",
				data: "manuscriptId=" + manuscriptId,
				success: function(html){
		            location.href="${baseUrl}/journals/${jnid}/manager/manuscripts?pageType=published";
				}
			});	
		}
	});
});
</script>

</html>