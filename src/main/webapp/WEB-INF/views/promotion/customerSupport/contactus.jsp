<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8 no-js"> <![endif]-->
<!--[if IE 9]> <html lang="en" class="ie9 no-js"> <![endif]-->
<!--[if !IE]><!-->
<html lang="en" class="no-js">
<!--<![endif]-->

<head>
<title>Service Management</title>
<%@ include file="/WEB-INF/views/includes/header.jsp" %>
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
					<a href="${baseUrl}/promotion/customerSupport/contactus">
						<spring:message code="system.contactus"/>
					</a>
				</li>
			</ul>
		</div>
	</div>
	
	<!-- BEGIN PAGE HEADER-->
	<div class="row">
		<div class="col-md-12">
			<!-- BEGIN PAGE TITLE-->
			<h3 class="page-title"><spring:message code="system.contactus"/></h3>
			<hr/>
		</div>
	</div>
  <!-- END PAGE HEADER-->
  		

	<div class="row">
		<div class="col-md-12">
			<!-- Google Map -->
			<div class="row">
				<div id="map" class="marginLeft15" style="width:97.4%;height:400px;">
				</div>
			</div>
			<div class="row margin-bottom-20">
				<div class="col-md-6">
					<div class="space20">
					</div>
					<h3 class="form-section"><spring:message code="system.contacts"/></h3>
					<div class="well2">
						<h4><spring:message code="system.address"/></h4>
						<address>
						<strong>MANUSCRIPTLINK</strong><br>
						 <spring:message code="home.address2"/>
						 <br/>
						<!--<abbr title="Phone">Phone:</abbr> +81-(234) 145-1810 </address>-->
						<address>
						<br/>
						<h4><spring:message code="signin.email"/></h4>
						<a href="mailto:cmdrkim@gmail.com">
							 cmdrkim@gmail.com
						</a>
						</address>
						<ul class="social-icons margin-bottom-10">
							<li>
								<a href="#" data-original-title="facebook" class="facebook">
								</a>
							</li>
							<li>
								<a href="#" data-original-title="Goole Plus" class="googleplus">
								</a>
							</li>
							<li>
								<a href="#" data-original-title="linkedin" class="linkedin">
								</a>
							</li>
							<li>
								<a href="#" data-original-title="twitter" class="twitter">
								</a>
							</li>
						</ul>
					</div>
				</div>
				<div class="col-md-6">
					<div class="space20">
					</div>
					<!-- BEGIN FORM-->
					<form action="#" class="horizontal-form">
						<h3 class="form-section">Feedback Form</h3>
						<div class="form-group">
							<label class="control-label">Name</label>
							<input type="text" class="form-control col-md-12 marginBottom10"/>
						</div>
						
						<div class="form-group">
							<label class="control-label">Email</label>
							<input type="text" class="form-control col-md-12 marginBottom10">
						</div>
						
						<div class="form-group">
							<label class="control-label">Message</label>
							<textarea class="form-control col-md-12 marginBottom10" rows="3"></textarea>
						</div>
						
						<div class="margin-top-10">
							<button type="submit" class="btn blue"><i class="fa fa-check"></i> Send</button>
							<button type="button" class="btn">Cancel</button>
						</div>
					</form>
					<!-- END FORM-->
				</div>
			</div>
		</div>
	</div>
	<!-- END PAGE CONTENT-->

  
</div>
<footer>
<%@ include file="/WEB-INF/views/includes/promotionFooterBar.jsp" %>
</footer>
<script src="http://maps.google.com/maps/api/js?sensor=true" type="text/javascript"></script>
<script src="${baseUrl}/assets/plugins/gmaps/gmaps.min.js" type="text/javascript"></script>  
<script src="${baseUrl}/assets/scripts/core/app.js" type="text/javascript"></script>
<script>
jQuery(document).ready(function() {
  App.init();
  
  var map = new GMaps({
		div: '#map',
		lat: 36.761896, 
		lng: 127.280405,
		zoom: 17
	});
	
  var marker = map.addMarker({
    lat: 36.761896,
		lng: 127.280405,
    title: 'MANUSCRIPTLINK',
    infoWindow: {
    	content: "<spring:message code='home.address2'/>"
    }
  });

	marker.infoWindow.open(map, marker);
});
</script>

<!-- END JAVASCRIPTS -->
</body>
<!-- END BODY -->
</html>