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
<link href="${baseUrl}/assets/plugins/font-awesome/css/font-awesome.min.css" rel="stylesheet">
<link href="${baseUrl}/assets/plugins/slider-revolution-slider/rs-plugin/css/settings.css" rel="stylesheet">
<link href="${baseUrl}/assets/plugins/fancybox/source/jquery.fancybox.css" rel="stylesheet">
<link href="${baseUrl}/assets/css/components.css" rel="stylesheet">
<link href="${baseUrl}/assets/frontend/onepage/css/themes/blue.css" rel="stylesheet" id="style-color">
<link href="${baseUrl}/css/journalHome.css" rel="stylesheet">
<link href="${baseUrl}/assets/frontend/onepage/css/style-responsive.css" rel="stylesheet">

<link href="${baseUrl}/css/custom.css" rel="stylesheet" type="text/css"/>
</head>

<body class="page-header-fixed">
<%@ include file="/WEB-INF/views/includes/headerBar.jsp" %>
<br/><br/><br/><br/><br/><br/>
  <div class="content content-center" >
    <div class="container">
    	<h2 class="h2">${journal.title}</h2>
		<c:if test="${not empty journal.about}">
			<p>${journal.about}</p>
		</c:if>
		<br/>
		<ul class="list-inline">
			<li>
				<i class="fa fa-home"></i> <a href="${journal.homepage}" target="_blank">${journal.homepage}</a>
			</li>
			<li>
				<img src="${baseUrl}/assets/img/flags/${fn:toLowerCase(journal.countryCode)}.png" border="0" /> ${journal.publisherCountryCode.name}
			</li>
		</ul>
    </div>
  </div>
  <br/><br/>
  <!-- Services block BEGIN -->
  <div class="services-block content content-center" id="services">
    <div class="container">
      <div class="row">
    	<div class="col-md-3 col-sm-3 col-xs-6 counts">
    	  <div class="item">
    	  	<spring:message code="journal.journalIdentifier"/>:
    	  	<strong>${journal.journalNameId}</strong>
    	  </div>
    	</div>
    	<div class="col-md-3 col-sm-3 col-xs-6 counts">
    	  <div class="item">
    	  	<spring:message code="journal.shortTitle"/>:
    	  	<strong>${journal.shortTitle}</strong>
    	  </div>
    	</div>
    	<div class="col-md-3 col-sm-3 col-xs-6 counts">
    	  <div class="item">
    	  	<spring:message code="journal.organization"/>:
    	  	<strong>${journal.organization}</strong>
    	  </div>
    	</div>
    	<div class="col-md-3 col-sm-3 col-xs-6 counts">
    	  <div class="item lastItem">
    	  	<spring:message code="journal.language"/>:
    	  	<strong>									
	    	  	<c:choose>
							<c:when test="${journal.languageCode == 'ko'}">
								<%= SystemConstants.koreanLanguageName %>
							</c:when>
							<c:when test="${journal.languageCode == 'en'}">
								<%= SystemConstants.englishLanguageName %>
							</c:when>
						</c:choose>
			</strong>
    	  </div>
    	</div>
      </div>
      <br/><br/>
      <div class="row">
    	<div class="col-md-4 col-sm-4 col-xs-6 counts">
    	  <div class="item">
    	  	<spring:message code="journal.totalSubmissions"/>: <strong>${numSubmittedAndConfirmedStatus }</strong>
    	  	
    	  </div>
    	</div>
    	<div class="col-md-4 col-sm-4 col-xs-6 counts">
    	  <div class="item">
    	  	<spring:message code="journal.manuscriptsInReview"/>: <strong> ${numInReviewStatus }</strong>
    	  	
    	  </div>
    	</div>
    	<div class="col-md-4 col-sm-4 col-xs-6 counts">
    	  <div class="item lastItem">
    	  	<spring:message code="journal.manuscriptsAccepted"/>: <strong>${numAcceptStatus }</strong>
    	  </div>
    	</div>
      </div>

    </div>
  </div>
  <!-- Services block END -->
  
  <div class="choose-us-block content text-center margin-bottom-40" id="benefits">
  	<!-- <h3>Service Type of Our Journal</h3> -->
    <div class="container">
      <div class="row">
    	<div class="col-md-4 col-sm-4 col-xs-12 text-left">
    	  <img src="${baseUrl}/images/coverImages/${journal.coverImageFilename}" class="img-responsive" alt="" width="63%" style="margin-left: 100px"/>
    	</div>
    	<div class="col-md-7 col-sm-7 col-xs-12 text-left">
    		<p class="form-control-static sentenseJustifyAlign" style="line-height: 170%">
				Authors can fill up paper information and upload their paper and materials holding research work.<br/>
				Manager can return back awkwardly-formed papers to authors.<br/>
				Manager can assign a chief editor to a paper submitted to a normal track. <br/>
				Manager can make authors select a special issue track when they submit a paper.<br/>
				Manager can assign guest editors to a paper submitted to a special issue track.<br/>
				Chief (or guest) editor can reject submitted papers which is not eligible for review.<br/>
				Chief (or guest) editor can invite or allocate reviewers who will read and evaluate submitted papers.<br/>
				Chief (or guest) editor can use <strong>a fully fledged reviewer recommendation service</strong>.  	<br/>								
				Reviewers can evaluate submitted papers and send the evaluation results to editors<br/>
				Editor can determine whether submitted papers are acceptable for publication.<br/>
				Authors can upload camera-ready papers and materials.<br/>
				Manager can return back awkwardly-formed camera-ready paper to authors.<br/>
			</p> 
    	</div>
      </div>
    </div>
  </div>

  <div class="services-block content content-center">
    <div class="container">
      <div class="row">
        <div class="col-md-4 col-sm-4 col-xs-6 counts">
        	<div class="item">
    	  	Associate editor allocated to each paper:
    	  	<i class="fa fa-check"></i>
    	  </div>
        </div>
        <div class="col-md-4 col-sm-4 col-xs-6 counts">
        	<div class="item">
	          Recirculation of submitted paper:
	          <i class="fa fa-check"></i>
        	</div>
        </div>
        <div class="col-md-4 col-sm-4 col-xs-6 counts">
        	<div class="item lastItem">
          		Special issue and guest editor
          		<i class="fa fa-check"></i>
          	</div>
        </div>
      </div>
    </div>
  </div>
  <div class="services-block content content-center" id="services">
    <div class="container">
      <div class="row cellCenter">
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


