<%@ page import="link.thinkonweb.configuration.SystemConstants" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<!--[if lt IE 7]>      <html class="no-js lt-ie9 lt-ie8 lt-ie7"> <![endif]-->
<!--[if IE 7]>         <html class="no-js lt-ie9 lt-ie8"> <![endif]-->
<!--[if IE 8]>         <html class="no-js lt-ie9"> <![endif]-->
<!--[if gt IE 8]><!--> <html class="no-js"> <!--<![endif]-->
<head>
<title>Superuser Dashboard</title>
<%@ include file="/WEB-INF/views/includes/header.jsp" %>
<link href="${baseUrl}/css/custom.css" rel="stylesheet" type="text/css"/>

<link href="${baseUrl}/assets/css/style-metronic.css" rel="stylesheet" type="text/css"/>
<link href="${baseUrl}/assets/css/plugins.css" rel="stylesheet" type="text/css"/>
<link href="${baseUrl}/assets/css/custom.css" rel="stylesheet" type="text/css"/>
<!-- END THEME STYLES -->
</head>


<body class="content">
<%@ include file="/WEB-INF/views/includes/headerBar.jsp" %>
<br/>

<div class="container">
		<div class="caption">
				<h3><i class="fa fa-users"></i>&nbsp;Session Management</h3>
		</div> 
			
		<br/>
		<br/>
		
		<div class="table-container">					
			<table class="table table-striped table-bordered table-hover fixedWidthSize" id="roleList_ajax">
				<thead>
		        <tr>
		        		<th>Username</th>
		            <th>Last Used</th>
		            <th>Session ID</th>
		            <th class="text-middle text-center">Expire Now</th>
		        </tr>
		    </thead>
		    <tbody>
	        <c:if test="${empty sessions}">
            <tr>
                <td colspan="4" class="msg">No sessions available. This may happen before the SessionRegistry is wired properly
                or when user's sessions are restored across container restarts. Read the Chapter text for details.</td>
            </tr>
        	</c:if>
		    	
					<c:forEach items="${sessions}" var="session">
		       	<tr class="text-middle">
	       			<td class="text-middle"><c:out value="${session.principal.username}" /></td>
            	<fmt:formatDate value="${session.lastRequest}" type="both" pattern="yyyy-MM-dd HH:mm" var="lastUsed"/>
              <td class="text-middle"><c:out value="${lastUsed}"/></td>
              <td class="text-middle"><c:out value="${session.sessionId}" /></td>
              <c:url var="deleteUrl" value="./superManager/sessionDelete/${session.sessionId}"/>
              <td class="text-middle text-center">
              	<form action="${deleteUrl}" class="form form-inline" method="post">
              		<input type="hidden" name="_method" value="delete"/><input type="submit" value="Delete" class="btn btn-sm"/>
              	</form>
              </td>
            </tr>
		   		</c:forEach>
   			</tbody>
			</table>
		</div>
	</div>

	
<!-- END PAGE CONTENT-->
<br/>
<br/>
<br/>
<footer>
<%@ include file="/WEB-INF/views/includes/footerBar.jsp" %>
<!-- BEGIN PAGE LEVEL PLUGINS -->
<script type="text/javascript" src="${baseUrl}/js/custom_global.js"></script>
<!-- END PAGE LEVEL PLUGINS -->
<!-- BEGIN PAGE LEVEL SCRIPTS -->
<script src="${baseUrl}/assets/scripts/core/app.js"></script>
<!-- END PAGE LEVEL SCRIPTS -->
<script>


jQuery(document).ready(function() {    
  App.init();
});
</script>
</footer>
</body>
<!-- END BODY -->
</html>