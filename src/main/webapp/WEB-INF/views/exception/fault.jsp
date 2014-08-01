<!DOCTYPE html>
<!--[if lt IE 7]>      <html class="no-js lt-ie9 lt-ie8 lt-ie7"> <![endif]-->
<!--[if IE 7]>         <html class="no-js lt-ie9 lt-ie8"> <![endif]-->
<!--[if IE 8]>         <html class="no-js lt-ie9"> <![endif]-->
<!--[if gt IE 8]><!--> <html class="no-js"> <!--<![endif]-->
<head>
<title>Some Fault</title>
<%@ include file="/WEB-INF/views/includes/header.jsp" %>
<link href="${baseUrl}/css/custom.css" rel="stylesheet" type="text/css"/>
<script>
$(document).ready( function() {
    $('#gotohome').click( function() {
    	window.location = "${baseUrl}";
        return true;
    });
    
    $('#signout').click( function() {
    	window.location = "${baseUrl}/j_spring_security_logout";
        return true;
    });
    
    $('#back').click( function() {
    	window.location = document.referrer;
        return true;
    });
});
</script>
</head>



<body class="content">
<%@ include file="/WEB-INF/views/includes/headerBar.jsp" %>
<br/>
<br/>
<br/>
<br/>
<div class="container row">

<div class="col-md-push-3 col-md-3">
	<c:if test="${not empty messageForFault}" >
		<br/>
		<div class="box">
		<h5>${messageForFault}</h5>
		</div>
		<br/>
	</c:if>

	<c:if test="${not empty user}" >
		<button id="signout" class="button positive" value="<spring:message code='system.signout'/>" >
			<img src="${baseUrl}/images/icons/set1/delete_16.png" alt=""/> <spring:message code="system.signout"/>
		</button>
	</c:if>

	<c:if test="${empty user}" >
		<button id="signin" class="button positive" value="<spring:message code='system.signin'/>" >
			<img src="${baseUrl}/images/icons/set1/key_16.png" alt=""/> <spring:message code="system.signin"/>
		</button>
	</c:if>

	<div class="row">
		<div class="prepend-1 span-3">
			<button id="back" class="button positive" value="<spring:message code='system.gotoback'/>" >
				<img src="${baseUrl}/images/icons/set2/rewind_16.png" alt=""/> <spring:message code="system.gotoback"/>
			</button>
		</div>

		<div class="prepend-1 span-4 append-6 last">
		<button id="gotohome" class="button positive" value="<spring:message code='system.gotohome'/>" >
			<img src="${baseUrl}/images/icons/set2/arrow_up_16.png" alt=""/> <spring:message code="system.gotohome"/>
		</button>
	</div>
</div>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<footer>
  <%@ include file="/WEB-INF/views/includes/footerBar.jsp" %>
</footer>
</body>
<!-- END BODY -->
</html>