<%-- 	<br/><br/>
	<div class="choose-us-block content margin-bottom-40"  style="margin-left:150px">
		<div class="row">
		<div class="col-md-5">
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
			<br/><br/>
		</div>
			<div class="col-md-6">
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
	</div> --%>
<footer>
<%@ include file="/WEB-INF/views/includes/footerBar.jsp" %>
<script src="${baseUrl}/assets/plugins/select2/select2.min.js" type="text/javascript" ></script>
<script src="${baseUrl}/assets/plugins/jquery-slimscroll/jquery.slimscroll.min.js" type="text/javascript"></script>


<!-- BEGIN RevolutionSlider -->
<script src="${baseUrl}/assets/plugins/slider-revolution-slider/rs-plugin/js/jquery.themepunch.plugins.min.js" type="text/javascript"></script>
<script src="${baseUrl}/assets/plugins/slider-revolution-slider/rs-plugin/js/jquery.themepunch.revolution.min.js" type="text/javascript"></script>
<script src="${baseUrl}/assets/frontend/onepage/scripts/revo-ini.js" type="text/javascript"></script> 
<!-- END RevolutionSlider -->

<!-- Core plugins BEGIN (required only for current page) -->
<script src="${baseUrl}/assets/plugins/fancybox/source/jquery.fancybox.pack.js" type="text/javascript"></script><!-- pop up -->
<script src="${baseUrl}/assets/plugins/jquery.easing.js"></script>
<script src="${baseUrl}/assets/plugins/jquery.parallax.js"></script>
<script src="${baseUrl}/assets/plugins/jquery.scrollTo.min.js"></script>
<script src="${baseUrl}/assets/frontend/onepage/scripts/jquery.nav.js"></script>
<!-- Core plugins END (required only for current page) -->

<script src="${baseUrl}/assets/scripts/core/app.js" type="text/javascript"></script>
</footer>

<script>
jQuery(document).ready(function() {
	App.init();
	Layout.init();
});
</script>

<!-- END JAVASCRIPTS -->
</body>
<!-- END BODY -->
</html>