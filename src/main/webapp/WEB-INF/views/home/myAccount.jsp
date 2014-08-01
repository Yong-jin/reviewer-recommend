<%@ page import="link.thinkonweb.configuration.SystemConstants" %>
<%@ taglib prefix="customTagFile" tagdir="/WEB-INF/tags" %>

<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8 no-js"> <![endif]-->
<!--[if IE 9]> <html lang="en" class="ie9 no-js"> <![endif]-->
<!--[if !IE]><!-->
<html lang="en" class="no-js">
<!--<![endif]-->

<head>
<%@ include file="/WEB-INF/views/includes/header.jsp" %>
<title><spring:message code="system.myAccount"/></title>
<link href="${baseUrl}/assets/plugins/select2/select2.css" rel="stylesheet" type="text/css" />
<link href="${baseUrl}/assets/plugins/select2/select2-metronic.css" rel="stylesheet" type="text/css"/>
<link href="${baseUrl}/assets/plugins/data-tables/DT_bootstrap.css" rel="stylesheet" />
<link href="${baseUrl}/assets/css/plugins.css" rel="stylesheet" type="text/css"/>
<link href="${baseUrl}/assets/plugins/bootstrap-tagsinput/bootstrap-tagsinput.css" rel="stylesheet" type="text/css" />

<link href="${baseUrl}/assets/css/style-metronic.css" rel="stylesheet" type="text/css"/>

<link href="${baseUrl}/assets/css/pages/profile.css" rel="stylesheet" type="text/css"/>
<link href="${baseUrl}/css/custom.css" rel="stylesheet" type="text/css"/>
</head>



