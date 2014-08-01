<%@ page import="link.thinkonweb.configuration.SystemConstants" %>

<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8 no-js"> <![endif]-->
<!--[if IE 9]> <html lang="en" class="ie9 no-js"> <![endif]-->
<!--[if !IE]><!-->
<html lang="en" class="no-js">
<!--<![endif]-->

<head>
<title>Journal Gate</title>
<%@ include file="/WEB-INF/views/includes/header.jsp" %>
<link href="${baseUrl}/assets/plugins/select2/select2.css" rel="stylesheet" type="text/css" />
<link href="${baseUrl}/assets/plugins/select2/select2-metronic.css" rel="stylesheet" type="text/css"/>
<link href="${baseUrl}/assets/plugins/data-tables/DT_bootstrap.css" rel="stylesheet" />
<link href="${baseUrl}/assets/css/plugins.css" rel="stylesheet" type="text/css"/>
<link href="${baseUrl}/assets/css/style-metronic.css" rel="stylesheet" type="text/css"/>
<link href="${baseUrl}/assets/css/pages/profile.css" rel="stylesheet" type="text/css"/>
<link href="${baseUrl}/css/custom.css" rel="stylesheet" type="text/css"/>
<link href="${baseUrl}/css/custom.css" rel="stylesheet" type="text/css"/>
</head>




<body class="page-header-fixed">
<%@ include file="/WEB-INF/views/includes/headerBar.jsp" %>

<div class="page-container">
     
    <div class="container">
		
		<div class="row page-boxed">
			<div class="col-md-12">
				<ul class="page-breadcrumb breadcrumb">
					<li>
						<i class="fa fa-home"></i>
						<a href="${baseUrl}/journals/${jnid}">
							<spring:message code="system.home"/>
						</a>
					</li>
				</ul>
				
				<div class="tabbable tabbable-custom tabbable-full-width journalHomeTab">
					<ul class="nav nav-tabs">
						<li class="active">
							<a class="tabClick" href="#tab_1_1" data-toggle="tab">
								<spring:message code="journal.overview"/>
							</a>
						</li>
						<li>
							<a class="tabClick" href="#tab_1_2" data-toggle="tab">
								<spring:message code="journal.process"/>
							</a>
						</li>
						<li>
							<a class="tabClick" href="#tab_1_3" data-toggle="tab">
								<spring:message code="journal.committee"/>
							</a>
						</li>
					</ul>
					
					<div class="tab-content">
						<div class="tab-pane active" id="tab_1_1">
							<div class="row">
								<div class="col-md-3">
									<ul class="list-unstyled profile-nav">
										<li>
											<img src="${baseUrl}/images/coverImages/${journal.coverImageFilename}" class="img-responsive" alt=""/>
										</li>
									</ul>
								</div>
									<div class="col-md-9">
										<div class="row">
											<div class="col-md-8 profile-info">
												<h1>${journal.title}</h1>
												<c:if test="${not empty journal.about}">
													<p>${journal.about}</p>
												</c:if>
												
												<c:if test="${not empty journal.about}">
													<i class="fa fa-map-marker"></i>${journal.about}>
												</c:if>
												<p>
													<a href="#">
														 www.mywebsite.com
													</a>
												</p>
												<ul class="list-inline">
													<li>
														<i class="fa fa-map-marker"></i> Spain
													</li>
													<li>
														<i class="fa fa-calendar"></i> 18 Jan 1982
													</li>
													<li>
														<i class="fa fa-briefcase"></i> Design
													</li>
													<li>
														<i class="fa fa-star"></i> Top Seller
													</li>
													<li>
														<i class="fa fa-heart"></i> BASE Jumping
													</li>
												</ul>
											</div>
											<!--end col-md-8-->
											<div class="col-md-4">
												<div class="portlet sale-summary">
													<div class="portlet-title pull-right">
														<div class="caption">
															 <h2><spring:message code="journal.stats"/></h2>
														</div>
														<div class="tools">
															<a class="reload" href="javascript:;">
															</a>
														</div>
													</div>
													<div class="clearfix"></div>
													<div class="portlet-body">
														<ul class="list-unstyled">
															<li>
																<span class="sale-info">
																	 <spring:message code="journal.totalSubmissions"/>
																</span>
																<span class="sale-num">
																	 123
																</span>
															</li>
															<li>
																<span class="sale-info">
																	 <spring:message code="journal.manuscriptsInReview"/>
																</span>
																<span class="sale-num">
																	 87
																</span>
															</li>
															<li>
																<span class="sale-info">
																	 <spring:message code="journal.manuscriptsAccepted"/>
																</span>
																<span class="sale-num">
																	 22
																</span>
															</li>
														</ul>
													</div>
												</div>
											</div>
											<!--end col-md-4-->
										</div>
									</div>
							</div>
						</div>
						
						<!--tab_1_2-->
						<div class="tab-pane" id="tab_1_2">
							<div class="row">
								<div class="col-md-12">

								</div>
							</div>
						</div>
						
						
						<!--tab_1_3-->
						<div class="tab-pane" id="tab_1_3">
							<div class="row">
								<div class="col-md-12">

								</div>
							</div>
						</div>
					</div>
				</div>
				
			</div>
		</div>
	</div>
