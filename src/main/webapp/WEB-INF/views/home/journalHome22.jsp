<%@ page import="link.thinkonweb.configuration.SystemConstants" %>

<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8 no-js"> <![endif]-->
<!--[if IE 9]> <html lang="en" class="ie9 no-js"> <![endif]-->
<!--[if !IE]><!-->
<html lang="en" class="no-js">
<!--<![endif]-->

<head>
<title>Journal Home</title>
<%@ include file="/WEB-INF/views/includes/header.jsp" %>
<link href="${baseUrl}/assets/plugins/select2/select2.css" rel="stylesheet" type="text/css" />
<link href="${baseUrl}/assets/plugins/select2/select2-metronic.css" rel="stylesheet" type="text/css"/>
<link href="${baseUrl}/assets/css/plugins.css" rel="stylesheet" type="text/css"/>
<link href="${baseUrl}/assets/css/style-metronic.css" rel="stylesheet" type="text/css"/>
<link href="${baseUrl}/assets/css/pages/profile.css" rel="stylesheet" type="text/css"/>
<link href="${baseUrl}/assets/css/components.css" rel="stylesheet">
<link href="${baseUrl}/assets/frontend/onepage/css/themes/blue.css" rel="stylesheet" id="style-color">
<link href="${baseUrl}/css/journalHome.css" rel="stylesheet">
<link href="${baseUrl}/assets/frontend/onepage/css/style-responsive.css" rel="stylesheet">
<link href="${baseUrl}/js/homes/corporate/plugins/revolution_slider/css/rs-style.css" rel="stylesheet" media="screen">
<link href="${baseUrl}/js/homes/corporate/plugins/revolution_slider/rs-plugin/css/settings.css" rel="stylesheet" media="screen"> 
<link href="${baseUrl}/js/homes/corporate/plugins/bxslider/jquery.bxslider.css" rel="stylesheet" />
<link href="${baseUrl}/css/custom.css" rel="stylesheet" type="text/css"/>

<style type="text/css">
.language {
	margin-top: -5px !important;
}
</style>

</head>

<body class="page-header-fixed">
<%@ include file="/WEB-INF/views/includes/headerBar.jsp" %>
<div class="page-container">
	<!-- BEGIN REVOLUTION SLIDER -->
	<div class="fullwidthbanner-container slider-main">
		<div class="fullwidthbanner journalHome">
        	<ul id="revolutionul" style="display:none;">            
            	<li data-transition="fade" data-slotamount="8" data-masterspeed="700" data-delay="9400" >
                	<!-- THE MAIN IMAGE IN THE FIRST SLIDE -->
                    <img src="${baseUrl}/images/bg_${journal.languageCode}.jpg" alt="" class="journalHomeImage">
						
                    <div class="caption lft journalHome_slide_title slide_item_left"
                         data-x="130" 
                         data-y="100"
                         data-speed="400"
                         data-start="500"
                         data-easing="easeOutExpo">
                         <div class="journalHomeHead"><strong>${journal.title}</strong></div>
                    </div>
                    <div class="caption lft journalHome_slide_desc slide_item_left"
                         data-x="130" 
                         data-y="180"
                         data-speed="400"
                         data-start="1000"
                         data-easing="easeOutExpo">     
                         <spring:message code="journal.organization"/>: ${journal.organization}
                    </div>
                    <div class="caption lft journalHome_slide_desc slide_item_left"
                         data-x="130" 
                         data-y="220"
                         data-speed="400"
                         data-start="1000"
                         data-easing="easeOutExpo">     
                         <i class="fa fa-home"></i> <a href="${journal.homepage}" target="_blank">${journal.homepage}</a>
                    </div>
                    
                    <div class="caption lft journalHome_slide_desc slide_item_left"
                         data-x="400" 
                         data-y="179"
                         data-speed="400"
                         data-start="1000"
                         data-easing="easeOutExpo">     
                         <spring:message code="journal.language"/>:
					<c:choose>
					<c:when test="${journal.languageCode == 'ko'}">
						<%= SystemConstants.koreanLanguageName %>
					</c:when>
					<c:when test="${journal.languageCode == 'en'}">
						<%= SystemConstants.englishLanguageName %>
					</c:when>
					</c:choose>
                    </div>
				</li>
			</ul>
			<div class="tp-bannertimer tp-bottom"></div>
		</div>
	</div>
	<p style="text-align:center; margin-bottom: -10px"><b><a id="serviceDetailViewButton" onClick="serviceDetailView();"><i class="fa fa-angle-down" style="font-size: 24px"></i></a></b></p>
     
	<div id="serviceDetailView" class="container">

	</div>
</div>
<footer>
<%@ include file="/WEB-INF/views/includes/footerBar.jsp" %>
<script src="${baseUrl}/assets/plugins/select2/select2.min.js" type="text/javascript" ></script>
<script src="${baseUrl}/assets/plugins/jquery-slimscroll/jquery.slimscroll.min.js" type="text/javascript"></script>
<script src="${baseUrl}/js/homes/corporate/plugins/fancybox/source/jquery.fancybox.pack.js" type="text/javascript"></script>  
<script src="${baseUrl}/js/homes/corporate/plugins/revolution_slider/rs-plugin/js/jquery.themepunch.plugins.min.js" type="text/javascript" ></script>
<script src="${baseUrl}/js/homes/corporate/plugins/revolution_slider/rs-plugin/js/jquery.themepunch.revolution.min.js" type="text/javascript"></script> 
<script src="${baseUrl}/js/homes/corporate/plugins/bxslider/jquery.bxslider.min.js" type="text/javascript"></script>
<script src="${baseUrl}/js/homes/corporate/scripts/index.js"></script>    
<script src="${baseUrl}/assets/scripts/core/app.js" type="text/javascript"></script>
</footer>

<script>
function serviceDetailView() {
	var detailViewId = '#serviceDetailView';
	var detailViewButtonId = '#serviceDetailViewButton';
	if($(detailViewId).css("display") != "none") {
		$(detailViewButtonId).html('<i  style="font-size: 24px" class="fa fa-angle-down "></i>');
		$(detailViewId).hide('normal');
	} else {
		$(detailViewButtonId).html('<i  style="font-size: 24px" class="fa fa-angle-up "></i>');
		$.ajax({
			type:"GET",
			url: "${baseUrl}/journals/${jnid}/serviceDetail?serviceType=${journal.type}",
			success: function(html){
				$(detailViewId).html(html).show('normal');
			}
		});
	}
}
jQuery(document).ready(function() {
	App.init();
	$('#serviceDetailView').hide();
	 revapi = jQuery('.fullwidthbanner').revolution({
		delay:9000,
		startwidth:1366,
		fullScreen:"on",
		fullScreenAlignForce:"on"
	});

});
</script>

<!-- END JAVASCRIPTS -->
</body>
<!-- END BODY -->
</html>
