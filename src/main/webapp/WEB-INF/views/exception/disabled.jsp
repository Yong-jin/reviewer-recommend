<!DOCTYPE html>
<!--[if lt IE 7]>      <html class="no-js lt-ie9 lt-ie8 lt-ie7"> <![endif]-->
<!--[if IE 7]>         <html class="no-js lt-ie9 lt-ie8"> <![endif]-->
<!--[if IE 8]>         <html class="no-js lt-ie9"> <![endif]-->
<!--[if gt IE 8]><!--> <html class="no-js"> <!--<![endif]-->
<head>
<title>Some Fault</title>
<%@ include file="/WEB-INF/views/includes/header.jsp" %>
<link href="${baseUrl}/css/custom.css" rel="stylesheet" type="text/css"/>
</head>
<body class="page-404-full-page">
<div class="row">
	<div class="col-md-12 page-404">
		<div class="number">
			Sorry
		</div>
		<div class="details">
			<h3>Journal is currently disabled.</h3>
			<p>
				Journal is disabled for some reason<br/>
				If you have urgent problem, please send e-mail to journal manager.<br/>
				<a href="mailto:${creator.username }">
					 ${creator.username }
				</a>
			</p>
		</div>
	</div>
</div>
</body>
</html>