<body class="page-header-fixed">
<%@ include file="/WEB-INF/views/includes/headerBar.jsp" %>
<div class="clearfix">
</div>
<div class="page-container">
<div class="container">
	<br/><br/>		
    <div class="container">
		<div class="row page-boxed" style="margin-left: -10px;margin-right: 10px;">
				<div class="tabbable tabbable-custom tabbable-full-width">
					<ul class="nav nav-tabs">
						<li class="active">
							<a href="#tab_1_1" data-toggle="tab">
								 <spring:message code="system.myAccount"/>
							</a>
						</li>
						<li>
							<a href="#tab_1_2" data-toggle="tab">
								 <spring:message code="system.expertises"/>
							</a>
						</li>
					</ul>
					<div class="tab-content">
						<div class="tab-pane active" id="tab_1_1">
							<div class="row">
								<div class="col-md-2">
									<ul class="ver-inline-menu tabbable margin-bottom-10">
										<li class="active">
											<a data-toggle="tab" href="#tab_1-1">
												<i class="fa fa-cog"></i> <spring:message code="system.personalInfo"/>
											</a>
											<span class="after">
											</span>
										</li>
										<c:if test="${isLocalInformationNeeded}">
											<li>
												<a data-toggle="tab" href="#tab_2-2">
													<i class="fa fa-tag"></i> <spring:message code="system.personalLocalInfo"/>
												</a>
											</li>
										</c:if>
										<li>
											<a data-toggle="tab" href="#tab_3-3">
												<i class="fa fa-lock"></i> <spring:message code="system.passwordChange"/>
											</a>
										</li>
										<!--
										<li>
											<a data-toggle="tab" href="#tab_4-4">
												<i class="fa fa-eye"></i> <spring:message code="system.privacySetting"/>
											</a>
										</li>
										-->
									</ul>
								</div>
								<div class="col-md-10">
									<div class="tab-content">
										<div id="tab_1-1" class="tab-pane active">
											<form:form method="post" modelAttribute="user" action="#" class="myaccount-form">
												<form:input path="username" type="hidden" value="${user.username}"/>
												<div class="row">
													<div class="form-group col-md-6">
														<label class="control-label"><spring:message code="signup.email"/></label>
														<input type="text" class="form-control" value="${user.username}" disabled>
													</div>
													<div class="form-group col-md-6">
														<label class="control-label"><spring:message code="user.signupdate"/></label>
														<input type="text" class="form-control" id="signupDateTime1" disabled>
													</div>
												</div>
												
												<div class="row">
													<div class="form-group col-md-6">
														<label class="control-label"><spring:message code="user.firstname"/></label><span class="required">*</span>
														<form:input path="contact.firstName" type="text" class="form-control" value="${user.contact.firstName}"/>
														<span class="help-block">
														</span>
													</div>
													
													<div class="form-group col-md-6">
														<label class="control-label"><spring:message code="myaccount.phone"/></label>
														<form:input path="contact.phone" type="text" placeholder="+1 646 580 6284" class="form-control" value="${user.contact.phone}" />
													</div>
												</div>
												
												<div class="row">
													<div class="form-group col-md-6">
														<label class="control-label"><spring:message code="user.lastname"/></label><span class="required">*</span>
														<form:input path="contact.lastName" type="text" class="form-control" value="${user.contact.lastName}"/>
														<span class="help-block">
														</span>
													</div>
													<div class="form-group col-md-6">
														<label class="control-label"><spring:message code="myaccount.mobile"/></label>
														<form:input path="contact.mobile" type="text" placeholder="+1 711 321 2398" class="form-control" value="${user.contact.mobile}"/>
													</div>
												</div>
												
												<div class="row">
													<div class="form-group col-md-6">
														<label class="control-label"><spring:message code="user.institution"/></label><span class="required">*</span>
														<form:input path="contact.institution" type="text" class="form-control" value="${user.contact.institution}"/>
														<span class="help-block">
														</span>
													</div>												
													<div class="form-group col-md-6">
														<label class="control-label"><spring:message code="myaccount.fax"/></label>
														<form:input path="contact.fax" type="text" placeholder="+1 211 988 1321" class="form-control" value="${user.contact.fax}"/>
													</div>
												</div>
												
												
												<div class="row">
													<div class="form-group col-md-6">
														<label class="control-label"><spring:message code="user.department"/></label>
														<form:input path="contact.department" type="text" class="form-control" value="${user.contact.department}"/>
														<span class="help-block">
														</span>
													</div>
													<div class="form-group col-md-6">
														<label class="control-label"><spring:message code="myaccount.website"/></label>
														<form:input path="contact.website" type="text" placeholder="http://www.mywebsite.com" class="form-control" value="${user.contact.website}"/>
														<span class="help-block">
														</span>
													</div>		
												</div>
												
												<div class="row">
													<div class="form-group country-group col-md-6">
														<label class="control-label"><spring:message code="user.country"/></label><span class="required">*</span>
														<div>
															<form:select path="contact.country" id="select2_country2" class="select2 form-control">
																<form:options items="${countries}" />
															</form:select>
															<span class="help-block">
																<spring:message code="signup.countryHelp"/>
															</span>
														</div>
													</div>
												</div>
												
												<div class="row">
													<div class="form-group degreeDiv col-md-6">
														<label class="control-label"><spring:message code="user.degree"/></label><span class="required">*</span><br/>
														<div class="radio-list degree">
															<c:forEach var="degreeDesignation" items="${degreeDesignations}">
																<label class="radio-inline">
																<form:radiobutton path="contact.degree" value="${degreeDesignation.id}"/> <spring:message code="signin.degreeDesignation.${degreeDesignation.id}"/> </label>
															</c:forEach>				
														</div>
														<span class="help-block">
														</span>
													</div>
												</div>
												
												<div class="row">
													<div class="form-group salutationDiv col-md-6">
														<label class="control-label"><spring:message code="user.salutation"/></label><span class="required">*</span>
														<div class="radio-list salutation">
															<c:forEach var="salutationDesignation" items="${salutationDesignations}">
																<label class="radio-inline">
																<form:radiobutton path="contact.salutation" value="${salutationDesignation.id}"/> <spring:message code="signin.salutationDesignation.${salutationDesignation.id}"/> </label>
															</c:forEach>
														</div>
														<span class="help-block">
														</span>
													</div>
												</div>
												
												<div class="row">
													<div class="form-group col-md-12">
														<label class="control-label"><spring:message code="myaccount.about"/></label>
														<form:textarea path="contact.about" class="form-control" rows="3" placeholder="My primary research interests relate to ..." value="${user.contact.about}" />
													</div>
												</div>
												<div class="margiv-top-10 pull-right">
													<button type="submit" class="btn green" id="infomationChange">
														 <spring:message code="myaccount.saveChange"/>
													</button>
												</div>
											</form:form>
										</div>
										<!-- end tab_1-1 -->
										
										<div id="tab_2-2" class="tab-pane">
											<form:form method="post" modelAttribute="user" action="#" class="myLocalAccount-form">
												<form:input path="username" type="hidden" value="${user.username}"/>
												<div class="row">
													<div class="form-group col-md-6">
														<label class="control-label"><spring:message code="signup.email"/></label>
														<input type="text" class="form-control" value="${user.username}" disabled>
													</div>
													<div class="form-group col-md-6">
														<label class="control-label"><spring:message code="user.signupdate"/></label>
														<input type="text" class="form-control" id="signupDateTime2" disabled>
													</div>
												</div>
												
												<div class="row">
													<div class="form-group col-md-6">
														<label class="control-label"><spring:message code="user.koreanFullName2"/></label><span class="required">*</span>
														<form:input path="contact.localFullName" type="text" class="form-control" value="${user.contact.localFullName}"/>
														<span class="help-block">
														</span>
													</div>
													<div class="form-group jobTitle-group col-md-6">
														<label class="control-label"><spring:message code="user.jobTitle"/></label>
														<div>
															<form:select path="contact.localJobTitle" id="select2_jobTitle" class="select2 form-control">
																<c:forEach var="localJobTitleDesignation" items="${localJobTitleDesignations}">
																	<option value="${localJobTitleDesignation.id}" <c:if test="${localJobTitleDesignation.id == editableUser.contact.localJobTitle}">selected</c:if>><spring:message code="signin.localJobTitleDesignation.${localJobTitleDesignation.id}"/></option>
																</c:forEach>
															</form:select>
															<span class="help-block">
															</span>
														</div>
													</div>
												</div>
												<div class="row">
													<div class="form-group col-md-6">
														<label class="control-label"><spring:message code="user.koreanInstitution"/></label><span class="required">*</span>
														<form:input path="contact.localInstitution" type="text" class="form-control" value="${user.contact.localInstitution}"/>
														<span class="help-block">
														</span>
													</div>
													<div class="form-group col-md-6">
														<label class="control-label"><spring:message code="user.koreanDepartment"/></label>
														<form:input path="contact.localDepartment" type="text" class="form-control" value="${user.contact.localDepartment}"/>
														<span class="help-block">
														</span>
													</div>	
												</div>
								
												<div class="row">
													<div class="form-group col-md-12">
														<spring:message code="user.koreanInfoRequiredMessage"/> 
													</div>
												</div>
												
												<div class="margiv-top-10 pull-right">
													<button type="submit" class="btn green" id="localInfomationChange">
														 <spring:message code="myaccount.saveChange"/>
													</button>
												</div>
											</form:form>
										</div>
										<!--  end tab_2-2 -->
	
										<div id="tab_3-3" class="tab-pane">
											<form method="post" action="#" class="myPassword-form col-md-6">
												<input name="username" type="hidden" value="${user.username}"/>
												<div class="form-group">
													<label class="control-label"><spring:message code="myaccount.password.currentPassword"/></label><span class="required">*</span>
													<input type="password" name="cp" id="cp" class="form-control"/>
													<span class="help-block">
													</span>
												</div>
												<div class="form-group">
													<label class="control-label"><spring:message code="myaccount.password.newPassword"/></label><span class="required">*</span>
													<input type="password" name="np" id="np" class="form-control"/>
													<span class="help-block">
													</span>
												</div>
												<div class="form-group">
													<label class="control-label"><spring:message code="myaccount.password.reNewPassword"/></label><span class="required">*</span>
													<input type="password" name="nrp" id="nrp" class="form-control"/>
													<span class="help-block">
													</span>
												</div>
												<div class="margiv-top-10 pull-right">
													<button type="submit" class="btn green" id="passwordChange">
														 <spring:message code="myaccount.password.changePassword"/>
													</button>
												</div>
											</form>
										</div>
										<!--  end tab_3-3 -->
										<!--
										<div id="tab_4-4" class="tab-pane">
											<form action="#">
												<table class="table table-bordered table-striped">
												<tr>
													<td>
														 Anim pariatur cliche reprehenderit, enim eiusmod high life accusamus..
													</td>
													<td>
														<label class="uniform-inline">
														<input type="radio" name="optionsRadios1" value="option1"/>
														Yes </label>
														<label class="uniform-inline">
														<input type="radio" name="optionsRadios1" value="option2" checked/>
														No </label>
													</td>
												</tr>
												<tr>
													<td>
														 Enim eiusmod high life accusamus terry richardson ad squid wolf moon
													</td>
													<td>
														<label class="uniform-inline">
														<input type="checkbox" value=""/> Yes </label>
													</td>
												</tr>
												<tr>
													<td>
														 Enim eiusmod high life accusamus terry richardson ad squid wolf moon
													</td>
													<td>
														<label class="uniform-inline">
														<input type="checkbox" value=""/> Yes </label>
													</td>
												</tr>
												<tr>
													<td>
														 Enim eiusmod high life accusamus terry richardson ad squid wolf moon
													</td>
													<td>
														<label class="uniform-inline">
														<input type="checkbox" value=""/> Yes </label>
													</td>
												</tr>
												</table>
												<div class="margin-top-10">
													<a href="#" class="btn green">
														 Save Changes
													</a>
													<a href="#" class="btn default">
														 Cancel
													</a>
												</div>
											</form>
										</div>
										-->
										<!--  end tab_4-4 -->
									</div>
								</div>
							</div>
						</div>
						<!--end tab-pane tab_1_1-->
						
						<div class="tab-pane" id="tab_1_2">
							<div class="row">
								<div class="col-md-3" style="width: 24%">
									<spring:message code="profile.expertise.text.1"/><br/> 
									<spring:message code="profile.expertise.text.2"/><br/>
									<spring:message code="profile.expertise.text.3"/>
								</div>
								<div class="col-md-9" style="width: 76%">
									<div class="portlet">
										<div class="portlet-body">
											<div id="formInline" class="form-inline">
												<c:set var="expertiseString" value=""/>
												<c:forEach var="userExpertise" items="${expertises}">
											  	<c:set var="expertiseString" value="${expertiseString},${userExpertise.expertise}"/>
												</c:forEach>
												<input id="tags" type="text" name="expertises" class="tags" autofocus="autofocus" placeholder="  <spring:message code="profile.expertise.text.4"/>   " value="${expertiseString}"/>
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
<%@ include file="/WEB-INF/views/includes/footerBar.jsp" %>
<script src="${baseUrl}/assets/plugins/jquery-validation/dist/jquery.validate.js" type="text/javascript" ></script>
<script src="${baseUrl}/assets/plugins/jquery-validation/dist/additional-methods.min.js" type="text/javascript"></script>
<script src="${baseUrl}/assets/plugins/select2/select2.min.js" type="text/javascript" ></script>
<script src="${baseUrl}/assets/scripts/core/app.js" type="text/javascript"></script>
<script src="${baseUrl}/assets/plugins/bootbox/bootbox.min.js" type="text/javascript"></script>
<script src="${baseUrl}/assets/plugins/bootstrap-tagsinput/bootstrap-tagsinput.js" type="text/javascript"></script>
<!--<script src="${baseUrl}/assets/plugins/bootstrap/js/bootstrap2-typeahead.js" type="text/javascript"></script>-->
<script src="${baseUrl}/js/homes/bootstrap2-typeahead.js" type="text/javascript"></script>
<script src="${baseUrl}/js/homes/myaccount.js" type="text/javascript"></script>
<script src="${baseUrl}/js/moment.js"></script>
</footer>

