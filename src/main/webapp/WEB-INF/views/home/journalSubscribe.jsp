<!DOCTYPE html>
<!--[if lt IE 7]>      <html class="no-js lt-ie9 lt-ie8 lt-ie7"> <![endif]-->
<!--[if IE 7]>         <html class="no-js lt-ie9 lt-ie8"> <![endif]-->
<!--[if IE 8]>         <html class="no-js lt-ie9"> <![endif]-->
<!--[if gt IE 8]><!--> <html class="no-js"> <!--<![endif]-->
<head>
<title>${journal.shortTitle} - signin</title>
<%@ include file="/WEB-INF/views/includes/header.jsp" %>
<link href="${baseUrl}/assets/css/plugins.css" rel="stylesheet" type="text/css"/>
<link href="${baseUrl}/css/custom.css" rel="stylesheet" type="text/css"/>
<c:if test="${locale == 'en_US'}" >
</c:if>
</head>



<body class="loginJournal">
<%@ include file="/WEB-INF/views/includes/headerBarEmpty.jsp" %>
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
	<h4 class="form-title text-center"><spring:message code="system.notAMember1"/><br/><br/><spring:message code="system.notAMember2"/></h4>
	<div class="row text-center">
		<div class="col-md-push-2 col-md-4">
			<button id="notNow" class="button positive" >
				<i class="fa fa-sign-out"></i> <spring:message code="system.notNow"/>
			</button>			
		</div>

		<div class="com-md-4 col-md-push-2">
			<button id="yes" class="button positive" >
				<i class="fa fa-sign-in"></i> <spring:message code="system.yes"/>
			</button>
		</div>
	</div>
	<!-- END LOGIN FORM -->
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
<script>
jQuery(document).ready(function() {
  $('#notNow').click( function() {
	  window.location.href = "${baseUrl}/activity/myActivity";
    return true;
  });
   
  $('#yes').click( function() {
	  window.location.href = "${baseUrl}/account/journalSubscribe?jnid=${journal.journalNameId}";
    return true;
  });
});
</script>	
</body>