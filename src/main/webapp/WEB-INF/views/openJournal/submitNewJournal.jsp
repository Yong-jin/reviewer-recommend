<%@ page import="link.thinkonweb.configuration.SystemConstants" %>
<%@ taglib prefix="customTagFile" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8 no-js"> <![endif]-->
<!--[if IE 9]> <html lang="en" class="ie9 no-js"> <![endif]-->
<!--[if !IE]><!-->
<html lang="en" class="no-js">
<!--<![endif]-->

<head>
<title>Register a new journal service</title>
<%@ include file="/WEB-INF/views/includes/header.jsp" %>
<link href="${baseUrl}/assets/plugins/select2/select2.css" rel="stylesheet" type="text/css" /> 
<link href="${baseUrl}/assets/plugins/select2/select2-metronic.css" rel="stylesheet" type="text/css"/>
<link href="${baseUrl}/assets/css/plugins.css" rel="stylesheet" type="text/css"/>
<link href="${baseUrl}/css/custom.css" rel="stylesheet" type="text/css"/>
<link href="${baseUrl}/css/corporate/imgareaselect-default.css" rel="stylesheet" type="text/css" />
</head>
<body class="page-header-fixed">
    <%@ include file="/WEB-INF/views/includes/headerBar.jsp" %>
	<br/>
	<br/>
	<br/>
	<br/>
    <!-- BEGIN PAGE HEADER-->
    <div class="container">
	<div class="row">
		<div class="col-md-12">
			<!-- BEGIN PAGE TITLE & BREADCRUMB-->
			<h3 class="page-title">
			</h3>
			<ul class="page-breadcrumb breadcrumb">
				<li>
					<i class="fa fa-home"></i>
					<a href="${baseUrl}/promotion">
						<spring:message code="system.promotionHome"/>
					</a>
					<i class="fa fa-angle-right"></i>
				</li>
				<li>
					<a href="submitJournal">
						<spring:message code="home.open"/>
					</a>
				</li>
			</ul>
			<!-- END PAGE TITLE & BREADCRUMB-->
		</div>
	</div>
	</div>
	<!-- END PAGE HEADER-->

	 
    <div class="container">
	
	<div class="row page-boxed">
		<div class="col-md-12">
			<div class="portlet box blue" id="form_wizard_1">
				<div class="portlet-body form">
					<form:form method="post" modelAttribute="journal" class="form-horizontal" id="submit_form" enctype="multipart/form-data">
						<input type="hidden" name="id" value="${journal.id }"/>
						<div class="form-wizard">
							<div class="form-body">
								<ul class="nav nav-pills nav-justified steps">
									<li>
										<a href="#tab1" data-toggle="tab" class="step">
											<span class="number">
												 1
											</span>
											<span class="desc">
												<i class="fa fa-check"></i> <spring:message code="newJournalSubmit.tabMenu.1"/>
											</span>
										</a>
									</li>
									<li>
										<a href="#tab2" data-toggle="tab" class="step">
											<span class="number">
												 2
											</span>
											<span class="desc">
												<i class="fa fa-check"></i> <spring:message code="newJournalSubmit.tabMenu.2"/>
											</span>
										</a>
									</li>
									<li>
										<a href="#tab3" data-toggle="tab" class="step active">
											<span class="number">
												 3
											</span>
											<span class="desc">
												<i class="fa fa-check"></i> <spring:message code="newJournalSubmit.tabMenu.3"/>
											</span>
										</a>
									</li>
								</ul>
								<div id="bar" class="progress progress-striped" role="progressbar">
									<div class="progress-bar progress-bar-success">
									</div>
								</div>
								<div class="tab-content">
									<div class="tab-pane active" id="tab1">
										<!-- <h3 class="block">Provide your journal details</h3> -->
										<div class="form-group">
											<label class="control-label col-md-3"><spring:message code="journal.creator.username"/>
											</label>
											<div class="col-md-6">
												<form:input path="creator.username" type="text" class="form-control" readonly="${journal.creator.username}" disabled="true"/>
											</div>
										</div>
										<div class="form-group">
											<label class="control-label col-md-3"><spring:message code="journal.creator.name"/>
											</label>
											<div class="col-md-6">
												<input type="text" class="form-control" name="name" value="${journal.creator.contact.firstName} ${journal.creator.contact.lastName}" disabled="true" />
											</div>
										</div>
										
										
										<div class="form-group">
											<label class="control-label col-md-3"><spring:message code="journal.category"/>
											<span class="required">
												 *
											</span>
											</label>
											<div class="col-md-6">
												<select name="journalCategory" id="select2_upperCategory" class="select2 form-control">
													<c:forEach var="index" begin="0" end="7" step="1">
														<option value="${index}"><spring:message code="journal.category.${index }"/></option>
													</c:forEach>
												</select>
											</div>
										</div>
										<div class="form-group">
											<label class="control-label col-md-3"><spring:message code="journal.lowerCategory"/>
											<span class="required">
												 *
											</span>
											<br/>
											<small>1) <spring:message code="journal.lowerCategoryDesc1"/></small><br/>
											<small>2) <spring:message code="journal.lowerCategoryDesc2"/></small>
											</label>
											<div class="col-md-6">
												<select id="lowerCategory" multiple class="form-control lowerCategory" style="text-align:left">
												</select>
											</div>
										</div>
										<div class="form-group">
											<label class="control-label col-md-3"><spring:message code="journal.type"/>
											<span class="required">
												 *
											</span>
											</label>
											<div class="col-md-6">
												<select name="type" id="select2_journalType" class="select2 form-control">
													<option value="A"><spring:message code="system.typeA"/></option>
													<option value="B"><spring:message code="system.typeD"/></option>
													<option value="C"><spring:message code="system.typeC"/></option>
													<option value="D"><spring:message code="system.typeD"/></option>
												</select>
											</div>
										</div>
										
										
										<div class="form-group">
											<label class="control-label col-md-3"><spring:message code="journal.journalIdentifier"/> (<spring:message code="journal.journalNameId"/>)
											<span class="required">
												 *
											</span>
											</label>
											<div class="col-md-6">
												<form:input path="journalNameId" type="text" class="form-control" id="journalNameId"/>
												<span class="help-block">
													<spring:message code="journal.info.journalNameId"/>
												</span>
											</div>
										</div>
										<div class="form-group">
											<label class="control-label col-md-3"><spring:message code="journal.title"/>
											<span class="required">
												 *
											</span>
											</label>
											<div class="col-md-6">
												<form:input path="title" type="text" class="form-control"/>
												<span class="help-block">
												</span>
											</div>
										</div>
										<div class="form-group">
											<label class="control-label col-md-3"><spring:message code="journal.shortTitle"/>
											</label>
											<div class="col-md-6">
												<form:input path="shortTitle" type="text" class="form-control"/>
												<span class="help-block">
												</span>
											</div>
										</div>
										<div class="form-group">
											<label class="control-label col-md-3"><spring:message code="journal.homepage"/>
											<span class="required">
												 *
											</span>
											</label>
											<div class="col-md-6">
												<form:input path="homepage" type="text" class="form-control"/>
												<span class="help-block">
												</span>
											</div>
										</div>
										<div class="form-group">
											<label class="control-label col-md-3"><spring:message code="journal.organization"/>
											<span class="required">
												 *
											</span>
											</label>
											<div class="col-md-6">
												<form:input path="organization" type="text" class="form-control"/>
												<span class="help-block">
												</span>
											</div>
										</div>
										
										<div class="form-group country-group">
											<label class="control-label col-md-3"><spring:message code="journal.publisherCountry"/>
											<span class="required">
												 *
											</span>
											</label>
											<div class="col-md-4">
												<form:select path="countryCode" id="select2_country" class="select2 form-control">
													<option value=""></option>
													<%@ include file="/WEB-INF/views/includes/country.jsp" %>
												</form:select>
												<span class="help-block">
												</span>
											</div>
										</div>
										
										<div class="form-group">
											<label class="control-label col-md-3"><spring:message code="journal.language"/>
											<span class="required">
												 *
											</span>
											</label>
											<div class="col-md-4 language">
												<form:select path="languageCode" id="select2_language" class="select2 form-control">
													<option value=""></option>
													<option value="<%=SystemConstants.englishLanguageCode%>"><spring:message code="system.english"/></option>
													<!--  <option value="zh">Chinese</option> -->
													<!--  <option value="ja">Japanese</option> -->
													<option value="<%=SystemConstants.koreanLanguageCode%>"><spring:message code="system.korean"/></option>
												</form:select>
												<span class="help-block">
												</span>
											</div>
										</div>
									</div>

									<div class="tab-pane" id="tab2">
										<!-- <h3 class="block">Provide the journal cover image</h3> -->
										<div class="form-group">
											<div class="form-sub-group-image">
												<label class="control-label col-md-2">Cover Image
												<span class="required">
													 *
												</span>
												</label>
												<div class="col-md-6">
													<input type="file" id="file" name="coverImage" title="Search for an image file to add" class="btn-primary form-control"/>
													<span class="help-block" id="coverImage">
														JPG, JPEG, GIF or PNG (max size: 2MB)
													</span>								   	
												    <div class="uploadImageFrameBefore" id="upload">
												    	<br/><br/><br/><br/><br/>
												    	No Uploaded Image
												    	<br/><br/><br/><br/><br/>
												    </div>
												    <span class="help-block">
												    	<strong class="cropMessage">Select a rectangular area of the above image by moving or resizing the selection area</strong>
												    </span>
												    <br/><br/>
												</div>
											</div>
											<div class="col-md-3 previewDiv">
												<div class="well center">
													<h4>Note:</h4>
													 The following image will be registed just as the one shown and used for your journal cover image in this system.<br/><br/>
													<div class="preview" id="preview">
													</div>
												</div>															
											</div>
										</div>
										
									</div>
									
									<div class="tab-pane" id="tab3">
										<!-- <h3 class="block">Confirm to register your journal manuscript service</h3> -->
										<div class="row">
											<div class="col-md-push-1 col-md-7">
												<h4 class="form-section">Journal Information</h4>
												<div class="form-group">
													<label class="control-label col-md-4"><spring:message code="journal.creator.username"/>:</label>
													<div class="col-md-6">
														<p class="form-control-static" data-display="creator.username">
														</p>
													</div>
												</div>
												<div class="form-group">
													<label class="control-label col-md-4"><spring:message code="journal.creator.name"/>:</label>
													<div class="col-md-6">
														<p class="form-control-static" data-display="name">
														</p>
													</div>
												</div>
												<div class="form-group">
													<label class="control-label col-md-4"><spring:message code="journal.journalNameId"/>:</label>
													<div class="col-md-6">
														<p class="form-control-static" data-display="journalNameId">
														</p>
													</div>
												</div>
												<div class="form-group">
													<label class="control-label col-md-4"><spring:message code="journal.shortTitle"/>:</label>
													<div class="col-md-6">
														<p class="form-control-static" data-display="shortTitle">
														</p>
													</div>
												</div>
												<div class="form-group">
													<label class="control-label col-md-4"><spring:message code="journal.title"/>:</label>
													<div class="col-md-6">
														<p class="form-control-static" data-display="title">
														</p>
													</div>
												</div>
												<div class="form-group">
													<label class="control-label col-md-4"><spring:message code="journal.organization"/>:</label>
													<div class="col-md-6">
														<p class="form-control-static" data-display="organization">
														</p>
													</div>
												</div>
												<div class="form-group">
													<label class="control-label col-md-4"><spring:message code="journal.language"/>:</label>
													<div class="col-md-6">
														<p class="form-control-static" data-display="languageCode">
														</p>
													</div>
												</div>
												<div class="form-group">
													<label class="control-label col-md-4"><spring:message code="journal.publisherCountry"/>:</label>
													<div class="col-md-6">
														<p class="form-control-static" data-display="countryCode" style="width:auto; height:auto; vertical-align: middle;">
														</p>
													</div>
												</div>
											</div>
											
											<div class="col-md-4">
												<h4 class="form-section"><spring:message code="journal.journalCoverImage"/></h4>											
												<div class="previewDivConfirm">
													<div class="center">
														<br/>
														<div class="preview" id="preview">
														</div>
														<br/>
													</div>		
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>

							<div class="row">
								<div class="col-md-12">
									<div class="col-md-offset-1 col-md-2">
										<a href="javascript:;" class="btn default button-previous">
											<i class="m-icon-swapleft"></i> Back
										</a>
									</div>
									<div class="col-md-offset-2 col-md-2">
										<a href="javascript:;" class="btn blue button-next">
											 Continue <i class="m-icon-swapright m-icon-white"></i>
										</a>
									</div>
									<div class="col-md-offset-1">
										<a href="javascript:;" class="btn green button-submit">
											 Submit <i class="m-icon-swapright m-icon-white"></i>
										</a>
									</div>
								</div>
							</div>
						</div>
						<input type="hidden" name="x1" value="" />
						<input type="hidden" name="y1" value="" />
						<input type="hidden" name="x2" value="" />
						<input type="hidden" name="y2" value="" />
						<input type="hidden" name="w" value="" />
						<input type="hidden" name="h" value="" />
						<input type="hidden" name="imgName" value="" />
					</form:form>
				</div>
			</div>
		</div>
	</div>
	<!-- END PAGE CONTENT-->
	</div>
	<!-- END PAGE CONTAINER --> 
