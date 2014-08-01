<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8 no-js"> <![endif]-->
<!--[if IE 9]> <html lang="en" class="ie9 no-js"> <![endif]-->
<!--[if !IE]><!-->
<html lang="en" class="no-js">
<!--<![endif]-->

<head>
<title>Service Management</title>
<%@ include file="/WEB-INF/views/includes/header.jsp" %>
<link href="${baseUrl}/assets/plugins/fancybox/source/jquery.fancybox.css" rel="stylesheet" type="text/css"/>
<link href="${baseUrl}/assets/css/pages/portfolio.css" rel="stylesheet" type="text/css"/>
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
					<a href="${baseUrl}/promotion/customerSupport/gallery">
						<spring:message code="system.gallery"/>
					</a>
				</li>
			</ul>
		</div>
	</div>
	
	<!-- BEGIN PAGE HEADER-->
	<div class="row">
		<div class="col-md-12">
			<!-- BEGIN PAGE TITLE-->
			<h3 class="page-title"><spring:message code="system.gallery"/></h3>
			<hr/>
		</div>
	</div>
  <!-- END PAGE HEADER-->
	
	<div class="margin-top-10">
		<ul class="mix-filter">
			<li class="filter" data-filter="all">
				 All
			</li>
			<li class="filter" data-filter="category_1">
				 UI Design
			</li>
			<li class="filter" data-filter="category_2">
				 Web Development
			</li>
			<li class="filter" data-filter="category_3">
				 Photography
			</li>
			<li class="filter" data-filter="category_3 category_1">
				 Wordpress and Logo
			</li>
		</ul>
		<div class="row mix-grid">
			<div class="col-md-3 col-sm-4 mix category_1">
				<a href="assets/img/works/img1.jpg" class="fancybox-button" data-rel="fancybox-button">
					<img class="img-responsive" src="assets/img/works/img1.jpg" alt="">
				</a>
			</div>
			<div class="col-md-3 col-sm-4 mix category_2">
				<a href="assets/img/works/img2.jpg" class="fancybox-button" data-rel="fancybox-button">
					<img class="img-responsive" src="assets/img/works/img2.jpg" alt="">
				</a>
			</div>
			<div class="col-md-3 col-sm-4 mix category_3">
				<a href="assets/img/works/img3.jpg" class="fancybox-button" data-rel="fancybox-button">
					<img class="img-responsive" src="assets/img/works/img3.jpg" alt="">
				</a>
			</div>
			<div class="col-md-3 col-sm-4 mix category_1 category_2">
				<a href="assets/img/works/img4.jpg" class="fancybox-button" data-rel="fancybox-button">
					<img class="img-responsive" src="assets/img/works/img4.jpg" alt="">
				</a>
			</div>
			<div class="col-md-3 col-sm-4 mix category_2 category_1">
				<a href="assets/img/works/img5.jpg" class="fancybox-button" data-rel="fancybox-button">
					<img class="img-responsive" src="assets/img/works/img5.jpg" alt="">
				</a>
			</div>
			<div class="col-md-3 col-sm-4 mix category_1 category_2">
				<a href="assets/img/works/img6.jpg" class="fancybox-button" data-rel="fancybox-button">
					<img class="img-responsive" src="assets/img/works/img6.jpg" alt="">
				</a>
			</div>
			<div class="col-md-3 col-sm-4 mix category_2 category_3">
				<a href="assets/img/works/img1.jpg" class="fancybox-button" data-rel="fancybox-button">
					<img class="img-responsive" src="assets/img/works/img1.jpg" alt="">
				</a>
			</div>
			<div class="col-md-3 col-sm-4 mix category_1 category_2">
				<a href="assets/img/works/img2.jpg" class="fancybox-button" data-rel="fancybox-button">
					<img class="img-responsive" src="assets/img/works/img2.jpg" alt="">
				</a>
			</div>
			<div class="col-md-3 col-sm-4 mix category_3">
				<a href="assets/img/works/img4.jpg" class="fancybox-button" data-rel="fancybox-button">
					<img class="img-responsive" src="assets/img/works/img4.jpg" alt="">
				</a>
			</div>
			<div class="col-md-3 col-sm-4 mix category_1">
				<a href="assets/img/works/img3.jpg" class="fancybox-button" data-rel="fancybox-button">
					<img class="img-responsive" src="assets/img/works/img3.jpg" alt="">
				</a>
			</div>
		</div>
	</div>
	<!-- END FILTER -->
</div>
<br/>
<br/>
<br/>
<footer>
<%@ include file="/WEB-INF/views/includes/promotionFooterBar.jsp" %>
</footer>
<script src="${baseUrl}/assets/plugins/jquery-mixitup/jquery.mixitup.min.js" type="text/javascript"></script>
<script src="${baseUrl}/assets/plugins/fancybox/source/jquery.fancybox.pack.js" type="text/javascript"></script>

<script src="${baseUrl}/assets/scripts/core/app.js" type="text/javascript"></script>
<script>
var Portfolio = function () {
  return {
      //main function to initiate the module
      init: function () {
          $('.mix-grid').mixitup();
      }
  };
}();

jQuery(document).ready(function() {
  App.init();
  Portfolio.init(); 
});
</script>

<!-- END JAVASCRIPTS -->
</body>
<!-- END BODY -->
</html>