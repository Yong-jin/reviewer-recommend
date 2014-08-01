<!DOCTYPE html>
<!--[if lt IE 7]>      <html class="no-js lt-ie9 lt-ie8 lt-ie7"> <![endif]-->
<!--[if IE 7]>         <html class="no-js lt-ie9 lt-ie8"> <![endif]-->
<!--[if IE 8]>         <html class="no-js lt-ie9"> <![endif]-->
<!--[if gt IE 8]><!--> <html class="no-js"> <!--<![endif]-->
<head>
<title>Superuser Dashboard</title>
<%@ include file="/WEB-INF/views/includes/header.jsp" %>
<link href="${baseUrl}/css/custom.css" rel="stylesheet" type="text/css"/>
</head>



<body class="content">
<%@ include file="/WEB-INF/views/includes/headerBar.jsp" %>

<br/>
<br/>
<br/>
<br/>
<div class="container">
  <!-- Example row of columns -->
  <br/>
  <br/>
  <div class="row">
    <div class="col-md-3">
      <h2>Account Management</h2>
      <p><a class="btn btn-default" href="superManager/accountList" role="button">Open &raquo;</a></p>
    </div>  
    <div class="col-md-3">
      <h2>Journal Management</h2>
      <p><a class="btn btn-default" href="superManager/journalList" role="button">Open &raquo;</a></p>
    </div>
    <div class="col-md-3">
      <h2>Role Management</h2>
      <p><a class="btn btn-default" href="superManager/roleList?jnid=any" role="button">Open &raquo;</a></p>
    </div>    
    <div class="col-md-3">
      <h2>Session Management</h2>
      <p><a class="btn btn-default" href="superManager/sessionList" role="button">Open &raquo;</a></p>
    </div>    
  </div>
  <br/>
  <br/>
  <br/>
  <br/>
  <div class="row">
    <div class="col-md-3">
      <h2>Email Compose Test</h2>
      <p><a class="btn btn-default" href="superManager/emailTemplateTest?mailId=1&journalType=A&manuscriptTrack=0" role="button">Open &raquo;</a></p>
    </div>  
    <div class="col-md-3">
      <h2>... Statistics</h2>
      <p><a class="btn btn-default" href="#" role="button">View &raquo;</a></p>
    </div>
    <div class="col-md-3">
      <h2>... Statistics</h2>
      <p><a class="btn btn-default" href="#" role="button">View &raquo;</a></p>
    </div>    
    <div class="col-md-3">
      <h2>... Statistics</h2>
      <p><a class="btn btn-default" href="#" role="button">View &raquo;</a></p>
    </div>    
  </div>
</div>

<br/>
<br/>
<br/>
<br/>
<br/>
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