<br/>
<br/>
<footer>
<script src="${baseUrl}/js/custom_global.js"></script>
<%@ include file="/WEB-INF/views/includes/footerBar.jsp" %>
<script src="${baseUrl}/assets/plugins/jquery-validation/dist/jquery.validate.js" type="text/javascript" ></script>
<script src="${baseUrl}/assets/plugins/jquery-validation/dist/additional-methods.min.js" type="text/javascript"></script>
<script src="${baseUrl}/assets/plugins/uniform/jquery.uniform.min.js" type="text/javascript"></script>
<script src="${baseUrl}/assets/plugins/select2/select2.min.js" type="text/javascript" ></script>
<script src="${baseUrl}/assets/plugins/bootstrap-hover-dropdown/bootstrap-hover-dropdown.min.js" type="text/javascript"></script>
<script src="${baseUrl}/assets/plugins/jquery-slimscroll/jquery.slimscroll.min.js" type="text/javascript"></script>
<script src="${baseUrl}/assets/plugins/jquery.blockui.min.js" type="text/javascript"></script>
<script src="${baseUrl}/assets/plugins/jquery.cokie.min.js" type="text/javascript"></script>
<script src="${baseUrl}/assets/plugins/bootstrap-wizard/jquery.bootstrap.wizard.min.js" type="text/javascript" ></script>