</div>
<footer>
<%@ include file="/WEB-INF/views/includes/footerBar.jsp" %>
<script src="${baseUrl}/assets/plugins/jquery-validation/dist/jquery.validate.js" type="text/javascript" ></script>
<script src="${baseUrl}/assets/plugins/jquery-validation/dist/additional-methods.min.js" type="text/javascript"></script>
<script src="${baseUrl}/assets/plugins/select2/select2.min.js" type="text/javascript" ></script>
<script src="${baseUrl}/js/roles/manuscriptTable_jquery.dataTables.js" type="text/javascript" ></script>
<script src="${baseUrl}/js/roles/manuscriptTable_DT_bootstrap.js" type="text/javascript" ></script>

<script src="${baseUrl}/assets/scripts/core/app.js" type="text/javascript"></script>
<script src="${baseUrl}/js/roles/datatable.js"></script>
<script src="${baseUrl}/js/roles/associateEditor/assignedManuscriptTable-editable.js"></script>
<script src="${baseUrl}/js/roles/associateEditor/reReviewRequiredManuscriptTable-editable.js"></script>
<script src="${baseUrl}/js/roles/associateEditor/oldManuscriptTable-ajax.js"></script>
</footer>

<script>
var tableViewId = "";
var viewId = "";
var firstTabWidth = 0;
function viewManuscript(manuscriptId) {
	tableViewId = '#aeOld-t';
	viewId = '#aeOld-v';
	$(tableViewId).hide();
	var url = "${baseUrl}/journals/${jnid}/associateEditor/manuscripts/viewManuscript?manuscriptId=" + manuscriptId;
	jQuery.ajax({
		type:"GET",
		url: url,
		success:function(html){
			$(viewId).hide();
			$(viewId).html(html).show('normal');
		}
	});
}
jQuery(document).ready(function() {
	App.init();
	AssignedTableEditable.init();
	ReReviewTableEditable.init();
	
	OldManuscriptTableAjax.init("${ajaxRequestUrl}");
	
	firstTabWidth = $('.tabClick:first').parent("li").width();
	
	$(".form-filter").on("keyup change", function () {
		oTable.fnFilter( this.value, $(".form-filter").index(this) );
	} );
	$('.assignedManuscript').click(function(event) {
		event.preventDefault();
		tableViewId = '#aeAssigned-t';
		viewId = '#aeAssigned-v';
		$(tableViewId).hide();

		var manuscriptId = $(this).attr("data-manuscriptId");
		var url = "${baseUrl}/journals/${jnid}/associateEditor/manuscripts/viewManuscript?manuscriptId=" + manuscriptId;
		
		jQuery.ajax({
			type:"GET",
			url: url,
			success:function(html){
				$(viewId).hide();
				$(viewId).html(html).show('normal');
			}
		});
		
	});
	
	$('.reReviewManuscript').click(function(event) {
		event.preventDefault();
		tableViewId = '#aeReReviewRequired-t';
		viewId = '#aeReReviewRequired-v';
		$(tableViewId).hide();

		var manuscriptId = $(this).attr("data-manuscriptId");
		var url = "${baseUrl}/journals/${jnid}/associateEditor/manuscripts/viewManuscript?manuscriptId=" + manuscriptId;
		
		jQuery.ajax({
			type:"GET",
			url: url,
			success:function(html){
				$(viewId).hide();
				$(viewId).html(html).show('normal');
			}
		});
		
	});

});
</script>

<!-- END JAVASCRIPTS -->
</body>
<!-- END BODY -->
</html>