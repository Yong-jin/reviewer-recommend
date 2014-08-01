<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8 no-js"> <![endif]-->
<!--[if IE 9]> <html lang="en" class="ie9 no-js"> <![endif]-->
<!--[if !IE]><!-->
<html class="no-js">
<!--<![endif]-->

<head>
<title>About Us</title>
<%@ include file="/WEB-INF/views/includes/header.jsp" %>
<!-- BEGIN PAGE LEVEL STYLES -->
<link href="${baseUrl}/assets/plugins/bootstrap-modal/css/bootstrap-modal-bs3patch.css" rel="stylesheet" type="text/css"/>
<link href="${baseUrl}/assets/plugins/bootstrap-modal/css/bootstrap-modal.css" rel="stylesheet" type="text/css"/>
<!-- END PAGE LEVEL STYLES -->

<link href="${baseUrl}/assets/css/pages/pricing-tables.css" rel="stylesheet" type="text/css"/>
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
						<spring:message code="system.customerSupport"/>
					</a>
					<i class="fa fa-angle-right"></i>
				</li>
				<li>
					<a href="${baseUrl}/promotion/customerSupport/aboutus">
						<spring:message code="system.aboutus"/>
					</a>
				</li>
			</ul>
		</div>
	</div>
			
	<!-- BEGIN PAGE HEADER-->
	<div class="row">
		<div class="col-md-12">
			<!-- BEGIN PAGE TITLE-->
			<h3 class="page-title"><spring:message code="system.aboutus"/></h3>
			<hr/>
		</div>
	</div>
  <!-- END PAGE HEADER-->
	
	<div class="row margin-bottom-30">
		<div class="col-md-6">
			<p>
				 <spring:message code="system.promotion.aboutus.desc.1"/>
				 <br/><br/>
				 <spring:message code="system.promotion.aboutus.desc.2"/>
				 <br/><br/>
				 <spring:message code="system.promotion.aboutus.desc.3"/>
			</p>
			<ul class="list-unstyled margin-top-10 margin-bottom-10">
				<li>
					<i class="fa fa-check"></i> <spring:message code="system.promotion.aboutus.desc.4"/>
				</li>
				<li>
					<i class="fa fa-check"></i> <spring:message code="system.promotion.aboutus.desc.5"/>
				</li>
				<li>
					<i class="fa fa-check"></i> <spring:message code="system.promotion.aboutus.desc.6"/>
				</li>
			</ul>
			<!-- Blockquotes -->
			<blockquote class="hero">
				<p>
					 I know you're smart. But everyone here is smart. Smart isn't enough. The kind of people I want on my research team are those who will help everyone feel happy to be here.
				</p>
				<small>Randy Pausch (The Last Lecture)</small>
			</blockquote>
		</div>
		<div class="col-md-6">
			<iframe src="http://player.vimeo.com/video/22439234" style="width:99.8%;height:327px;border:0" allowfullscreen>
			</iframe>
		</div>
	</div>
	<!--/row-->	
	
</div>
<!-- END PAGE CONTENT-->
<br/>
<br/>
<br/>
<br/>
<br/>

<div id="typeA-modal" class="modal container fade" tabindex="-1"></div>
<div id="typeB-modal" class="modal container fade" tabindex="-1"></div>
<div id="typeC-modal" class="modal container fade" tabindex="-1"></div>
<div id="typeD-modal" class="modal container fade" tabindex="-1"></div>

<footer>
<%@ include file="/WEB-INF/views/includes/promotionFooterBar.jsp" %>
</footer>
<!-- BEGIN PAGE LEVEL PLUGINS -->
<script src="${baseUrl}/assets/plugins/bootstrap-modal/js/bootstrap-modalmanager.js" type="text/javascript"></script>
<script src="${baseUrl}/assets/plugins/bootstrap-modal/js/bootstrap-modal.js" type="text/javascript"></script>
<!-- END PAGE LEVEL PLUGINS -->
<script src="${baseUrl}/assets/scripts/core/app.js" type="text/javascript"></script>

<script>
jQuery(document).ready(function() {
  App.init();
  UIExtendedModals.init();
});
</script>
<!-- END JAVASCRIPTS -->
</body>
<!-- END BODY -->
</html>