<script src="${baseUrl}/assets/scripts/core/app.js" type="text/javascript"></script>
<script src="${baseUrl}/js/homes/newJournal-submit.js" type="text/javascript"></script>
<script src="${baseUrl}/js/homes/jquery.imgareaselect.pack.js"></script>
</footer>

<script>
var errorMessages = new Array();
errorMessages['journal.required.journalNameId'] = "<spring:message code='journal.required.journalNameId' javaScriptEscape='true' />";
errorMessages['journal.required.title'] = "<spring:message code='journal.required.title' javaScriptEscape='true' />";
errorMessages['journal.required.shortTitle'] = "<spring:message code='journal.required.shortTitle' javaScriptEscape='true' />";
errorMessages['journal.required.organization'] = "<spring:message code='journal.required.organization' javaScriptEscape='true' />";
errorMessages['journal.required.coverImage'] = "<spring:message code='journal.required.coverImage' javaScriptEscape='true' />";
errorMessages['journal.coverImage.invalidFileType'] = "<spring:message code='journal.coverImage.invalidFileType' javaScriptEscape='true' />";
errorMessages['system.error.minlength'] = "<spring:message code='system.error.minlength' javaScriptEscape='true' />";
errorMessages['system.error.maxlength'] = "<spring:message code='system.error.maxlength' javaScriptEscape='true' />";
errorMessages['journal.coverImage.tooBigSize(2MB)'] = "<spring:message code='journal.coverImage.tooBigSize(2MB)' javaScriptEscape='true' />";
errorMessages['journal.required.language'] = "<spring:message code='journal.required.language' javaScriptEscape='true' />";
errorMessages['journal.required.punlisherCountry'] = "<spring:message code='journal.required.punlisherCountry' javaScriptEscape='true' />";
errorMessages['journal.lowercase.journalNameId'] = "<spring:message code='journal.lowercase.journalNameId' javaScriptEscape='true' />";	
errorMessages['journal.required.homepage'] = "<spring:message code='journal.required.homepage' javaScriptEscape='true' />";	
errorMessages['journal.required.correctURL'] = "<spring:message code='journal.required.correctURL' javaScriptEscape='true' />";
errorMessages['newJournalSubmit.language.help'] = "<spring:message code='newJournalSubmit.language.help' javaScriptEscape='true' />";	
errorMessages['newJournalSubmit.country.help'] = "<spring:message code='newJournalSubmit.country.help' javaScriptEscape='true' />";

