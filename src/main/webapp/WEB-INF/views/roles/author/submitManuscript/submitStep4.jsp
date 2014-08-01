<%@ taglib prefix="customTagFile" tagdir="/WEB-INF/tags" %>
<%@ page import="link.thinkonweb.configuration.SystemConstants" %>
<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8 no-js"> <![endif]-->
<!--[if IE 9]> <html lang="en" class="ie9 no-js"> <![endif]-->
<!--[if !IE]><!-->
<html lang="en" class="no-js">
<!--<![endif]-->
<head>
<title>Step 4</title>
	<%@ include file="/WEB-INF/views/includes/header.jsp" %>
	<link href="${baseUrl}/assets/plugins/bootstrap-fileinput/bootstrap-fileinput.css" rel="stylesheet" type="text/css"/>
	<link href="${baseUrl}/assets/plugins/jquery-file-upload/blueimp-gallery/blueimp-gallery.min.css" rel="stylesheet"/>
	<link href="${baseUrl}/assets/plugins/jquery-file-upload/css/jquery.fileupload.css" rel="stylesheet"/>
	<link href="${baseUrl}/assets/plugins/jquery-file-upload/css/jquery.fileupload-ui.css" rel="stylesheet"/>
	<link href="${baseUrl}/css/custom.css" rel="stylesheet" type="text/css"/>
</head>
<input type="hidden" id="jnid" value="${jnid }"/>
<input type="hidden" id="baseUrl" value="${baseUrl }"/>
<body>
<%@ include file="/WEB-INF/views/includes/headerBar.jsp" %>
<div class="page-container">
<div class="container">
		<div class="row page-boxed">
			<div class="col-md-12">
				<customTagFile:breadcrumb link_1="${baseUrl}/journals/${jnid }" label_1="system.journalHome"
																	link_2="${baseUrl}/journals/${jnid}/author/" label_2="user.role.journal_member"
																	link_3="${baseUrl}/journals/${jnid}/author/submitManuscript/" label_3="author.menu.submitNewManuscript"/>
																	
				<div class="tabbable tabbable-custom tabbable-full-width">
					<ul class="nav nav-tabs">
						<li class="active">
							<a href="#tab_1_1" data-toggle="tab">
								<spring:message code="author.menu.submitNewManuscript"/>
							</a>
						</li>
					</ul>
					<div class="tab-content">
						<div class="tab-pane active" id="tab_1_1">
							<div class="portlet" id="form_wizard_1">
								<div class="portlet-body form">
									<div class="form-wizard">
										<%@ include file="/WEB-INF/views/roles/author/submitManuscript/formWizardNavigation.jsp" %>
										<div class="tab-content">
											<div class="tab-pane active submitManuscriptTab" id="tab4">
												<h3 class="block"><spring:message code="author.newPaperSubmit.tabMenu.4"/></h3>
												<c:if test="${jc.textFiles != null and fn:trim(jc.textFiles) != ''}">
													<div class="row" id="textCoverLetter">
														<label class="control-label col-md-2">
															<p style="text-align:right"><i class="fa fa-bullhorn "></i></p>
														</label>
														<div class="col-md-10">
															<div class="portlet">
																<div class="portlet-body">
																	<fieldset class="col-md-11 ">
																		<table class="table textByManager">
																			<tr>
																				<td style="border-top: 1px solid #FFF;">
																					${jc.textFiles}
																				</td>
																			</tr>
																		</table>
																	
																	</fieldset>
																</div>
															</div>
														</div>
													</div>
													<div class="row">
														<div class="col-md-2">
														</div>
														<div class="col-md-9 paddingLeft30">
															<hr class="soften"/>
														</div>
													</div>
													<br/>
												</c:if>
												<div class="row">
													<label class="control-label col-md-2">
														<p style="text-align:right; font-size: 14px">
															<span class="required">*</span>
															<spring:message code="manuscript.manuscriptFiles"/> <i class="fa fa-caret-right smallFontAwesome "></i>
														</p>
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
												<form id="fileupload" enctype="multipart/form-data">
													<!-- The fileupload-buttonbar contains buttons to add/delete files and start/cancel the upload -->
													<div class="row fileupload-buttonbar">
														<label class="control-label col-md-2">
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
																		
																	</div>
																</div>
															</div>
														</div>
													</div>
												</form>
												<c:set var="additionalFileNeeded" value="false"/>
												<c:if test="${(jc.frontCoverUrl != null and fn:trim(jc.frontCoverUrl) != '') or (jc.checkListUrl != null and fn:trim(jc.checkListUrl) != '')}">
													<c:if test="${manuscript.revisionCount == 0 or jc.changeAdditionalFiles == true }">
														<c:set var="additionalFileNeeded" value="true"/>
													</c:if>
												</c:if>
												
												<c:if test="${additionalFileNeeded == true }">
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
														<p style="text-align:right; font-size: 14px">
															<c:if test="${jc.requiredAdditionalFiles == true}"><span class="required">*</span></c:if>
															<spring:message code="manuscript.additionalFiles"/> <i class="fa fa-caret-right smallFontAwesome "></i>
														</p>
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
												<form id="additionalFileupload" enctype="multipart/form-data">
													<div class="row fileupload-buttonbar">
														<label class="control-label col-md-2">
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
												<br/>
												<br/>
												<div class="row">
													<div class="col-md-offset-2 col-md-10">
														<form id="submit_form" action="${baseUrl}/journals/${jnid}/author/submitManuscript/step4" method="POST" class="form-horizontal">
															<div class="row">
																<div class="col-md-5 formRight">
																	<div id="way"></div>
																	<button type="button"id="back" class="btn default btn-previous">
																		<i class="m-icon-swapleft"></i> <spring:message code="system.gotoback2"/>
																	</button>
																</div>
																<div class="col-md-offset-1 col-md-6 pull-left">
																	<button type="button" id="saveAndContinue" class="btn blue btn-next">
																		<spring:message code="author.newPaperSubmit.saveAndContinue"/> <i class="m-icon-swapright m-icon-white"></i>
																	</button>
																</div>
															</div>
														</form>
													</div>
												</div>
												<br/>
												<br/>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<footer>
