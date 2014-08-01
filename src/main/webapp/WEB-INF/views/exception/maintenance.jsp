<%@ taglib prefix="customTagFile" tagdir="/WEB-INF/tags" %>
<%@ page import="link.thinkonweb.configuration.SystemConstants" %>
<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8 no-js"> <![endif]-->
<!--[if IE 9]> <html lang="en" class="ie9 no-js"> <![endif]-->
<!--[if !IE]><!-->
<html lang="en" class="no-js">
<!--<![endif]-->
<head>
<%@ include file="/WEB-INF/views/includes/header.jsp" %>
<title>Maintenance</title>
<link href="${baseUrl}/css/custom.css" rel="stylesheet" type="text/css"/>
<link href="${baseUrl}/assets/css/pages/coming-soon.css" rel="stylesheet" type="text/css"/>
</head>
<body>
<%@ include file="/WEB-INF/views/includes/headerBarEmpty.jsp" %>
<div class="container">
	<div class="row">
		<div class="col-md-6 coming-soon-content">
			<h1>Coming Soon!</h1>
			<p>
				 At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi vehicula sem ut volutpat. Ut non libero magna fusce condimentum eleifend enim a feugiat.
			</p>
			<br>
			<form class="form-inline" action="#">
				<div class="input-group input-large">
					<input type="text" class="form-control">
					<span class="input-group-btn">
						<button class="btn blue" type="button">
						<span>
							 Subscribe
						</span>
						<i class="m-icon-swapright m-icon-white"></i></button>
					</span>
				</div>
			</form>
			<ul class="social-icons margin-top-20">
				<li>
					<a href="#" data-original-title="Feed" class="rss">
					</a>
				</li>
				<li>
					<a href="#" data-original-title="Facebook" class="facebook">
					</a>
				</li>
				<li>
					<a href="#" data-original-title="Twitter" class="twitter">
					</a>
				</li>
				<li>
					<a href="#" data-original-title="Goole Plus" class="googleplus">
					</a>
				</li>
				<li>
					<a href="#" data-original-title="Pinterest" class="pintrest">
					</a>
				</li>
				<li>
					<a href="#" data-original-title="Linkedin" class="linkedin">
					</a>
				</li>
				<li>
					<a href="#" data-original-title="Vimeo" class="vimeo">
					</a>
				</li>
			</ul>
		</div>
		<div class="col-md-6 coming-soon-countdown">
			<div id="defaultCountdown">
			</div>
		</div>
	</div>
	<!--/end row-->
</div>


<%@ include file="/WEB-INF/views/includes/footerBar.jsp" %>
<script src="${baseUrl}/assets/plugins/countdown/jquery.countdown.min.js" type="text/javascript"></script>
<script src="${baseUrl}/assets/plugins/backstretch/jquery.backstretch.min.js" type="text/javascript"></script>
<script src="${baseUrl}/assets/scripts/custom/coming-soon.js" type="text/javascript"></script>
<script>
jQuery(document).ready(function() {     
  ComingSoon.init();
});
</script>
</body>
</html>
