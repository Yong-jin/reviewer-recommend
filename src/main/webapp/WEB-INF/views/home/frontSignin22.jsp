<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="customTag" uri="http://manuscriptlink.com/customTags" %>

<!DOCTYPE html>
<!--[if lt IE 7]>      <html class="no-js lt-ie9 lt-ie8 lt-ie7"> <![endif]-->
<!--[if IE 7]>         <html class="no-js lt-ie9 lt-ie8"> <![endif]-->
<!--[if IE 8]>         <html class="no-js lt-ie9"> <![endif]-->
<!--[if gt IE 8]><!--> <html class="no-js"> <!--<![endif]-->
<head>
<title>MANUSCRIPTLINK Home</title>
<%@ include file="/WEB-INF/views/includes/header.jsp" %>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta content="width=device-width, initial-scale=1.0" name="viewport"/>
<meta content="" name="description"/>
<meta content="" name="author"/>
<!-- BEGIN GLOBAL MANDATORY STYLES -->

<!-- END GLOBAL MANDATORY STYLES -->
<!-- BEGIN THEME STYLES -->
<link href="${baseUrl}/assets/css/plugins.css" rel="stylesheet" type="text/css"/>
<link href="${baseUrl}/assets/css/pages/login.css" rel="stylesheet" type="text/css"/>
<link href="${baseUrl}/css/custom.css" rel="stylesheet" type="text/css"/>
<!-- END THEME STYLES -->
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
	  width: 400px;
		max-width:400px;
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

<body class="login">
<div class="row frontSignin marginTop-20 ">
	<!-- BEGIN LOGO -->
	<div class="logo">
		<span class="logo_first">MANUSCRIPT</span><span class="logo_second">LINK</span>
	</div>
	<!-- END LOGO -->
</div>
<div class="row">
<div class="col-md-push-3 col-md-5" id="image">
<span id="lineblank"><br/><br/><br/></span>
<br/>
<img width="55%" src="${baseUrl}/js/homes/corporate/img/sliders/revolution/publication.png" alt="Image 1">
</div>
<div class="col-md-push-1 col-md-3" id="register">
<!-- BEGIN LOGIN -->
<div class="content">
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
			<label class="checkbox">
				<a href="#" rel="tooltip" data-html="true" title="<spring:message code='system.staySignedIn'/>">
				<input type="checkbox" id="remember" name="_spring_security_remember_me" value="true"/>
				<span class="staySignedIn"><spring:message code='system.staySignedInTag'/></span>
				</a>
			</label>
			<button type="submit" class="btn green btn-sm pull-right">
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
		<div class="create-account">
			<h4><spring:message code='system.dontYouKnowML'/></h4>
			<p>
				<a href="${baseUrl}/promotion">
					 <button type="button" class="btn yellow btn-xs"><spring:message code='system.goToPomotion'/></button>
				</a>
			</p>
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
	<!-- END FORGOT PASSWORD FORM -->
	

	<!-- END REGISTRATION FORM -->
</div>
<!-- END LOGIN -->
</div>
</div>


<footer>
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

<script src="${baseUrl}/js/homes/signin.js" type="text/javascript"></script>
<script>
jQuery(document).ready(function() {
	Login.init();

	var offset = new Date(); 
	setCookie("TimeOffset", offset.getTimezoneOffset(), 365);
	
  $("a[rel='tooltip']").tooltip({
	  'placement': 'bottom', 
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
});

function setCookie(cookieName, cookieValue, nDays) {
	var today = new Date();
	var expire = new Date();
	if (nDays == null || nDays == 0) nDays = 1;
	expire.setTime(today.getTime() + 3600000 * 24 * nDays);
	document.cookie = cookieName + "=" + escape(cookieValue) + ";expires=" + expire.toGMTString() + "; path=${baseUrl}/";
}
</script>
</footer>
</body>
<!-- END BODY -->
</html>