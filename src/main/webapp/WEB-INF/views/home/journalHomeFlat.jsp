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
                          <img src="${baseUrl}/images/journalHome.jpg" alt="">
<%--                             <div class="caption lft journalHome_slide_desc slide_item_left"
                                data-x="100" 
                                data-y="85"
                                data-speed="400"
                                data-start="500"
                                data-easing="easeOutExpo">
                                <img src="${baseUrl}/images/board.png" alt="" class="board"/>
                           </div> --%>
                          <div class="caption lft btn green journalHome_slide_title slide_item_left"
                               data-x="130" 
                               data-y="100"
                               data-speed="400"
                               data-start="500"
                               data-easing="easeOutExpo">
                               <div class="journalHomeHead"><strong>${journal.title}</strong></div>
                          </div>
                          <div class="caption lft btn bg-grey-cararra journalHome_slide_desc slide_item_left"
                               data-x="130" 
                               data-y="180"
                               data-speed="400"
                               data-start="1000"
                               data-easing="easeOutExpo">     
                               <spring:message code="journal.organization"/>: ${journal.organization}
                          </div>
                          <div class="caption lft btn bg-grey-cararra journalHome_slide_desc slide_item_left"
                               data-x="130" 
                               data-y="230"
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
                          <div class="caption lft btn bg-grey-cararra journalHome_slide_desc slide_item_left" 
                               data-x="130" 
                               data-y="280"
                               data-speed="400"
                               data-start="1000"
                               data-easing="easeOutExpo">     
                               <i class="fa fa-home"></i> <a href="${journal.homepage}" target="_blank">${journal.homepage}</a>
                          </div>
                          
                          <div class="caption lft btn bg-grey-cararra journalHome_slide_desc slide_item_left"
                               data-x="400" 
                               data-y="180"
                               data-speed="400"
                               data-start="1000"
                               data-easing="easeOutExpo">     
                               <spring:message code="journal.journalIdentifier"/>: ${journal.journalNameId}
                          </div>
                          
                          <div class="caption lft btn bg-grey-cararra journalHome_slide_desc slide_item_left"
                               data-x="400" 
                               data-y="230"
                               data-speed="400"
                               data-start="1000"
                               data-easing="easeOutExpo">     
                               <spring:message code="journal.shortTitle"/>: ${journal.shortTitle}
                          </div>
                          

<%--                              <div class="caption lfb"
                                data-x="1000" 
                                data-y="300" 
                                data-speed="700" 
                                data-start="1000" 
                                data-easing="easeOutExpo"  >
                                <img src="${baseUrl}/images/note2.png" alt="" class="pen"/>
                           </div> --%>
                          <div class="caption lfb"
                               data-x="980" 
                               data-y="280" 
                               data-speed="700" 
                               data-start="1000" 
                               data-easing="easeOutExpo"  >
                               <img src="${baseUrl}/images/people.png" alt="" class="pen"/>
                          </div>
                          <div class="caption lfb"
                               data-x="980" 
                               data-y="225" 
                               data-speed="700" 
                               data-start="1000" 
                               data-easing="easeOutExpo"  >
                               <img src="${baseUrl}/images/calendar.png" alt="" class="pen"/>
                          </div>
                          <div class="caption lfb"
                               data-x="985" 
                               data-y="150" 
                               data-speed="700" 
                               data-start="1000" 
                               data-easing="easeOutExpo"  >
                               <img src="${baseUrl}/images/note.png" alt="" class="pen"/>
                          </div>
                          <div class="caption lfb"
                               data-x="980" 
                               data-y="90" 
                               data-speed="700" 
                               data-start="1000" 
                               data-easing="easeOutExpo"  >
                               <img src="${baseUrl}/images/mail.png" alt="" class="pen"/>
                          </div>
                          <div class="caption lfb"
                               data-x="780" 
                               data-y="85" 
                               data-speed="700" 
                               data-start="1000" 
                               data-easing="easeOutExpo"  >
                               <img src="${baseUrl}/images/ml.png" alt="" class="pen"/>
                          </div>
                         <div class="caption lfb"
                               data-x="730" 
                               data-y="65" 
                               data-speed="700" 
                               data-start="1000" 
                               data-easing="easeOutExpo"  >
                               <img src="${baseUrl}/images/coverImages/${journal.coverImageFilename}" alt="" class="journalHomeImage"/>
                    	</div>
					</li>
				</ul>
				<div class="tp-bannertimer tp-bottom"></div>
			</div>
		</div>
       <!-- END REVOLUTION SLIDER -->
       <p style="text-align:center; margin-bottom: -10px"><b><i class="fa fa-angle-down" style="font-size: 24px"></i></b></p>
     
