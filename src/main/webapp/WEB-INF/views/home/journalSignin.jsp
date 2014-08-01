<!DOCTYPE html>
<!--[if lt IE 7]>      <html class="no-js lt-ie9 lt-ie8 lt-ie7"> <![endif]-->
<!--[if IE 7]>         <html class="no-js lt-ie9 lt-ie8"> <![endif]-->
<!--[if IE 8]>         <html class="no-js lt-ie9"> <![endif]-->
<!--[if gt IE 8]><!--> <html class="no-js"> <!--<![endif]-->
<head>
<title>${journal.shortTitle} - Sign In</title>
<%@ include file="/WEB-INF/views/includes/header.jsp" %>
<link href="${baseUrl}/assets/css/pages/login.css" rel="stylesheet" type="text/css"/>
<link href="${baseUrl}/css/custom.css" rel="stylesheet" type="text/css"/>
<c:if test="${locale == 'en_US'}" >
</c:if>
<style>
/* .tooltip{
    position:absolute;
    z-index:1020;
    display:block;
    visibility:visible;
    padding:5px;
    font-size:12px;
    opacity:0;
    filter:alpha(opacity=0)
}

.tooltip-inner {
		max-width:220px;
    color:#000;
    text-align:center;
    text-decoration:none;
    background-color:#fff;
    border-style:solid;
    border-width:2px;
    border-left-width:2px;
} */

.tooltip.left{
    margin-left:0px
}

a[rel='tooltip'] {
		color: #000000;
		width:220px;
}

a[rel='tooltip']:hover {
		text-decoration:none;
		color: #000000;
}
</style>
</head>



<body class="loginJournal">
<br/>
<div class="clearfix">
</div>
<h3 class="text-center"><strong>${journal.title}</strong></h3>
<div class="content">
<h3 class="text-center"><spring:message code='system.maintitle'/></h3>
<hr/>

<div class="row">
<div class="col-md-4">
<img src="${baseUrl}/images/coverImages/${journal.coverImageFilename}" width="150px" height="210px" />
</div>
<div class="col-md-push-1 col-md-7">
<spring:message code='system.welcome_message1' arguments="${journal.title}" htmlEscape="false"/>
<spring:message code='system.welcome_message2'/>
</div>
</div>
<hr/>

<!--  
<div>
<h5>
This journal is not yet set up completely. Click <a class="noicon" href="${baseUrl}/journalSetup/${journal.journalNameId}"><img src="${baseUrl}/images/icons/set1/gear_32.png" border="0" /></a> to set up it.
</h5>
</div>
-->