<script>
var errorMessages = new Array();
errorMessages['user.required.fullnameNative'] = "<spring:message code='user.required.fullnameNative' javaScriptEscape='true' />";
errorMessages['user.required.firstname'] = "<spring:message code='user.required.firstname' javaScriptEscape='true' />";
errorMessages['user.required.lastname'] = "<spring:message code='user.required.lastname' javaScriptEscape='true' />";
errorMessages['user.required.institution'] = "<spring:message code='user.required.institution' javaScriptEscape='true' />";
errorMessages['user.required.department'] = "<spring:message code='user.required.department' javaScriptEscape='true' />";
errorMessages['user.required.localInstitution'] = "<spring:message code='user.required.localInstitution' javaScriptEscape='true' />";
errorMessages['user.required.localDepartment'] = "<spring:message code='user.required.localDepartment' javaScriptEscape='true' />";
errorMessages['user.required.country'] = "<spring:message code='user.required.country' javaScriptEscape='true' />";
errorMessages['user.required.degree'] = "<spring:message code='user.required.degree' javaScriptEscape='true' />";
errorMessages['user.required.salutation'] = "<spring:message code='user.required.salutation' javaScriptEscape='true' />";
errorMessages['user.required.currentPasswordEqual'] = "<spring:message code='user.required.currentPasswordEqual' javaScriptEscape='true' />";
errorMessages['user.required.password'] = "<spring:message code='user.required.password' javaScriptEscape='true' />";	
errorMessages['user.required.passwordConfirm'] = "<spring:message code='user.required.passwordConfirm' javaScriptEscape='true' />";
errorMessages['user.required.passwordEqual'] = "<spring:message code='user.required.passwordEqual' javaScriptEscape='true' />";
errorMessages['user.required.minlength'] = "<spring:message code='user.required.minlength' javaScriptEscape='true' />";	
errorMessages['user.required.maxlength'] = "<spring:message code='user.required.maxlength' javaScriptEscape='true' />";
errorMessages['user.required.website'] = "<spring:message code='user.required.website' javaScriptEscape='true' />";
errorMessages['myaccount.required.newPasswordConfirm'] = "<spring:message code='myaccount.required.newPasswordConfirm' javaScriptEscape='true' />";
errorMessages['myaccount.required.passwordConfirm'] = "<spring:message code='myaccount.required.passwordConfirm' javaScriptEscape='true' />";