<%--     <div class="container">
		
		<div class="row page-boxed">
			<div class="col-md-12">
			<br/>
			<!-- BEGIN PAGE CONTAINER-->
			<div class="promo-page">
				<br/><br/><br/><br/><br/><br/>
				<div class="block-yellow">
					<div class="container">
						<div class="row" id="slimscroll">
							<div class="col-md-12">
								<h4>Service Type: 
								<c:choose>
									<c:when test="${journal.type == 'A'}">
										<spring:message code="system.nameTypeA"/>
									</c:when>
									<c:when test="${journal.type == 'B'}">
										<spring:message code="system.nameTypeB"/>
									</c:when>
									<c:when test="${journal.type == 'C'}">
										<spring:message code="system.nameTypeC"/>
									</c:when>
									<c:when test="${journal.type == 'D'}">
										<spring:message code="system.nameTypeD"/>
									</c:when>
								</c:choose>
								</h4>
								<p>
									The following diagram shows 
									<strong>
										${journal.title}
									</strong>
									's manuscript submission &amp; review process while showing manuscript status changes.
								</p>
							</div>
							<br/>
							<div class="row">
								<div class="col-md-12">
									<div class="text-center">
										<c:choose>
											<c:when test="${journal.type == 'A'}">
												<img src="${baseUrl}/images/promotion/processTypeA.png" border="0" width="95%"/>
											</c:when>
											<c:when test="${journal.type == 'B'}">
												<img src="${baseUrl}/images/promotion/processTypeB.png" border="0" width="95%"/>
											</c:when>
											<c:when test="${journal.type == 'C'}">
												<img src="${baseUrl}/images/promotion/processTypeC.png" border="0" width="95%"/>
											</c:when>
											<c:when test="${journal.type == 'D'}">
												<img src="${baseUrl}/images/promotion/processTypeD.png" border="0" width="95%"/>
											</c:when>
										</c:choose>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<br/><br/><br/><br/><br/>
				<div class="block-transparent">
					<div class="container">
						<div class="row margin-bottom-20">
							<div class="col-md-6">
								<div class="text-center" id="manuscriptStatusTitle">
									 <h4>
									 <spring:message code="system.manuscriptStatusFlow"/> 
									 </h4>
								</div>
								<div class="text-center" id="manuscriptStatusImg">
									<c:choose>
										<c:when test="${journal.type == 'A'}">
											<img src="${baseUrl}/images/promotion/manuscriptStatusA.png" border="0" width="100%"/>
										</c:when>
										<c:when test="${journal.type == 'B'}">
											<img src="${baseUrl}/images/promotion/manuscriptStatusB.png" border="0" width="60%"/>
										</c:when>
										<c:when test="${journal.type == 'C'}">
											<img src="${baseUrl}/images/promotion/manuscriptStatusC.png" border="0" width="100%"/>
										</c:when>
										<c:when test="${journal.type == 'D'}">
											<img src="${baseUrl}/images/promotion/manuscriptStatusD.png" border="0" width="60%"/>
										</c:when>
									</c:choose>
								</div>
							</div>
							<div class="col-md-6 margin-bottom-20">
								<h4>&nbsp;&nbsp;&nbsp;Support</h4>
								<ul>
									<li>Authors can fill up paper information and upload their paper and materials holding research work.
									<li>Manager can return back awkwardly-formed papers to authors.
									<li>Manager can assign a chief editor to a paper submitted to a normal track. 
									<li>Manager can make authors select a special issue track when they submit a paper.
									<li>Manager can assign guest editors to a paper submitted to a special issue track.
									<li>Chief (or guest) editor can reject submitted papers which is not eligible for review.
									<li>Chief (or guest) editor can invite or allocate reviewers who will read and evaluate submitted papers.
									<li>Chief (or guest) editor can use <strong>a fully fledged reviewer recommendation service</strong>.  									
									<li>Reviewers can evaluate submitted papers and send the evaluation results to editors
									<li>Editor can determine whether submitted papers are acceptable for publication.
									<li>Authors can upload camera-ready papers and materials.
									<li>Manager can return back awkwardly-formed camera-ready paper to authors.
								</ul>
								<h4>&nbsp;&nbsp;&nbsp;No Support</h4>
								<ul>
									<li>No associate editor
									<li>No recirculation process (no support for conditional accept)
								</ul>
							</div>
						</div>
					</div>
				</div>

				<!-- END PAGE CONTENT-->
			</div>
			<!-- BEGIN PAGE CONTAINER-->
			

			</div>
		</div>
	</div> --%>
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
jQuery(document).ready(function() {
	App.init();
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
