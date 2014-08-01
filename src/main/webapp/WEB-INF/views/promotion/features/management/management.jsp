<%@ page import="link.thinkonweb.configuration.SystemConstants" %>

<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8 no-js"> <![endif]-->
<!--[if IE 9]> <html lang="en" class="ie9 no-js"> <![endif]-->
<!--[if !IE]><!-->
<html lang="en" class="no-js">
<!--<![endif]-->

<head>
<title>Service Management</title>
<%@ include file="/WEB-INF/views/includes/header.jsp" %>
<link href="${baseUrl}/assets/css/pages/profile.css" rel="stylesheet" type="text/css"/>
<link href="${baseUrl}/css/custom.css" rel="stylesheet" type="text/css"/>
</head>




<body>
<%@ include file="/WEB-INF/views/includes/promotionHeaderBar.jsp" %>
<div class="container">
	<div class="row">
		<div class="col-md-12">
			<ul class="page-breadcrumb breadcrumb marginTop14">
				<li>
					<i class="fa fa-home"></i>
					<a href="${baseUrl}/promotion">
						<spring:message code="system.promotionHome"/>
					</a>
					<i class="fa fa-angle-right"></i>
				</li>
				<li>
					<a>
						<spring:message code="system.feature"/>
					</a>
					<i class="fa fa-angle-right"></i>
				</li>
				<li>
					<a href="${baseUrl}/promotion/features/management">
						<spring:message code="home.manage"/>
					</a>
				</li>
			</ul>
		</div>
	</div>
			
   
		
		<div class="row page-boxed">
			<div class="col-md-12">
				<div class="row">
					<div class="col-md-12 profile-info">
						<h1><spring:message code="home.manage"/></h1>
						<p><spring:message code="home.manage.description"/></p>
					</div>
				</div>
				<!--end row-->
				
				<div class="tabbable tabbable-custom tabbable-full-width">
					<ul class="nav nav-tabs">
						<li class="active">
							<a href="#tab_1_1" data-toggle="tab">
								 <spring:message code="system.typeA"/>
							</a>
						</li>
						<li>
							<a href="#tab_1_2" data-toggle="tab">
								 <spring:message code="system.typeB"/>
							</a>
						</li>
						<li>
							<a href="#tab_1_3" data-toggle="tab">
								 <spring:message code="system.typeC"/>
							</a>
						</li>
						<li>
							<a href="#tab_1_4" data-toggle="tab">
								 <spring:message code="system.typeD"/>
							</a>
						</li>
					</ul>
					
					<div class="tab-content">
						<!--tab_1_1-->
						<div class="tab-pane fade in active" id="tab_1_1">
							<h3><spring:message code="system.nameTypeA"/></h3>
							<br/>
							<%@ include file="typeA-description.jsp" %>
							<br/><br/>
						</div>
						
						<!--tab_1_2-->
						<div class="tab-pane fade" id="tab_1_2">
							<h3><spring:message code="system.nameTypeB"/></h3>
							<br/>
							<%@ include file="typeB-description.jsp" %>
							<br/><br/>
						</div>
						
						<!--tab_1_3-->
						<div class="tab-pane fade" id="tab_1_3">
							<h3><spring:message code="system.nameTypeC"/></h3>
							<br/>
							<%@ include file="typeC-description.jsp" %>
							<br/><br/>
						</div>

						<!--tab_1_4-->
						<div class="tab-pane fade" id="tab_1_4">
							<h3><spring:message code="system.nameTypeD"/></h3>
							<br/>
							<%@ include file="typeD-description.jsp" %>
							<br/><br/>
						</div>
						
					</div>
				</div>
			</div>
		</div>
</div>
<footer>
<%@ include file="/WEB-INF/views/includes/promotionFooterBar.jsp" %>
</footer>
<script src="${baseUrl}/js/homes/corporate/plugins/fancybox/source/jquery.fancybox.pack.js" type="text/javascript"></script>  
<script src="${baseUrl}/assets/scripts/core/app.js" type="text/javascript"></script>
<script>
jQuery(document).ready(function() {
  App.init();
});
</script>

<!-- END JAVASCRIPTS -->
</body>
<!-- END BODY -->
</html>