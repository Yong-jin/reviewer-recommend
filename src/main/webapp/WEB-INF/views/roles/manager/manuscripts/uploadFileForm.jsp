<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="link.thinkonweb.configuration.SystemConstants" %>
<%@ include file="/WEB-INF/views/includes/headerForAjax.jsp" %>
<link href="${baseUrl}/assets/plugins/jquery-file-upload/blueimp-gallery/blueimp-gallery.min.css" rel="stylesheet"/>
<link href="${baseUrl}/assets/plugins/jquery-file-upload/css/jquery.fileupload.css" rel="stylesheet"/>
<link href="${baseUrl}/assets/plugins/jquery-file-upload/css/jquery.fileupload-ui.css" rel="stylesheet"/>

<div id ="modal-header" class="modal-header">
	<h4 class="modal-title">Upload File</h4>
</div>
<div class="modal-body">
	<div class="row">
		<label class="control-label col-md-2">
		</label>
		<div class="col-md-10">
			<div class="portlet">
				<div class="portlet-body">
					<div class="col-md-11">
						<div id="uploadedFileView"><div class="loadingCenter"><img src="images/loading.gif"/></div></div>						
					</div>
				</div>
			</div>
		</div>
	</div>
	<br/>
	<form id="fileupload" enctype="multipart/form-data">
		<!-- The fileupload-buttonbar contains buttons to add/delete files and start/cancel the upload -->
		<input type="hidden" name="manuscriptId" value="${manuscript.id }"/>
		<div class="row fileupload-buttonbar">
			<label class="control-label col-md-2">
				<spring:message code="author.newPaperSubmit.fileUpload.none"/>
			</label>
			<div class="col-md-10">
				<div class="portlet">
					<div class="portlet-body">
						<div class="col-md-11">
							<div class="panel panel-normal">
								<div class="panel-heading">
									<h3 class="panel-title"><spring:message code="system.uploadFiles"/></h3>
								</div>
								<div class="panel-body">
									<div class="col-md-9">
										<select id="fileDesignationSelect" name="fileDesignationId" class="form-control input-sm select2 fileDesignationSelect">
											<c:forEach var="fileDesignation" items="${fileDesignations }">
												<option value="${fileDesignation.id }"><spring:message code="author.newPaperSubmit.fileDesignation.${fileDesignation.id}"/></option>
											</c:forEach>
										</select>
										<span id="fileDesignationSelect-help-block" class="help-block">
										</span>
									</div>
									<div class="col-md-2">
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
							
						</div>
					</div>
				</div>
			</div>
		</div>
	</form>
	
	<c:if test="${(jc.frontCoverUrl != null and fn:trim(jc.frontCoverUrl) != '') or (jc.checkListUrl != null and fn:trim(jc.checkListUrl) != '')}">
	<br/>
	<div class="row">
		<div class="col-md-2">
		</div>
		<div class="col-md-9 paddingLeft30">
			<hr class="soften"/>
		</div>
	</div>
	<br/>
	<div class="row">
		<label class="control-label col-md-2">
		</label>
		<div class="col-md-10">
			<div class="portlet">
				<div class="portlet-body">
					<div class="col-md-11">
						<div id="additionalUploadedFileView"><div class="loadingCenter"><img src="images/loading.gif"/></div></div>						
					</div>
				</div>
			</div>
		</div>
	</div>
	<br/>
	<form id="additionalFileupload" enctype="multipart/form-data">
		<!-- The fileupload-buttonbar contains buttons to add/delete files and start/cancel the upload -->
		<input type="hidden" name="manuscriptId" value="${manuscript.id }"/>
		<div class="row fileupload-buttonbar">
			<label class="control-label col-md-2">
				<spring:message code="author.newPaperSubmit.additionalFileUpload.none"/>
			</label>
			<div class="col-md-10">
				<div class="portlet">
					<div class="portlet-body">
						<div class="col-md-11">
							<div class="panel panel-normal">
								<div class="panel-heading">
									<h3 class="panel-title"><spring:message code="system.uploadAdditionalFiles"/></h3>
								</div>
								<div class="panel-body">
									<div class="col-md-9">
										<select id="additionalFileDesignationSelect" name="designation" class="form-control input-sm select2 additionalFileDesignationSelect">
											<c:if test="${jc.frontCoverUrl != null and fn:trim(jc.frontCoverUrl) != ''}"><option value="<%=SystemConstants.fileTypeFC%>"><spring:message code="author.newPaperSubmit.additionalFileDesignation.0"/></option></c:if>
											<c:if test="${jc.checkListUrl != null and fn:trim(jc.checkListUrl) != ''}"><option value="<%=SystemConstants.fileTypeCHK%>"><spring:message code="author.newPaperSubmit.additionalFileDesignation.1"/></option></c:if>
										</select>
										<span id="additionalFileDesignationSelect-help-block" class="help-block">
										</span>
									</div>
									<div class="col-md-2">
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
							<c:if test="${(jc.frontCoverUrl != null and fn:trim(jc.frontCoverUrl) != '') or (jc.checkListUrl != null and fn:trim(jc.checkListUrl) != '')}">
							&nbsp;&nbsp;&nbsp;&nbsp;<b><spring:message code="system.templateFiles"/></b><br/><br/>
							<c:if test="${jc.frontCoverUrl != null and fn:trim(jc.frontCoverUrl) != ''}">
								&nbsp;&nbsp;&nbsp;&nbsp;<spring:message code="author.newPaperSubmit.additionalFileDesignation.0"/>: <a href="${jc.frontCoverUrl}">${jc.frontCoverUrl}</a><br/>
							</c:if>
							<c:if test="${jc.checkListUrl != null and fn:trim(jc.checkListUrl) != ''}">
								&nbsp;&nbsp;&nbsp;&nbsp;<spring:message code="author.newPaperSubmit.additionalFileDesignation.1"/>: <a href="${jc.checkListUrl}">${jc.checkListUrl}</a><br/>
							</c:if>
							</c:if>
						</div>
					</div>
				</div>
			</div>
		</div>
	</form>
	</c:if>