jQuery(document).ready(function() {
	App.init();
	FormWizard.init();
	var journalId = "${journal.id}";
	var upperCategory = "${upperCategory}";
    $("#select2_upperCategory").val(upperCategory).attr("selected", "selected");
	$("#select2_upperCategory").select2();
	$.ajax({
		type:"GET",
		url: "submitJournal/getCategories",
		data: "upperCategory=" + upperCategory + "&journalId=" + journalId,
		success:function(html) {
			$('#lowerCategory').html(html).show();
		    <c:forEach var="journalCategory" items="${journalCategories}">
	    		$("#lowerCategory > option[value=" + "${journalCategory.categoryId}" + "]").attr("selected", true);
	    	</c:forEach>
		}
	});
	
    $("#select2_upperCategory").change(function(event) {
   		var selectedValue = $(this).children("option:selected").val();
   		upperCategory = selectedValue;

		$.ajax({
			type:"GET",
			url: "submitJournal/getCategories",
			data: "upperCategory=" + upperCategory + "&journalId=" + journalId,
			success:function(html) {
				$('#lowerCategory').html(html).show();
		   	    <c:forEach var="journalCategory" items="${journalCategories}">
	    			$("#lowerCategory > option[value=" + "${journalCategory.categoryId}" + "]").attr("selected", true);
				</c:forEach>
			}
		});
	});
    
    $("#lowerCategory").change(function(event) {
		var selectedValue = $("#lowerCategory").val();
		$.ajax({
			type:"POST",
			url: "submitJournal/saveJournalInfo",
			data: "name=journalCategory&value=" + selectedValue + "&journalId=" + journalId,
			success:function(html) {
				
			}
		});
	});
    
	$("#select2_journalType").val("${journal.type}").attr("selected", "selected");
	$("#select2_journalType").select2();
	
	$('.previewDiv').hide();
	$('.cropMessage').hide();

	$.validator.addMethod(
        "filesize", 
        function(value, element) {
        	return file.files[0].size < 2097152;
        },
        errorMessages['journal.coverImage.tooBigSize(2MB)']
	);
	
	$.validator.addMethod(
        "lowercase", 
        function(value, element) {
        	var lowerCase= new RegExp("^[a-z0-9_]*$");
        	return (value.match(lowerCase));
        },
        errorMessages['journal.lowercase.journalNameId']
	);

	var form = $('#submit_form');
    var error = $('.alert-danger', form);
    var success = $('.alert-success', form);

    var validator = form.validate({
        doNotHideMessage: true, //this option enables to show the error/success messages on tab switch.
        errorElement: 'span', //default input error message container
        errorClass: 'help-block', // default input error message class
        focusInvalid: false, // do not focus the last invalid input
        rules: {
        		journalNameId: {
                required: true,
        				minlength: 2,
        				maxlength: 20,
        				lowercase: true,
                remote: function () {
                	var r = {
                            url: 'submitJournal/jnidDuplicateCheck?jnid=' + $("#journalNameId").val(),
                            type: "POST",  
                            contentType: "application/json; charset=utf-8",  
                            dataType: "json",  
                    };
                	return r;
                },
            },
            title: {
            		required: true,
        				minlength: 2,
        				maxlength: 200,
            },
            shortTitle: {
            		required: false,
        				minlength: 2,
        				maxlength: 8,
            },
            homepage: {
                required: true,
                url: true,
            },
            organization: {
            		required: true,
        				minlength: 2,
        				maxlength: 300,
            },
            languageCode: {
            		required: true,
            },
            countryCode: {
            		required: true
            },
            coverImage: {
                required: true,
                extension: "png|jpg|jpeg|gif",
                filesize: true,
            }
        },

        messages: { // custom messages for radio buttons and checkboxes
        	  journalNameId: {
                required: errorMessages['journal.required.journalNameId'],
		        		minlength: jQuery.format(errorMessages['system.error.minlength']),
		        		maxlength: jQuery.format(errorMessages['system.error.manlength']),
		        		remote: jQuery.format("{0} is already in use"),
		        		lowercase: errorMessages['journal.lowercase.journalNameId'],
            },
            title: {
	            	required: errorMessages['journal.required.title'], 
	        			minlength: jQuery.format(errorMessages['system.error.minlength']),
	        			maxlength: jQuery.format(errorMessages['system.error.manlength']),
            },
            shortTitle: {
            		required: errorMessages['journal.required.shortTitle'],
        				minlength: jQuery.format(errorMessages['system.error.minlength']),
        				maxlength: jQuery.format(errorMessages['system.error.manlength']),
            },
            homepage: { 
                required: errorMessages['journal.required.homepage'],
                url: errorMessages['journal.required.correctURL'],
            },
            organization: {
            		required: errorMessages['journal.required.organization'],
        				minlength: jQuery.format(errorMessages['system.error.minlength']),
        				maxlength: jQuery.format(errorMessages['system.error.manlength']),
            },
            languageCode: {
            		required: errorMessages['journal.required.language'],
            },
            countryCode: {
            		required: errorMessages['journal.required.punlisherCountry'],
            },
            coverImage: {
                required: errorMessages['journal.required.coverImage'],
                extension: errorMessages['journal.coverImage.invalidFileType'],
                filesize: errorMessages['journal.coverImage.tooBigSize(2MB)'],
            }
        },

        errorPlacement: function (error, element) { // render error placement for each input type
        	if ($(element).attr("name") == "coverImage") {
        		if (typeof ($("#file"))[0].files[0] == 'undefined') {
               		$('.form-sub-group-image').removeClass('has-success').addClass('has-error');
               		$('#coverImage').html(errorMessages['journal.required.coverImage']);
               		return;
        		}
        		if (!(getExtension(file.files[0].name) == 'jpg' || getExtension(file.files[0].name) == 'jpeg' || getExtension(file.files[0].name) == 'gif' || getExtension(file.files[0].name) == 'png')) {
        			$('.form-sub-group-image').removeClass('has-success').addClass('has-error');
            		$('#coverImage').html(errorMessages['journal.coverImage.invalidFileType']);
            		$('div[class="imgareaselect-handle"]').remove();
                	$('div[class="imgareaselect-outer"]').remove();
                	$('img[id="uploadImage"]').imgAreaSelect({ disable: true });
                	$('.previewDiv').hide();
                	$('#upload').removeClass("uploadImageFrame").addClass("uploadImageFrameBefore");
                	$('#upload').html("<br/><br/><br/><br/><br/>No Uploaded Image !!!<br/><br/><br/><br/><br/>");
                	$('img[id="uploadImage"]').hide().remove();
                	$('.cropMessage').hide();
        		}
        		
        		if (file.files[0].size > 2097152) {
            		$('.form-sub-group-image').removeClass('has-success').addClass('has-error');
            		$('#coverImage').html(errorMessages['journal.coverImage.tooBigSize(2MB)']);
            		$('div[class="imgareaselect-handle"]').remove();
                	$('div[class="imgareaselect-outer"]').remove();
                	$('img[id="uploadImage"]').imgAreaSelect({ disable: true });
                	$('.previewDiv').hide();
                	
                	$('#upload').removeClass("uploadImageFrame").addClass("uploadImageFrameBefore");
                	$('#upload').html("<br/><br/><br/><br/><br/>No Uploaded Image<br/><br/><br/><br/><br/>");
                	$('img[id="uploadImage"]').hide().remove();
                	$('.cropMessage').hide();
        		}
        		
        	} else {
        		element.next('span.help-block').replaceWith(error);
        	}
        },

        invalidHandler: function (event, validator) { //display error alert on form submit   
            App.scrollTo(error, -200);
        },

        highlight: function (element) { // hightlight error inputs
            $(element)
                .closest('.form-group').removeClass('has-success').addClass('has-error'); // set error class to the control group
        },

        unhighlight: function (element) { // revert the change done by hightlight
            $(element)
                .closest('.form-group').removeClass('has-error'); // set error class to the control group
        },

        success: function (errorLabel, element) {
        	if ($(element).attr("name") == "coverImage") {
        		if (typeof ($("#file"))[0].files[0] == 'undefined'
        			&& (getExtension(file.files[0].name) == 'jpg' || getExtension(file.files[0].name) == 'jpeg' || getExtension(file.files[0].name) == 'gif' || getExtension(file.files[0].name) == 'png')
        			&& file.files[0].size <= 2097152 ) {
		        		$('.form-sub-group-image').removeClass('has-error').addClass('has-success');
        				$('#coverImage').html("success!");
        		}
        	} else if ($(element).attr('id') == "select2_language") {
      			$("#select2_language").select2({
      				containerCssClass: "mySpecialClass2"
      			});
      			errorLabel
	                .addClass('valid') 
	            		.closest('.form-group').removeClass('has-error').addClass('has-success');	
  			} else if ($(element).attr('id') == "select2_country") {
      			$("#select2_country").select2({
      				containerCssClass: "mySpecialClass2"
      			});
                errorLabel
	                .addClass('valid') 
	            	.closest('.form-group').removeClass('has-error').addClass('has-success');
            } else { // display success icon for other inputs
                errorLabel
                    .addClass('valid') 
                		.closest('.form-group').removeClass('has-error').addClass('has-success'); 
            }
        },

        submitHandler: function(form) {
            form.submit();
            //add here some ajax code to submit your form or just call form.submit() if you want to submit the form without ajax
        }
    });
	    		
	$('input[id="file"]').change(function(){
		validator.element( "#file" );
		if (typeof ($("#file"))[0].files[0] == 'undefined') {
			return true;
		}
		if (!(getExtension(file.files[0].name) == 'jpg' || getExtension(file.files[0].name) == 'jpeg' || getExtension(file.files[0].name) == 'gif' || getExtension(file.files[0].name) == 'png')) {
			return true;
		}
		if (file.files[0].size > 2097152) {
			return true;
		}
		//$('input[type=file]').rules("remove");
		//success!
		$('div[class="imgareaselect-handle"]').remove();
    	$('div[class="imgareaselect-outer"]').remove();
		$('#upload').removeClass("uploadImageFrameBefore").addClass("uploadImageFrame");
		$('.cropMessage').show();
		
		//console.log(validator.numberOfInvalids());

	  	var oMyForm = new FormData();
	  	oMyForm.append("file", file.files[0]);
	  	
		$.ajax({
			url: 'submitJournal/coverImageUpload',
			data: oMyForm,
		    dataType: 'text',
		    processData: false,
		    contentType: false,
		    type: 'POST',
		    success: function(data){
		    	var htmlSource = data.split("-----");
		      	$('div[id="upload"]').html(htmlSource[0]);
		      	$('div[id="preview"]').html(htmlSource[1]);
		      	$('em[id="cropMessage"]').show();
		      	
		      	isCoverImageShown = true;
		      	coverImageHeight = parseInt(300 + 500 * htmlSource[3] / htmlSource[2]);
		      	saveFileName = htmlSource[4];
		    }
		});
		
		$('.previewDiv').show();
		$('.form-sub-group-image').removeClass('has-error').addClass('has-success');
		$('#coverImage').html("success!");
		$('img[id="uploadImage"]').imgAreaSelect({hide:true});		
		return true;
	});
});