<div class="clearfix"></div>  
<%@ include file="/WEB-INF/views/includes/footerBar.jsp" %>
<script src="${baseUrl}/assets/plugins/jquery-validation/dist/jquery.validate.min.js" type="text/javascript" ></script>
<script src="${baseUrl}/assets/plugins/jquery-validation/dist/additional-methods.min.js" type="text/javascript" ></script>
<script src="${baseUrl}/assets/plugins/bootstrap-wizard/jquery.bootstrap.wizard.min.js" type="text/javascript" ></script>
<script src="${baseUrl}/assets/plugins/fancybox/source/jquery.fancybox.pack.js"></script>
<script src="${baseUrl}/js/roles/jquery.fileupload.js"></script>
<script src="${baseUrl}/js/roles/author/submitFormWizard.js"></script>
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
	SubmitFormWizard.init("${baseUrl}/journals/${jnid}", "${manuscript.submitStep}", 4);
	
	$(".fileDesignationSelect").select2({
		allowClear: false,
		dropdownAutoWidth: true,
		escapeMarkup: function (m) {
			return m;
		},
		containerCssClass: "muted"
	});
	
    $('#fileupload').fileupload({
        url : "${baseUrl}/journals/${jnid}/author/submitManuscript/upload.action",
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
    			url: "${baseUrl}/journals/${jnid}/author/submitManuscript/uploadedFileTable",
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
		url: "${baseUrl}/journals/${jnid}/author/submitManuscript/uploadedFileTable",
		success:function(html) {
			$("#uploadedFileView").html(html).show();
		}
	});
	var frontCoverUrl = "${jc.frontCoverUrl}";
	var checkListUrl = "${jc.checkListUrl}";
	

    <c:if test="${additionalFileNeeded == true}">
		$(".additionalFileDesignationSelect").select2({
			allowClear: false,
			dropdownAutoWidth: true,
			escapeMarkup: function (m) {
				return m;
			},
			containerCssClass: "muted"
		});
		
		
	    $('#additionalFileupload').fileupload({
	        url : "${baseUrl}/journals/${jnid}/author/submitManuscript/additionalUpload.action",
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
	    			url: "${baseUrl}/journals/${jnid}/author/submitManuscript/additionalUploadedFileTable",
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
			url: "${baseUrl}/journals/${jnid}/author/submitManuscript/additionalUploadedFileTable",
			success:function(html) {
				$("#additionalUploadedFileView").html(html).show();
			}
		});
    </c:if>
	
	jQuery("#back").click(function(event) {
		event.preventDefault();
		$('#way').html('<input type="hidden" name="way" value="Back"/>');
		$('#submit_form').submit();
	});
	jQuery("#saveAndContinue").click(function(event) {
		event.preventDefault();
		var url = "${baseUrl}/journals/${jnid}/author/submitManuscript/validateFileCount";
		jQuery.ajax({
			type:"GET",
			url: url,
			success:function(html){
				var fileCountValidate = html;
				if(fileCountValidate == false) {
					bootbox.alert(errorMessages['author.newPaperSubmit.checkFiles']);
		            var form = $('#submit_form');
		            var error = $('.alert-danger', form);
		            error.show();
					App.scrollTo(form);
				} else {
					$('#way').html('<input type="hidden" name="way" value="Forward"/>');
					$('#submit_form').submit();
				}
			}
		});
	});
	var li_list = $('.centerMenu');
	var index = Number("${menuNumber}");
	jQuery(li_list[index]).addClass("active");
});
</script>
</footer>
</body>
</html>