</div>
<script>
var errorMessages = new Array();
errorMessages['author.newPaperSubmit.keywordRequired'] = "<spring:message code='author.newPaperSubmit.keywordRequired' javaScriptEscape='true' />";
errorMessages['author.newPaperSubmit.minLength'] = "<spring:message code='author.newPaperSubmit.minLength' javaScriptEscape='true' />";
errorMessages['author.newPaperSubmit.divisionRequired'] = "<spring:message code='author.newPaperSubmit.divisionRequired' javaScriptEscape='true' />";
errorMessages['author.newPaperSubmit.uploadSuccess'] = "<spring:message code='author.newPaperSubmit.uploadSuccess' javaScriptEscape='true' />";
errorMessages['system.fileUpload.fileSizeExceed'] = "<spring:message code='system.fileUpload.fileSizeExceed' javaScriptEscape='true' />";
errorMessages['system.fileUpload.fileTypeNotAllowed'] = "<spring:message code='system.fileUpload.fileTypeNotAllowed' javaScriptEscape='true' />";
errorMessages['author.newPaperSubmit.checkFiles'] = "<spring:message code='author.newPaperSubmit.checkFiles' javaScriptEscape='true' />";

jQuery(document).ready(function() {       
	
	$(".fileDesignationSelect").select2({
		allowClear: false,
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
    $('#fileupload').fileupload({
        url : "${baseUrl}/journals/${jnid}/manager/manuscripts/upload.action",
        dataType: 'json',
        //replaceFileInput: false,
        add: function(e, data){
        	var isValid = true;
            var uploadFile = data.files[0];
            if (!(/\.(pdf|doc|docx|tar|gzip)$/i).test(uploadFile.name)) {
            		alert(errorMessages['system.fileUpload.fileTypeNotAllowed']);
                isValid = false;
            } else if (uploadFile.size > 10000000) { // 5mb
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
    			url: "${baseUrl}/journals/${jnid}/manager/manuscripts/uploadedFileTable",
    			data: "manuscriptId=${manuscript.id}",
    			success:function(html) {
    	            bootbox.alert(errorMessages['author.newPaperSubmit.uploadSuccess'], function() {
    	            	$("#uploadedFileView").html(html).show();
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
		url: "${baseUrl}/journals/${jnid}/manager/manuscripts/uploadedFileTable",
		data: "manuscriptId=${manuscript.id}",
		success:function(html) {
			$("#uploadedFileView").html(html).show();
		}
	});
	var additionalFileNeeded = true;
	var frontCoverUrl = "${jc.frontCoverUrl}";
	var checkListUrl = "${jc.checkListUrl}";
	if(frontCoverUrl.trim() == '' && checkListUrl.trim() == '')
		additionalFileNeeded = false;
	
	

    if(additionalFileNeeded) {
		$(".additionalFileDesignationSelect").select2({
			allowClear: false,
			dropdownAutoWidth: true,
			escapeMarkup: function (m) {
				return m;
			},
			containerCssClass: "muted"
		});
		
		
	    $('#additionalFileupload').fileupload({
	        url : "${baseUrl}/journals/${jnid}/manager/manuscripts/additionalUpload.action",
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
	    			url: "${baseUrl}/journals/${jnid}/manager/manuscripts/additionalUploadedFileTable",
	    			data: "manuscriptId=${manuscript.id}",
	    			success:function(html) {
	    	            bootbox.alert(errorMessages['author.newPaperSubmit.uploadSuccess'], function() {
	    	            	$("#additionalUploadedFileView").html(html).show();
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
			url: "${baseUrl}/journals/${jnid}/manager/manuscripts/additionalUploadedFileTable",
			data: "manuscriptId=${manuscript.id}",
			success:function(html) {
				$("#additionalUploadedFileView").html(html).show();
			}
		});
    }

});
</script>