function preview(img, selection) {
    var scaleX = 150 / (selection.width || 1);
    var scaleY = 210 / (selection.height || 1);
    
    $('img[id="previewImage"]').css({
        width: Math.round(scaleX * img.width) + 'px',
        height: Math.round(scaleY * img.height) + 'px',
        marginLeft: '-' + Math.round(scaleX * selection.x1) + 'px',
        marginTop: '-' + Math.round(scaleY * selection.y1) + 'px'
    });
    
	$('input[name="x1"]').val(selection.x1);
	$('input[name="y1"]').val(selection.y1);
	$('input[name="x2"]').val(selection.x2);
	$('input[name="y2"]').val(selection.y2);
	$('input[name="w"]').val(img.width);
	$('input[name="h"]').val(img.height);
	$('input[name="imgName"]').val(saveFileName);   
};

function imgSelInitial() {
	var coords;
	var height = ( this.width / 5 ) * 7;
    if( height <= this.height ){     
		var diff = ( this.height - height ) / 2;
		coords = { x1 : 0 + 10, y1 : diff + 14, x2 : this.width - 10, y2 : height + diff - 14 };
    } else { // if new height out of bounds, scale width instead
		var width = ( this.height / 7 ) * 5; 
		var diff = ( this.width - width ) / 2;
		coords = { x1 : diff + 10, y1 : 0 + 14, x2 : width + diff - 10, y2: this.height - 14 };
    }   
	$( this ).imgAreaSelect(coords);	
	$('input[name="imgName"]').val(saveFileName);
};
</script>

<!-- END JAVASCRIPTS -->
</body>
<!-- END BODY -->
</html>