var lowercaseWords = ["a", "an", "as", "and", "although", "at", "because", "but", "by", "for", "in", "nor", "of", "on", "or", "so", "the", "to", "up", "yet"];

function capitalize(string) {
    var wordArray = string.split(" "); // Split string to analyze word by word.

    for (var i = 0; i < wordArray.length; i++) {				
				var isLowercaseWord = false;
        if (i != 0) { // First word always in capital
            for (var j = 0; j < lowercaseWords.length; j++) {
                if (wordArray[i] == lowercaseWords[j]) {
                    isLowercaseWord = true;
                    continue;
                }
            }
        }
        if (!isLowercaseWord) {
		        var capitalizedCharacter = wordArray[i].charAt(0).toUpperCase();
		        wordArray[i] = capitalizedCharacter + wordArray[i].substr(1);
        }
    }
    return wordArray.join(" "); // Re-join string
};

jQuery(document).ready(function() {
  App.init();
  myAccount.init();
  	
  var localDateTime = convertUTCDateToLocalDate("${user.signupDate}", "${user.signupTime}", "${locale}");

  $("#signupDateTime1").val(localDateTime);
  $("#signupDateTime2").val(localDateTime);
  
  var tags = $("input[name='expertises']");
  
  tags.tagsinput({
	  confirmKeys: [13, 44, 59, 186, 188],
	  
	  onTagExists: function(item, $tag) {
	  	bootbox.alert("<spring:message code='myaccount.expertiseExistErrot1'/>" + item + "<spring:message code='myaccount.expertiseExistErrot2'/>");
	  },
	  
	  tagClass: function(item) {
	  	return 'label label-info';
	  },
	  
	  itemText: function(item) {
		    return capitalize(item);
		},

	  typeahead: {
		  source: function(query) {
		    if (query.length > 2) {
					return $.get('account/recommendExpertise?query=' + query, function(data, status){
						var maxLength = 0;
				    for (var i in data) {
							if (data[i].length > maxLength) 
							    maxLength = data[i].length; 
				    }
				    if (maxLength > 20) {
					    $(".typeahead").css({"width" : "45%"});	
				    } else if (maxLength > 70) {
					    $(".typeahead").css({"width" : "80%"});						
				    }
					});
		    }
		  }
	  }
		/*	
	  typeahead: {
	    minLength: 0,
	    items: 9999,
		  source: function(query) {
		    if (query.length > 2) {
			    return $.get('account/recommendExpertise?query=' + query, function(data, status){
						var maxLength = 0;
				    for (var i in data) {
							if (data[i].length > maxLength) 
							    maxLength = data[i].length; 
				    }
				    if (maxLength > 30) {
					    $(".typeahead").css({"width" : "50%"});	
				    } else if (maxLength > 70) {
					    $(".typeahead").css({"width" : "70%"});						
				    }
		   		});
		    }
		  }
	  }
	  */
	});
  
  $("a[href='#tab_1_2']").click(function() {
      var visible = true;
      setInterval(
          function()
          {
              if(visible)
                  if($("input[name='expertises']").not(':hidden'))
                  {
                      visible = false;
                	  	tags.tagsinput('focus');
                  }
              else
                  if($("input[name='expertises']").is(':hidden'))
                  {
                      visible = true;
                  }
          }, 1000);
  });
  
  $('#select2_jobTitle').select2();
  
  $("input[name='expertises']").on('itemAdded', function(event) {
	  $.ajax({
      type: 'POST',
      url: 'account/updateExpertise',
      data: $("input[name='expertises']").val(),
      success: function(response) {
   	   	
      },
 	   	error: function(response) {
    		alert("error - " + response);
      }
	  });
  });
  
  $("input[name='expertises']").on('itemRemoved', function(event) {
    bootbox.confirm("Are you sure?", function(result) {
       if (result != false) {
				  $.ajax({
			  		type: 'POST',
			  		url: 'account/updateExpertise',
			  		data: $("input[name='expertises']").val(),
			  		success: function(response) {
				   	
			  		},
				   	error: function(response) {
							alert("error - " + response);
			  		}
				  });
       } else {
	   			$("input[name='expertises']").tagsinput('add', event.item);
       }
    });
	});
});
</script>

<!-- END JAVASCRIPTS -->
</body>
<!-- END BODY -->
</html>