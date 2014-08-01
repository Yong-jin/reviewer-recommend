<!DOCTYPE html>
<!--[if lt IE 7]>      <html class="no-js lt-ie9 lt-ie8 lt-ie7"> <![endif]-->
<!--[if IE 7]>         <html class="no-js lt-ie9 lt-ie8"> <![endif]-->
<!--[if IE 8]>         <html class="no-js lt-ie9"> <![endif]-->
<!--[if gt IE 8]><!--> <html class="no-js"> <!--<![endif]-->
<head>
<title>404 error page</title>
<%@ include file="/WEB-INF/views/includes/header.jsp" %>
<link href="${baseUrl}/assets/css/plugins.css" rel="stylesheet" type="text/css"/>
<link href="${baseUrl}/assets/css/pages/error.css" rel="stylesheet" type="text/css"/>
<link href="${baseUrl}/css/custom.css" rel="stylesheet" type="text/css"/>
<!-- END GLOBAL MANDATORY STYLES -->
<!-- BEGIN THEME STYLES -->

</head>



<body class="page-header-fixed">

<div class="clearfix">
</div>

<div class="page-container">
	<!-- BEGIN CONTENT -->
	<div class="page-content-wrapper">
		<div class="page-content">
			
			<div class="row page-404">
				<div class="number col-md-push-1 col-md-4">
					 404
				</div>
				<div class="details col-md-push-2 col-md-4">
					<br/>
					<h3>Oops! You're lost.</h3>
					<p>
						 We can not find the page you're looking for.<br/>
						 Actually, the page you are looking for does not exist.<br/>		
					</p>
					<br/>
					<div class="row">
						<div class="col-md-3">
							<button id="back" class="button positive" value="<spring:message code='system.gotoback'/>" >
								<img src="${baseUrl}/images/icons/set2/rewind_16.png" alt=""/> <spring:message code="system.gotoback"/>
							</button>
						</div>
						
						<div class="col-md-5">
							<button id="gotopromotion" class="button positive" value="<spring:message code='system.gotoPromotion'/>" >
								<img src="${baseUrl}/images/icons/set2/arrow_up_16.png" alt=""/> <spring:message code="system.gotoPromotion"/>
							</button>
						</div>
					</div>	
				</div>
			</div>
			<!-- END PAGE CONTENT-->
		</div>
		<!-- BEGIN CONTENT -->
	</div>
	
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
<script>
jQuery(document).ready(function() {
	var offset = new Date(); 
	setCookie("TimeOffset", offset.getTimezoneOffset(), 365);
	
	$('#gotopromotion').click( function() {
   	window.location = "${baseUrl}/activity/myActivity";
       return true;
   });
      
   $('#back').click( function() {
   	window.location = document.referrer;
       return true;
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