<!-- BEGIN LOGIN FORM -->
	<form class="login-form" action="${baseUrl}/j_spring_security_check" method="post">
		<h3 class="form-title"><spring:message code='system.loginToAccount'/></h3>
		<c:if test="${signinError != null}">
			<div class="alert alert-danger">
				<button class="close" data-close="alert"></button>
				<span>
					 <spring:message code="signin.badCredentials"/>
				</span>
			</div>
		</c:if>
		<div class="row">
			<div class="col-md-6" style="border-right:1px dashed">
				<div class="form-group">
					<!--ie8, ie9 does not support html5 placeholder, so we just show field title for that-->
					<label class="control-label visible-ie8 visible-ie9"><spring:message code="signin.email"/></label>
					<div class="input-icon">
						<i class="fa fa-user"></i>
						<input class="form-control placeholder-no-fix" type="text" placeholder="<spring:message code='signin.email'/>" name="j_username" value="${loginUsername }"/>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label visible-ie8 visible-ie9"><spring:message code="signin.password"/></label>
					<div class="input-icon">
						<i class="fa fa-lock"></i>
						<input class="form-control placeholder-no-fix" type="password" placeholder="<spring:message code='signin.password'/>" name="j_password"/>
					</div>
				</div>
				<div class="row">
					<div class="col-md-8" style="margin-left: 20px">
						<label class="checkbox">
							<a href="#" class="tooltipAnchor" rel="tooltip" data-html="true" title="<spring:message code='system.staySignedIn'/>">
							<input type="checkbox" id="remember" name="_spring_security_remember_me" value="true"/>
							<span class="staySignedIn"><spring:message code='system.staySignedInTag'/></span>
							</a>
						</label>
					</div>
					<div class="col-md-2" style="margin-left: 18px">
						<button type="submit" class="btn green pull-right btn-sm">
						<spring:message code='system.login'/> <i class="m-icon-swapright m-icon-white"></i>
					</button>
					</div>
				</div>
			</div>
			
			<div class="col-md-6">
				<div class="forget-password">
					<!--
					<button class="btn btn-primary disabled center">
					<i class="fa fa-sitemap"></i> Welcome to ${journal.shortTitle}
					</button>
					<br/>
					-->
					<h4 class="forgotPassword"><spring:message code='system.forgotPassword'/></h4>
					<p>
						<spring:message code='system.forgotPassworDesc1'/> <a href="javascript:;" id="forget-password"><spring:message code='system.here'/></a><spring:message code='system.forgotPassworDesc2'/> 
					</p>
				</div>
				<br/>
				<div class="create-account">
					<h4 class="accountCreation"><spring:message code='system.accountCreation'/></h4>
					<p style="margin-top: -3px">
						<spring:message code='system.accountCreationDesc1'/>	 
						<a href="journals/${journal.journalNameId}/journalSignup" id="register-btn"><spring:message code='system.here'/></a><spring:message code='system.accountCreationDesc2'/>
					</p>
				</div>
			</div>
		</div>
	</form>
	<!-- END LOGIN FORM -->
	<!-- BEGIN FORGOT PASSWORD FORM -->
	<form class="forget-form" method="post">
		<div class="forgetPasswordDiv">
			<h3><spring:message code='system.forgotPassword'/></h3>
			<p>
				 <spring:message code='system.forgotPassworDesc3'/>
			</p>
			<div class="form-group">
				<div class="input-icon">
					<i class="fa fa-envelope"></i>
					<input class="form-control placeholder-no-fix" type="text" placeholder="<spring:message code='signin.email'/>" name="username"/>
				</div>
			</div>
			<div>
				<button type="button" id="back-btn" class="btn">
				<i class="m-icon-swapleft"></i> <spring:message code='system.gotoback'/> </button>
				<button type="submit" id="forgetPasswordSubmitButton" class="btn green pull-right">
				<spring:message code='system.submit'/> <i class="m-icon-swapright m-icon-white"></i>
				</button>
			</div>
			<br/><br/>
		</div>
	</form>
</div>
<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!--[if lt IE 9]>
  <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
  <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
<![endif]-->

<!-- BEGIN CORE PLUGINS -->
<!--[if lt IE 9]>
<script src="${baseUrl}/assets/plugins/excanvas.min.js"></script> 
<![endif]-->  
<script src="${baseUrl}/assets/plugins/jquery-1.10.2.min.js" type="text/javascript"></script>
<script src="${baseUrl}/assets/plugins/jquery-migrate-1.2.1.min.js" type="text/javascript"></script>
<script src="${baseUrl}/assets/plugins/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>      
<script src="${baseUrl}/js/homes/corporate/plugins/hover-dropdown.js" type="text/javascript" ></script>
<script src="${baseUrl}/js/homes/corporate/plugins/back-to-top.js" type="text/javascript"></script>    
<!-- END CORE PLUGINS -->
<script src="${baseUrl}/assets/plugins/jquery-validation/dist/jquery.validate.js" type="text/javascript" ></script>
<script src="${baseUrl}/assets/plugins/jquery-validation/dist/additional-methods.min.js" type="text/javascript"></script>
<script src="${baseUrl}/assets/plugins/bootbox/bootbox.min.js" type="text/javascript"></script>
<script src="${baseUrl}/js/homes/journalSignin.js" type="text/javascript"></script>
<script>
jQuery(document).ready(function() {
	Login.init();
	jQuery('.forget-form').hide();
	
	var offset = new Date(); 
	setCookie("TimeOffset", offset.getTimezoneOffset(), 365);
	
	$("a[rel='tooltip']").tooltip({
		  'placement': 'top', 
	})
});

$('#forgetPasswordSubmitButton').click(function(event) {
	event.preventDefault();
	var url = "${baseUrl}/resetPassword";
	var data = $('.forget-form').serialize();
	$.ajax({
		type:"POST",
		url: url,
		data: data,
		success:function(html) {
			bootbox.alert("New password has sent to your email account");
			
		}
	});
});

function setCookie(cookieName, cookieValue, nDays) {
	var today = new Date();
	var expire = new Date();
	if (nDays == null || nDays == 0) nDays = 1;
	expire.setTime(today.getTime() + 3600000 * 24 * nDays);
	document.cookie = cookieName + "=" + escape(cookieValue) + ";expires=" + expire.toGMTString() + "; path=${baseUrl}/";
}
</script>	
</body>