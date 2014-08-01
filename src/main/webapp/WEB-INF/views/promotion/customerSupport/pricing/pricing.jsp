<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8 no-js"> <![endif]-->
<!--[if IE 9]> <html lang="en" class="ie9 no-js"> <![endif]-->
<!--[if !IE]><!-->
<html lang="en" class="no-js">
<!--<![endif]-->

<head>
<title>Pricing</title>
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
					<a href="${baseUrl}/promotion/customerSupport/prices">
						<spring:message code="system.prices"/>
					</a>
				</li>
			</ul>
		</div>
	</div>
			
	<!-- BEGIN PAGE HEADER-->
	<div class="row">
		<div class="col-md-12">
			<!-- BEGIN PAGE TITLE-->
			<h3 class="page-title"><spring:message code="system.pricingTables"/></h3>
			<hr/>
		</div>
	</div>
  <!-- END PAGE HEADER-->
	
	<div class="row">
		<div class="col-md-12">
			<!-- BEGIN INLINE NOTIFICATIONS PORTLET-->
			<div class="row margin-bottom-40">
				<!-- Pricing -->
				<div class="col-md-3">
					<div class="pricing hover-effect">
						<div class="pricing-head">
							<h3><spring:message code="system.typeA2"/>
							<span>
								 <spring:message code="system.nameTypeA2"/>
							</span>
							</h3>
							
							<h4>
								<small><spring:message code="system.promotion.pricing.flat-rate"/></small>
								<p/>
								<c:if test="${locale == 'en_US' && (param.lang == null || param.lang == 'en_US')}">
									<i>$</i>299<i>.99</i>
								</c:if>
								<c:if test="${locale == 'ko_KR' || param.lang =='ko_KR'}"> 
									<i>&#8361;</i>300,000
								</c:if>
								<span><spring:message code="system.promotion.pricing.flat-rate.permonth"/></span>
							</h4>
							
							<h4>
								<small><spring:message code="system.promotion.pricing.payasyougo-rate"/></small>
								<p/>
								<c:if test="${locale == 'en_US' && (param.lang == null || param.lang == 'en_US')}">
									<i>$</i>9<i>.99</i>
								</c:if>
								<c:if test="${locale == 'ko_KR' || param.lang =='ko_KR'}"> 
									<i>&#8361;</i>10,000
								</c:if>
								<span><spring:message code="system.promotion.pricing.payasyougo-rate.persubmission"/></span>
							</h4>
						</div>
						<ul class="pricing-content list-unstyled">
							<li>
								<i class="fa fa-angle-right"></i> <spring:message code="system.promotion.pricing.support.0"/>
							</li>
							<li>
								<i class="fa fa-angle-right"></i> <spring:message code="system.promotion.pricing.support.1"/>
							</li>
							<li>
								<i class="fa fa-angle-right"></i> <spring:message code="system.promotion.pricing.support.2"/>
							</li>
							<li>
								<i class="fa fa-angle-right"></i> <spring:message code="system.promotion.pricing.support.3"/>
							</li>
							<li>
								<i class="fa fa-angle-right"></i> <spring:message code="system.promotion.pricing.support.4"/>
							</li>
							<li>
								<i class="fa fa-angle-right"></i> <spring:message code="system.promotion.pricing.support.5"/>
							</li>
						</ul>
						<div class="center cellCenter pricing-footer">
							<br/>
							<a class="btn btn-warning btn-sm" id="ajax-typeA" data-toggle="modal">
								 <spring:message code="system.service"/> <i class="m-icon-swapright m-icon-white"></i>
							</a>
							<br/><br/>
							<a href="${baseUrl}/submitJournal" class="btn btn-success">
								 <spring:message code="home.open2"/> <i class="m-icon-swapright m-icon-white"></i>
							</a>
							<br/><br/>
						</div>
					</div>
				</div>
				<div class="col-md-3">
					<div class="pricing hover-effect">
						<div class="pricing-head">
							<h3><spring:message code="system.typeB2"/>
							<span>
								 <spring:message code="system.nameTypeB2"/>
								 <br/>&nbsp;
							</span>
							</h3>
							<h4>
								<small><spring:message code="system.promotion.pricing.flat-rate"/></small>
								<p/>
								<c:if test="${locale == 'en_US' && (param.lang == null || param.lang == 'en_US')}">
									<i>$</i>249<i>.99</i>
								</c:if>
								<c:if test="${locale == 'ko_KR' || param.lang =='ko_KR'}"> 
									<i>&#8361;</i>250,000
								</c:if>
								<span><spring:message code="system.promotion.pricing.flat-rate.permonth"/></span>
							</h4>
							
							<h4>
								<small><spring:message code="system.promotion.pricing.payasyougo-rate"/></small>
								<p/>
								<c:if test="${locale == 'en_US' && (param.lang == null || param.lang == 'en_US')}">
									<i>$</i>8<i>.49</i>
								</c:if>
								<c:if test="${locale == 'ko_KR' || param.lang =='ko_KR'}"> 
									<i>&#8361;</i>8,500
								</c:if>
								<span><spring:message code="system.promotion.pricing.payasyougo-rate.persubmission"/></span>
							</h4>
						</div>
						<ul class="pricing-content list-unstyled">
							<li>
								<i class="fa fa-angle-right"></i> <spring:message code="system.promotion.pricing.support.0"/>
							</li>
							<li>
								<i class="fa fa-angle-right"></i> <spring:message code="system.promotion.pricing.support.1"/>
							</li>
							<li>
								<i class="fa fa-angle-right"></i> <spring:message code="system.promotion.pricing.support.2"/>
							</li>
							<li>
								<i class="fa fa-angle-right"></i> <spring:message code="system.promotion.pricing.support.4"/>
							</li>
							<li>
								<i class="fa fa-angle-right"></i> <spring:message code="system.promotion.pricing.support.5"/>
							</li>
							<li>
								&nbsp;
							</li>
						</ul>
						<div class="center cellCenter pricing-footer">
							<br/>
							<a class="btn btn-warning btn-sm" id="ajax-typeB" data-toggle="modal">
								 <spring:message code="system.service"/> <i class="m-icon-swapright m-icon-white"></i>
							</a>
							<br/><br/>
							<a href="${baseUrl}/submitJournal" class="btn btn-success">
								 <spring:message code="home.open2"/> <i class="m-icon-swapright m-icon-white"></i>
							</a>
							<br/><br/>
						</div>
					</div>
				</div>
				<div class="col-md-3">
					<div class="pricing hover-effect">
						<div class="pricing-head">
							<h3><spring:message code="system.typeC2"/>
							<span>
								 <spring:message code="system.nameTypeC2"/>
							</span>
							</h3>
							<h4>
								<small><spring:message code="system.promotion.pricing.flat-rate"/></small>
								<p/>
								<c:if test="${locale == 'en_US' && (param.lang == null || param.lang == 'en_US')}">
									<i>$</i>199<i>.99</i>
								</c:if>
								<c:if test="${locale == 'ko_KR' || param.lang =='ko_KR'}"> 
									<i>&#8361;</i>200,000
								</c:if>
								<span><spring:message code="system.promotion.pricing.flat-rate.permonth"/></span>
							</h4>
							
							<h4>
								<small><spring:message code="system.promotion.pricing.payasyougo-rate"/></small>
								<p/>
								<c:if test="${locale == 'en_US' && (param.lang == null || param.lang == 'en_US')}">
									<i>$</i>6<i>.49</i>
								</c:if>
								<c:if test="${locale == 'ko_KR' || param.lang =='ko_KR'}"> 
									<i>&#8361;</i>6,500
								</c:if>
								<span><spring:message code="system.promotion.pricing.payasyougo-rate.persubmission"/></span>
							</h4>
						</div>
						<ul class="pricing-content list-unstyled">
							<li>
								<i class="fa fa-angle-right"></i> <spring:message code="system.promotion.pricing.support.0"/>
							</li>
							<li>
								<i class="fa fa-angle-right"></i> <spring:message code="system.promotion.pricing.support.1"/>
							</li>
							<li>
								<i class="fa fa-angle-right"></i> <spring:message code="system.promotion.pricing.support.3"/>
							</li>
							<li>
								<i class="fa fa-angle-right"></i> <spring:message code="system.promotion.pricing.support.4"/>
							</li>
							<li>
								<i class="fa fa-angle-right"></i> <spring:message code="system.promotion.pricing.support.5"/>
							</li>
							<li>
								&nbsp;
							</li>
						</ul>
						<div class="center cellCenter pricing-footer">
							<br/>
							<a class="btn btn-warning btn-sm" id="ajax-typeC" data-toggle="modal">
								 <spring:message code="system.service"/> <i class="m-icon-swapright m-icon-white"></i>
							</a>
							<br/><br/>
							<a href="${baseUrl}/submitJournal" class="btn btn-success">
								 <spring:message code="home.open2"/> <i class="m-icon-swapright m-icon-white"></i>
							</a>
							<br/><br/>
						</div>
					</div>
				</div>
				<div class="col-md-3">
					<div class="pricing hover-effect">
						<div class="pricing-head">
							<h3><spring:message code="system.typeD2"/>
							<span>
								 <spring:message code="system.nameTypeD2"/>
								 <br/>&nbsp;
							</span>
							</h3>
							<h4>
								<small><spring:message code="system.promotion.pricing.flat-rate"/></small>
								<p/>
								<c:if test="${locale == 'en_US' && (param.lang == null || param.lang == 'en_US')}">
									<i>$</i>149<i>.99</i>
								</c:if>
								<c:if test="${locale == 'ko_KR' || param.lang =='ko_KR'}"> 
									<i>&#8361;</i>150,000
								</c:if>
								<span><spring:message code="system.promotion.pricing.flat-rate.permonth"/></span>
							</h4>
							
							<h4>
								<small><spring:message code="system.promotion.pricing.payasyougo-rate"/></small>
								<p/>
								<c:if test="${locale == 'en_US' && (param.lang == null || param.lang == 'en_US')}">
									<i>$</i>4<i>.99</i>
								</c:if>
								<c:if test="${locale == 'ko_KR' || param.lang =='ko_KR'}"> 
									<i>&#8361;</i>5,000
								</c:if>
								<span><spring:message code="system.promotion.pricing.payasyougo-rate.persubmission"/></span>
							</h4>
						</div>
						<ul class="pricing-content list-unstyled">
							<li>
								<i class="fa fa-angle-right"></i> <spring:message code="system.promotion.pricing.support.0"/>
							</li>
							<li>
								<i class="fa fa-angle-right"></i> <spring:message code="system.promotion.pricing.support.1"/>
							</li>
							<li>
								<i class="fa fa-angle-right"></i> <spring:message code="system.promotion.pricing.support.4"/>
							</li>
							<li>
								<i class="fa fa-angle-right"></i> <spring:message code="system.promotion.pricing.support.5"/>
							</li>
							<li>
								&nbsp;
							</li>
							<li>
								&nbsp;
							</li>
						</ul>
						<div class="center cellCenter pricing-footer">
							<br/>
							<a class="btn btn-warning btn-sm" id="ajax-typeD" data-toggle="modal">
								 <spring:message code="system.service"/> <i class="m-icon-swapright m-icon-white"></i>
							</a>
							<br/><br/>
							<a href="${baseUrl}/submitJournal" class="btn btn-success">
								 <spring:message code="home.open2"/> <i class="m-icon-swapright m-icon-white"></i>
							</a>
							<br/><br/>
						</div>
					</div>
				</div>
				<!--//End Pricing -->
			</div>
			<!-- END INLINE NOTIFICATIONS PORTLET-->
		</div>
	</div>
	
	<div class="row">
		<div class="col-md-12">
			<h4><spring:message code="system.promotion.pricing.details"/></h4>
			<h5>1. <spring:message code="system.promotion.pricing.flat-rate"/></h5>
			<ul>
				<li><spring:message code="system.promotion.pricing.flat-rate.desc.1"/>
				<li><spring:message code="system.promotion.pricing.flat-rate.desc.2"/>
			</ul>
			
			<h5>2. <spring:message code="system.promotion.pricing.payasyougo-rate"/></h5>
			<ul>
				<li><spring:message code="system.promotion.pricing.payasyougo-rate.desc.1"/>
				<li><spring:message code="system.promotion.pricing.payasyougo-rate.desc.2"/>
			</ul>
			
			<h5>3. <spring:message code="system.promotion.pricing.billing-cycle"/></h5>
			<ul>
				<li><spring:message code="system.promotion.pricing.billing-cycle.desc.1"/>
			</ul>
			<br/>
			<h4><spring:message code="system.promotion.pricing.additionalFee"/></h4>
			<h5>1. <spring:message code="system.promotion.pricing.customizations"/></h5>
			<ul>
				<li><spring:message code="system.promotion.pricing.customizations.desc.1"/>
				<li><spring:message code="system.promotion.pricing.customizations.desc.2"/>
			</ul>
		</div>
	</div>
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
<script src="${baseUrl}/js/homes/ui-extended-modals.js"></script>

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