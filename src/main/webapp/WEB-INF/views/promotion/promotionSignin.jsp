<!DOCTYPE html>
<!--[if lt IE 7]>      <html class="no-js lt-ie9 lt-ie8 lt-ie7"> <![endif]-->
<!--[if IE 7]>         <html class="no-js lt-ie9 lt-ie8"> <![endif]-->
<!--[if IE 8]>         <html class="no-js lt-ie9"> <![endif]-->
<!--[if gt IE 8]><!--> <html class="no-js"> <!--<![endif]-->
<head>
<title>Sign In</title>
<%@ include file="/WEB-INF/views/includes/header.jsp" %>
<link href="${baseUrl}/assets/css/pages/login.css" rel="stylesheet" type="text/css"/>
<link href="${baseUrl}/css/custom.css" rel="stylesheet" type="text/css"/>
<style>
.tooltip{
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
}

.tooltip.left{
    margin-left:0px
}

a[rel='tooltip'] {
		color: #000000;
}

a[rel='tooltip']:hover {
		text-decoration:none;
		color: #000000;
}
</style>
</head>



<body class="page-header-fixed">
<div class="login">
<%@ include file="/WEB-INF/views/includes/promotionHeaderBar.jsp" %>
<br/>
<br/>
<br/>
<br/>
<c:if test="${not empty messageForSignin}" >
	<br />
	<br />
	<div class="text-center">
		<h4><c:out value="${messageForSignin}"/></h4>
	</div>
	<br />
	</c:if>

<div class="row">
<div class="content col-md-3 center">
	<!-- BEGIN LOGIN FORM -->
	<form class="login-form" action="j_spring_security_check" method="post">
		<h3 class="form-title"><spring:message code='system.loginToAccount'/></h3>
		<c:if test="${signinError != null}">
			<div class="alert alert-danger">
				<button class="close" data-close="alert"></button>
				<span>
					 <spring:message code="signin.badCredentials"/>
				</span>
			</div>
		</c:if>
		<div class="form-group">
			<!--ie8, ie9 does not support html5 placeholder, so we just show field title for that-->
			<label class="control-label visible-ie8 visible-ie9"><spring:message code="signin.email"/></label>
			<div class="input-icon">
				<i class="fa fa-user"></i>
				<input class="form-control placeholder-no-fix" type="text" placeholder="<spring:message code='signin.email'/>" name="j_username"/>
			</div>
		</div>
		<div class="form-group">
			<label class="control-label visible-ie8 visible-ie9"><spring:message code="signin.password"/></label>
			<div class="input-icon">
				<i class="fa fa-lock"></i>
				<input class="form-control placeholder-no-fix" type="password" placeholder="<spring:message code='signin.password'/>" name="j_password"/>
			</div>
		</div>
		<div class="form-actions">
			<label class="checkbox2" style="margin-top: 10px;">
				<a href="#" rel="tooltip" data-html="true" title="<spring:message code='system.staySignedIn'/>">
				<input type="checkbox" id="remember" name="_spring_security_remember_me" value="true"/>
				<span class="staySignedIn"><spring:message code='system.staySignedInTag'/></span>
				</a>
			</label>
			<button type="submit" class="btn green pull-right">
			<spring:message code='system.login'/> <i class="m-icon-swapright m-icon-white"></i>
			</button>
		</div>
		<!--
		<div class="login-options">
			<h4>Or login with</h4>
			<ul class="social-icons">
				<li>
					<a class="facebook" data-original-title="facebook" href="#">
					</a>
				</li>
				<li>
					<a class="twitter" data-original-title="Twitter" href="#">
					</a>
				</li>
				<li>
					<a class="googleplus" data-original-title="Goole Plus" href="#">
					</a>
				</li>
				<li>
					<a class="linkedin" data-original-title="Linkedin" href="#">
					</a>
				</li>
			</ul>
		</div>
		-->
		<div class="forget-password">
			<h4 class="forgotPassword"><spring:message code='system.forgotPassword'/></h4>
			<p>
				<spring:message code='system.forgotPassworDesc1'/> <a href="javascript:;" id="forget-password"><spring:message code='system.here'/></a><spring:message code='system.forgotPassworDesc2'/> 
			</p>
		</div>
		<div class="create-account">
			<h4 class="accountCreation"><spring:message code='system.accountCreation'/></h4>
			<p style="margin-top: -7px">
				<spring:message code='system.accountCreationDesc1'/>	 
				<a href="${baseUrl}/signup" id="register-btn"><spring:message code='system.here'/></a><spring:message code='system.accountCreationDesc2'/>
			</p>
		</div>
	</form>
	<!-- END LOGIN FORM -->
	<!-- BEGIN FORGOT PASSWORD FORM -->
	<form class="forget-form" action="index.html" method="post">
		<h3><spring:message code='system.forgotPassword'/></h3>
		<p>
			 <spring:message code='system.forgotPassworDesc3'/>
		</p>
		<div class="form-group">
			<div class="input-icon">
				<i class="fa fa-envelope"></i>
				<input class="form-control placeholder-no-fix" type="text" placeholder="<spring:message code='signin.email'/>" name="email"/>
			</div>
		</div>
		<div class="form-actions">
			<button type="button" id="back-btn" class="btn">
			<i class="m-icon-swapleft"></i> <spring:message code='system.gotoback'/> </button>
			<button type="submit" class="btn green pull-right">
			<spring:message code='system.submit'/> <i class="m-icon-swapright m-icon-white"></i>
			</button>
			<br/><br/><br/><br/><br/>
		</div>
	</form>
	<!-- END FORGOT PASSWORD FORM -->
</div>
</div>


<br/>
<br/>
<br/>
<br/>
<br/>
<footer>
<%@ include file="/WEB-INF/views/includes/footerBar.jsp" %>
<script src="${baseUrl}/assets/plugins/jquery-validation/dist/jquery.validate.js" type="text/javascript" ></script>
<script src="${baseUrl}/assets/plugins/jquery-validation/dist/additional-methods.min.js" type="text/javascript"></script>
<script src="${baseUrl}/js/homes/signin.js" type="text/javascript"></script>
</footer>

<script>
jQuery(document).ready(function() {
	Login.init();
	
  $("a[rel='tooltip']").tooltip({
	  'placement': 'right', 
	})
});
</script>
</div>
</body>
<!-- END BODY -->
</html>