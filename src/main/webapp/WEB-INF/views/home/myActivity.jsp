<%@ page import="link.thinkonweb.configuration.SystemConstants" %>
<%@ taglib prefix="customTagFile" tagdir="/WEB-INF/tags" %>

<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8 no-js"> <![endif]-->
<!--[if IE 9]> <html lang="en" class="ie9 no-js"> <![endif]-->
<!--[if !IE]><!-->
<html lang="en" class="no-js">
<!--<![endif]-->

<head>
<%@ include file="/WEB-INF/views/includes/header.jsp" %>
<title><spring:message code="system.myActivity"/></title>
<link href="${baseUrl}/assets/plugins/select2/select2.css" rel="stylesheet" type="text/css" />
<link href="${baseUrl}/assets/plugins/select2/select2-metronic.css" rel="stylesheet" type="text/css"/>
<link href="${baseUrl}/assets/plugins/data-tables/DT_bootstrap.css" rel="stylesheet" />
<link href="${baseUrl}/assets/css/plugins.css" rel="stylesheet" type="text/css"/>
<link href="${baseUrl}/assets/css/style-metronic.css" rel="stylesheet" type="text/css"/>
<link href="${baseUrl}/assets/css/pages/profile.css" rel="stylesheet" type="text/css"/>
<link href="${baseUrl}/css/custom.css" rel="stylesheet" type="text/css"/>
<link href="${baseUrl}/css/jquery-ui.css" rel="stylesheet" type="text/css"/>
<style>
.tooltip-inner {
	max-width: 300px;
	min-width: 300px;
	text-align: left;
}
</style>
</head>
<body class="page-header-fixed">
<%@ include file="/WEB-INF/views/includes/headerBar.jsp" %>
<div class="clearfix">
</div>
<input type="hidden" id="username_var" value="${user.username}"/>
<input type="hidden" id="numberOfjournalsInMember" value="${numberOfjournalsInMember}"/>
<input type="hidden" id="numberOfCoWrittenManuscriptsInMember" value="${numberOfCoWrittenManuscriptsInMember}"/>
<input type="hidden" id="numberOfReviewMenuscriptsInMember" value="${numberOfReviewMenuscriptsInMember}"/>
<div id="viewFeedDisplay" class="modalDialog"></div>
<div class="page-container">
    <div class="container">
    	<br/><br/>	
		<div class="row page-boxed">
			<div class="col-md-12">
				<div class="tabbable tabbable-custom tabbable-full-width">
					<ul class="nav nav-tabs">
						<li class="active">
							<a href="#tab_1_1" data-toggle="tab">
								 <spring:message code="system.myJournal"/>
							</a>
						</li>
						<li>
							<a href="#tab_1_2" data-toggle="tab">
								 <spring:message code="system.myManuscripts"/>
							</a>
						</li>
						<li>
							<a href="#tab_1_3" data-toggle="tab">
								 <spring:message code="system.myReviewManuscripts"/>
							</a>
						</li>
						<li>
							<a href="#tab_1_4" data-toggle="tab">
								 <spring:message code="system.myfeeds"/>
							</a>
						</li>
					</ul>
					
					<div class="tab-content">
						<div class="tab-pane active" id="tab_1_1">
							<div class="row">
								<div class="col-md-12">
									<customTagFile:personalInfo baseUrl="${baseUrl}"/>
									<div class="tab-content">
											<div class="tab-pane active" id="tab_1_11">
												<div class="table-container">
													<table class="table table-striped table-bordered table-hover fixedWidthSize" id="myActivity_journalList_ajax">
													<thead>
													<tr class="heading">
														<th class="text-middle"> </th>
														<th class="text-middle" id="title_header">
															<spring:message code="journal.title"/>
														</th>
														<th class="text-middle">
															<spring:message code="journal.organization"/>
														</th>
														<th class="text-middle">
															<spring:message code="journal.language"/>
														</th>
														<th class="text-middle">
															<spring:message code="system.myManuscripts"/><sup>*</sup>
														</th>
														<th class="text-middle">
															<spring:message code="system.myReviewManuscripts"/><sup>**</sup>
														</th>
														<th class="text-middle">
															<spring:message code="system.myRoleAndCorrespondingDashboad"/>
														</th>
													</tr>
													</thead>
													<tbody>
													</tbody>
													</table>
													<div>
													<div class="text-right">* <spring:message code="system.myActivityComment1"/></div>
													<div class="text-right">** <spring:message code="system.myActivityComment2"/></div>
													</div>
													<br/>
													<br/>
												</div>
											</div>
										</div>
								</div>
							</div>
						</div>
						
						<!--tab_1_2-->
						<div class="tab-pane" id="tab_1_2">
							<div class="row">
								<div class="col-md-12">
									<customTagFile:personalInfo baseUrl="${baseUrl}"/>
									
									<div class="tab-content">
											<div class="tab-pane active" id="tab_1_22">
												<div class="table-container">
													<table class="table table-striped table-bordered table-hover fixedWidthSize" id="myActivity_manuscriptList_ajax">
													<thead>
													<tr class="heading">
														<th class="text-middle"> </th>
														<th class="text-middle" id="title_header">
															<spring:message code="manuscript.title"/>
														</th>
														<th class="text-middle">
															<spring:message code="manuscript.authors"/>
														</th>
														<th class="text-middle">
															<spring:message code="manuscript.authorsOrder2"/>
														</th>
														<th class="text-middle">
															<spring:message code="manuscript.submitter"/>
														</th>
														<th class="text-middle">
															<spring:message code="manuscript.correspondingAuthor"/>
														</th>
														<th class="text-middle">
															<spring:message code="journal.title"/>
														</th>
														<th class="text-middle">
															<spring:message code="manuscript.submitDate"/>
														</th>
														<th class="text-middle">
															<a class="tooltipAnchor" href="#" rel="tooltip" data-html="true" title="${statusTooltipData}"><spring:message code="manuscript.status"/>&nbsp;</a>
														</th>
														<th class="text-middle">
															<spring:message code="system.action"/>
														</th>
													</tr>
													</thead>
													<tbody>
													</tbody>
													</table>
													<br/>
													<br/>
												</div>
											</div>
										</div>
								</div>
							</div>
						</div>
						
						<!--tab_1_3-->
						<div class="tab-pane" id="tab_1_3">
							<div class="row">
								<div class="col-md-12">
									<customTagFile:personalInfo baseUrl="${baseUrl}"/>
									
									<div class="tab-content">
											<div class="tab-pane active" id="tab_1_33">
												<div class="table-container">
													<table class="table table-striped table-bordered table-hover fixedWidthSize" id="myActivity_reviewManuscriptList_ajax">
													<thead>
													<tr class="heading">
														<th class="text-middle"> </th>
														<th class="text-middle" id="title_header">
															<spring:message code="manuscript.title"/>
														</th>
														<th class="text-middle">
															<spring:message code="journal.title"/>
														</th>
														<th class="text-middle">
															<spring:message code="system.version"/>
														</th>
														<th class="text-middle">
															<spring:message code="reviewer.assignDate2"/>
														</th>
														<th class="text-middle">
															<spring:message code="reviewResult.dueDate"/>
														</th>
														<th class="text-middle">
															<spring:message code="reviewer.completeDate"/>
														</th>													
														<th class="text-middle">
															<spring:message code="reviewer.status"/>
														</th>
														<th class="text-middle">
															<spring:message code="system.action"/>
														</th>
													</tr>
													</thead>
													<tbody>
													</tbody>
													</table>
													<br/>
													<br/>
												</div>
											</div>
										</div>
								</div>
							</div>
						</div>
						
						<!--tab_1_4-->
						<div class="tab-pane" id="tab_1_4">
							<div class="row">
								<div class="col-md-12">
									<customTagFile:personalInfo baseUrl="${baseUrl}"/>
									
									<div class="table-container">
										<table class="table table-striped table-bordered table-hover fixedWidthSize" id="myActivity_feedsList_ajax">
										<thead>
										<tr class="heading">
											<th class="text-middle"> </th>
											<th class="text-middle" id="title_header">
												<spring:message code="mail.subject"/>
											</th>
											<th class="text-middle">
												<spring:message code="system.date"/>
											</th>
											<th class="text-middle">
												<spring:message code="system.time"/>
											</th>
										</tr>
										</thead>
										<tbody>
										</tbody>
										</table>
										<br/>
										<br/>
									</div>
								</div>
							</div>
						</div>
						<!--end tab-pane-->
						<div class="tab-pane" id="tab_1_6">
							<div class="row">
								<div class="col-md-3">
									<ul class="ver-inline-menu tabbable margin-bottom-10">
										<li class="active">
											<a data-toggle="tab" href="#tab_1">
												<i class="fa fa-briefcase"></i> General Questions
											</a>
											<span class="after">
											</span>
										</li>
										<li>
											<a data-toggle="tab" href="#tab_2">
												<i class="fa fa-group"></i> Membership
											</a>
										</li>
										<li>
											<a data-toggle="tab" href="#tab_3">
												<i class="fa fa-leaf"></i> Terms Of Service
											</a>
										</li>
										<li>
											<a data-toggle="tab" href="#tab_1">
												<i class="fa fa-info-circle"></i> License Terms
											</a>
										</li>
										<li>
											<a data-toggle="tab" href="#tab_2">
												<i class="fa fa-tint"></i> Payment Rules
											</a>
										</li>
										<li>
											<a data-toggle="tab" href="#tab_3">
												<i class="fa fa-plus"></i> Other Questions
											</a>
										</li>
									</ul>
								</div>
								<div class="col-md-9">
									<div class="tab-content">
										<div id="tab_1" class="tab-pane active">
											<div id="accordion1" class="panel-group">
												<div class="panel panel-default">
													<div class="panel-heading">
														<h4 class="panel-title">
														<a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion1" href="#accordion1_1">
															 1. Anim pariatur cliche reprehenderit, enim eiusmod high life accusamus terry ?
														</a>
														</h4>
													</div>
													<div id="accordion1_1" class="panel-collapse collapse in">
														<div class="panel-body">
															 Anim pariatur cliche reprehenderit, enim eiusmod high life accusamus terry richardson ad squid. 3 wolf moon officia aute, non cupidatat skateboard dolor brunch. Food truck quinoa nesciunt laborum eiusmod. Brunch 3 wolf moon tempor, sunt aliqua put a bird on it squid single-origin coffee nulla assumenda shoreditch et. Nihil anim keffiyeh helvetica, craft beer labore wes anderson cred nesciunt sapiente ea proident. Ad vegan excepteur butcher vice lomo. Leggings occaecat craft beer farm-to-table, raw denim aesthetic synth nesciunt you probably haven't heard of them accusamus labore sustainable VHS.
														</div>
													</div>
												</div>
												<div class="panel panel-default">
													<div class="panel-heading">
														<h4 class="panel-title">
														<a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion1" href="#accordion1_2">
															 2. Anim pariatur cliche reprehenderit, enim eiusmod high life accusamus terry ?
														</a>
														</h4>
													</div>
													<div id="accordion1_2" class="panel-collapse collapse">
														<div class="panel-body">
															 Food truck quinoa nesciunt laborum eiusmod. Brunch 3 wolf moon tempor, sunt aliqua put a bird on it squid single-origin coffee nulla assumenda shoreditch et. Anim pariatur cliche reprehenderit, enim eiusmod high life accusamus terry richardson ad squid. 3 wolf moon officia aute, non cupidatat skateboard dolor brunch. Food truck quinoa nesciunt laborum eiusmod. Brunch 3 wolf moon tempor, sunt aliqua put a bird on it squid single-origin coffee nulla assumenda shoreditch et. Nihil anim keffiyeh helvetica, craft beer labore wes anderson cred nesciunt sapiente ea proident. Ad vegan excepteur butcher vice lomo. Leggings occaecat craft beer farm-to-table, raw denim aesthetic synth nesciunt you probably haven't heard of them accusamus labore sustainable VHS.
														</div>
													</div>
												</div>
												<div class="panel panel-success">
													<div class="panel-heading">
														<h4 class="panel-title">
														<a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion1" href="#accordion1_3">
															 3. Food truck quinoa nesciunt laborum eiusmod. Brunch 3 wolf moon tempor ?
														</a>
														</h4>
													</div>
													<div id="accordion1_3" class="panel-collapse collapse">
														<div class="panel-body">
															 Food truck quinoa nesciunt laborum eiusmod. Brunch 3 wolf moon tempor, sunt aliqua put a bird on it squid single-origin coffee nulla assumenda shoreditch et. Anim pariatur cliche reprehenderit, enim eiusmod high life accusamus terry richardson ad squid. 3 wolf moon officia aute, non cupidatat skateboard dolor brunch. Food truck quinoa nesciunt laborum eiusmod. Brunch 3 wolf moon tempor, sunt aliqua put a bird on it squid single-origin coffee nulla assumenda shoreditch et. Nihil anim keffiyeh helvetica, craft beer labore wes anderson cred nesciunt sapiente ea proident. Ad vegan excepteur butcher vice lomo. Leggings occaecat craft beer farm-to-table, raw denim aesthetic synth nesciunt you probably haven't heard of them accusamus labore sustainable VHS.
														</div>
													</div>
												</div>
												<div class="panel panel-warning">
													<div class="panel-heading">
														<h4 class="panel-title">
														<a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion1" href="#accordion1_4">
															 4. Wolf moon officia aute, non cupidatat skateboard dolor brunch ?
														</a>
														</h4>
													</div>
													<div id="accordion1_4" class="panel-collapse collapse">
														<div class="panel-body">
															 3 wolf moon officia aute, non cupidatat skateboard dolor brunch. Food truck quinoa nesciunt laborum eiusmod. Brunch 3 wolf moon tempor, sunt aliqua put a bird on it squid single-origin coffee nulla assumenda shoreditch et. Nihil anim keffiyeh helvetica, craft beer labore wes anderson cred nesciunt sapiente ea proident. Ad vegan excepteur butcher vice lomo. Leggings occaecat craft beer farm-to-table, raw denim aesthetic synth nesciunt you probably haven't heard of them accusamus labore sustainable VHS.
														</div>
													</div>
												</div>
												<div class="panel panel-danger">
													<div class="panel-heading">
														<h4 class="panel-title">
														<a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion1" href="#accordion1_5">
															 5. Leggings occaecat craft beer farm-to-table, raw denim aesthetic ?
														</a>
														</h4>
													</div>
													<div id="accordion1_5" class="panel-collapse collapse">
														<div class="panel-body">
															 3 wolf moon officia aute, non cupidatat skateboard dolor brunch. Food truck quinoa nesciunt laborum eiusmod. Brunch 3 wolf moon tempor, sunt aliqua put a bird on it squid single-origin coffee nulla assumenda shoreditch et. Nihil anim keffiyeh helvetica, craft beer labore wes anderson cred nesciunt sapiente ea proident. Ad vegan excepteur butcher vice lomo. Leggings occaecat craft beer farm-to-table, raw denim aesthetic synth nesciunt you probably haven't heard of them accusamus labore sustainable VHS. Food truck quinoa nesciunt laborum eiusmod. Brunch 3 wolf moon tempor, sunt aliqua put a bird on it squid single-origin coffee nulla assumenda shoreditch et
														</div>
													</div>
												</div>
												<div class="panel panel-default">
													<div class="panel-heading">
														<h4 class="panel-title">
														<a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion1" href="#accordion1_6">
															 6. Leggings occaecat craft beer farm-to-table, raw denim aesthetic synth ?
														</a>
														</h4>
													</div>
													<div id="accordion1_6" class="panel-collapse collapse">
														<div class="panel-body">
															 3 wolf moon officia aute, non cupidatat skateboard dolor brunch. Food truck quinoa nesciunt laborum eiusmod. Brunch 3 wolf moon tempor, sunt aliqua put a bird on it squid single-origin coffee nulla assumenda shoreditch et. Nihil anim keffiyeh helvetica, craft beer labore wes anderson cred nesciunt sapiente ea proident. Ad vegan excepteur butcher vice lomo. Leggings occaecat craft beer farm-to-table, raw denim aesthetic synth nesciunt you probably haven't heard of them accusamus labore sustainable VHS. Food truck quinoa nesciunt laborum eiusmod. Brunch 3 wolf moon tempor, sunt aliqua put a bird on it squid single-origin coffee nulla assumenda shoreditch et
														</div>
													</div>
												</div>
												<div class="panel panel-default">
													<div class="panel-heading">
														<h4 class="panel-title">
														<a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion1" href="#accordion1_7">
															 7. Ad vegan excepteur butcher vice lomo. Leggings occaecat craft ?
														</a>
														</h4>
													</div>
													<div id="accordion1_7" class="panel-collapse collapse">
														<div class="panel-body">
															 3 wolf moon officia aute, non cupidatat skateboard dolor brunch. Food truck quinoa nesciunt laborum eiusmod. Brunch 3 wolf moon tempor, sunt aliqua put a bird on it squid single-origin coffee nulla assumenda shoreditch et. Nihil anim keffiyeh helvetica, craft beer labore wes anderson cred nesciunt sapiente ea proident. Ad vegan excepteur butcher vice lomo. Leggings occaecat craft beer farm-to-table, raw denim aesthetic synth nesciunt you probably haven't heard of them accusamus labore sustainable VHS. Food truck quinoa nesciunt laborum eiusmod. Brunch 3 wolf moon tempor, sunt aliqua put a bird on it squid single-origin coffee nulla assumenda shoreditch et
														</div>
													</div>
												</div>
											</div>
										</div>
										<div id="tab_2" class="tab-pane">
											<div id="accordion2" class="panel-group">
												<div class="panel panel-warning">
													<div class="panel-heading">
														<h4 class="panel-title">
														<a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion2" href="#accordion2_1">
															 1. Anim pariatur cliche reprehenderit, enim eiusmod high life accusamus terry ?
														</a>
														</h4>
													</div>
													<div id="accordion2_1" class="panel-collapse collapse in">
														<div class="panel-body">
															<p>
																 Anim pariatur cliche reprehenderit, enim eiusmod high life accusamus terry richardson ad squid. 3 wolf moon officia aute, non cupidatat skateboard dolor brunch. Food truck quinoa nesciunt laborum eiusmod. Brunch 3 wolf moon tempor, sunt aliqua put a bird on it squid single-origin coffee nulla assumenda shoreditch et. Nihil anim keffiyeh helvetica, craft beer labore wes anderson cred nesciunt sapiente ea proident. Ad vegan excepteur butcher vice lomo. Leggings occaecat craft beer farm-to-table, raw denim aesthetic synth nesciunt you probably haven't heard of them accusamus labore sustainable VHS.
															</p>
															<p>
																 Anim pariatur cliche reprehenderit, enim eiusmod high life accusamus terry richardson ad squid. 3 wolf moon officia aute, non cupidatat skateboard dolor brunch. Food truck quinoa nesciunt laborum eiusmod. Brunch 3 wolf moon tempor, sunt aliqua put a bird on it squid single-origin coffee nulla assumenda shoreditch et. Nihil anim keffiyeh helvetica, craft beer labore wes anderson cred nesciunt sapiente ea proident. Ad vegan excepteur butcher vice lomo. Leggings occaecat craft beer farm-to-table, raw denim aesthetic synth nesciunt you probably haven't heard of them accusamus labore sustainable VHS.
															</p>
														</div>
													</div>
												</div>
												<div class="panel panel-danger">
													<div class="panel-heading">
														<h4 class="panel-title">
														<a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion2" href="#accordion2_2">
															 2. Anim pariatur cliche reprehenderit, enim eiusmod high life accusamus terry ?
														</a>
														</h4>
													</div>
													<div id="accordion2_2" class="panel-collapse collapse">
														<div class="panel-body">
															 Food truck quinoa nesciunt laborum eiusmod. Brunch 3 wolf moon tempor, sunt aliqua put a bird on it squid single-origin coffee nulla assumenda shoreditch et. Anim pariatur cliche reprehenderit, enim eiusmod high life accusamus terry richardson ad squid. 3 wolf moon officia aute, non cupidatat skateboard dolor brunch. Food truck quinoa nesciunt laborum eiusmod. Brunch 3 wolf moon tempor, sunt aliqua put a bird on it squid single-origin coffee nulla assumenda shoreditch et. Nihil anim keffiyeh helvetica, craft beer labore wes anderson cred nesciunt sapiente ea proident. Ad vegan excepteur butcher vice lomo. Leggings occaecat craft beer farm-to-table, raw denim aesthetic synth nesciunt you probably haven't heard of them accusamus labore sustainable VHS.
														</div>
													</div>
												</div>
												<div class="panel panel-success">
													<div class="panel-heading">
														<h4 class="panel-title">
														<a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion2" href="#accordion2_3">
															 3. Food truck quinoa nesciunt laborum eiusmod. Brunch 3 wolf moon tempor ?
														</a>
														</h4>
													</div>
													<div id="accordion2_3" class="panel-collapse collapse">
														<div class="panel-body">
															 Food truck quinoa nesciunt laborum eiusmod. Brunch 3 wolf moon tempor, sunt aliqua put a bird on it squid single-origin coffee nulla assumenda shoreditch et. Anim pariatur cliche reprehenderit, enim eiusmod high life accusamus terry richardson ad squid. 3 wolf moon officia aute, non cupidatat skateboard dolor brunch. Food truck quinoa nesciunt laborum eiusmod. Brunch 3 wolf moon tempor, sunt aliqua put a bird on it squid single-origin coffee nulla assumenda shoreditch et. Nihil anim keffiyeh helvetica, craft beer labore wes anderson cred nesciunt sapiente ea proident. Ad vegan excepteur butcher vice lomo. Leggings occaecat craft beer farm-to-table, raw denim aesthetic synth nesciunt you probably haven't heard of them accusamus labore sustainable VHS.
														</div>
													</div>
												</div>
												<div class="panel panel-default">
													<div class="panel-heading">
														<h4 class="panel-title">
														<a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion2" href="#accordion2_4">
															 4. Wolf moon officia aute, non cupidatat skateboard dolor brunch ?
														</a>
														</h4>
													</div>
													<div id="accordion2_4" class="panel-collapse collapse">
														<div class="panel-body">
															 3 wolf moon officia aute, non cupidatat skateboard dolor brunch. Food truck quinoa nesciunt laborum eiusmod. Brunch 3 wolf moon tempor, sunt aliqua put a bird on it squid single-origin coffee nulla assumenda shoreditch et. Nihil anim keffiyeh helvetica, craft beer labore wes anderson cred nesciunt sapiente ea proident. Ad vegan excepteur butcher vice lomo. Leggings occaecat craft beer farm-to-table, raw denim aesthetic synth nesciunt you probably haven't heard of them accusamus labore sustainable VHS.
														</div>
													</div>
												</div>
												<div class="panel panel-default">
													<div class="panel-heading">
														<h4 class="panel-title">
														<a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion2" href="#accordion2_5">
															 5. Leggings occaecat craft beer farm-to-table, raw denim aesthetic ?
														</a>
														</h4>
													</div>
													<div id="accordion2_5" class="panel-collapse collapse">
														<div class="panel-body">
															 3 wolf moon officia aute, non cupidatat skateboard dolor brunch. Food truck quinoa nesciunt laborum eiusmod. Brunch 3 wolf moon tempor, sunt aliqua put a bird on it squid single-origin coffee nulla assumenda shoreditch et. Nihil anim keffiyeh helvetica, craft beer labore wes anderson cred nesciunt sapiente ea proident. Ad vegan excepteur butcher vice lomo. Leggings occaecat craft beer farm-to-table, raw denim aesthetic synth nesciunt you probably haven't heard of them accusamus labore sustainable VHS. Food truck quinoa nesciunt laborum eiusmod. Brunch 3 wolf moon tempor, sunt aliqua put a bird on it squid single-origin coffee nulla assumenda shoreditch et
														</div>
													</div>
												</div>
												<div class="panel panel-default">
													<div class="panel-heading">
														<h4 class="panel-title">
														<a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion2" href="#accordion2_6">
															 6. Leggings occaecat craft beer farm-to-table, raw denim aesthetic synth ?
														</a>
														</h4>
													</div>
													<div id="accordion2_6" class="panel-collapse collapse">
														<div class="panel-body">
															 3 wolf moon officia aute, non cupidatat skateboard dolor brunch. Food truck quinoa nesciunt laborum eiusmod. Brunch 3 wolf moon tempor, sunt aliqua put a bird on it squid single-origin coffee nulla assumenda shoreditch et. Nihil anim keffiyeh helvetica, craft beer labore wes anderson cred nesciunt sapiente ea proident. Ad vegan excepteur butcher vice lomo. Leggings occaecat craft beer farm-to-table, raw denim aesthetic synth nesciunt you probably haven't heard of them accusamus labore sustainable VHS. Food truck quinoa nesciunt laborum eiusmod. Brunch 3 wolf moon tempor, sunt aliqua put a bird on it squid single-origin coffee nulla assumenda shoreditch et
														</div>
													</div>
												</div>
												<div class="panel panel-default">
													<div class="panel-heading">
														<h4 class="panel-title">
														<a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion2" href="#accordion2_7">
															 7. Ad vegan excepteur butcher vice lomo. Leggings occaecat craft ?
														</a>
														</h4>
													</div>
													<div id="accordion2_7" class="panel-collapse collapse">
														<div class="panel-body">
															 3 wolf moon officia aute, non cupidatat skateboard dolor brunch. Food truck quinoa nesciunt laborum eiusmod. Brunch 3 wolf moon tempor, sunt aliqua put a bird on it squid single-origin coffee nulla assumenda shoreditch et. Nihil anim keffiyeh helvetica, craft beer labore wes anderson cred nesciunt sapiente ea proident. Ad vegan excepteur butcher vice lomo. Leggings occaecat craft beer farm-to-table, raw denim aesthetic synth nesciunt you probably haven't heard of them accusamus labore sustainable VHS. Food truck quinoa nesciunt laborum eiusmod. Brunch 3 wolf moon tempor, sunt aliqua put a bird on it squid single-origin coffee nulla assumenda shoreditch et
														</div>
													</div>
												</div>
											</div>
										</div>
										<div id="tab_3" class="tab-pane">
											<div id="accordion3" class="panel-group">
												<div class="panel panel-danger">
													<div class="panel-heading">
														<h4 class="panel-title">
														<a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion3" href="#accordion3_1">
															 1. Anim pariatur cliche reprehenderit, enim eiusmod high life accusamus terry ?
														</a>
														</h4>
													</div>
													<div id="accordion3_1" class="panel-collapse collapse in">
														<div class="panel-body">
															<p>
																 Anim pariatur cliche reprehenderit, enim eiusmod high life accusamus terry richardson ad squid. 3 wolf moon officia aute, non cupidatat skateboard dolor brunch. Food truck quinoa nesciunt laborum eiusmod. Brunch 3 wolf moon tempor, sunt aliqua put a bird on it squid single-origin coffee nulla assumenda shoreditch et.
															</p>
															<p>
																 Anim pariatur cliche reprehenderit, enim eiusmod high life accusamus terry richardson ad squid. 3 wolf moon officia aute, non cupidatat skateboard dolor brunch. Food truck quinoa nesciunt laborum eiusmod. Brunch 3 wolf moon tempor, sunt aliqua put a bird on it squid single-origin coffee nulla assumenda shoreditch et.
															</p>
															<p>
																 Food truck quinoa nesciunt laborum eiusmod. Brunch 3 wolf moon tempor, sunt aliqua put a bird on it squid single-origin coffee nulla assumenda shoreditch et. Nihil anim keffiyeh helvetica, craft beer labore wes anderson cred nesciunt sapiente ea proident. Ad vegan excepteur butcher vice lomo. Leggings occaecat craft beer farm-to-table, raw denim aesthetic synth nesciunt you probably haven't heard of them accusamus labore sustainable VHS.
															</p>
														</div>
													</div>
												</div>
												<div class="panel panel-success">
													<div class="panel-heading">
														<h4 class="panel-title">
														<a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion3" href="#accordion3_2">
															 2. Anim pariatur cliche reprehenderit, enim eiusmod high life accusamus terry ?
														</a>
														</h4>
													</div>
													<div id="accordion3_2" class="panel-collapse collapse">
														<div class="panel-body">
															 Food truck quinoa nesciunt laborum eiusmod. Brunch 3 wolf moon tempor, sunt aliqua put a bird on it squid single-origin coffee nulla assumenda shoreditch et. Anim pariatur cliche reprehenderit, enim eiusmod high life accusamus terry richardson ad squid. 3 wolf moon officia aute, non cupidatat skateboard dolor brunch. Food truck quinoa nesciunt laborum eiusmod. Brunch 3 wolf moon tempor, sunt aliqua put a bird on it squid single-origin coffee nulla assumenda shoreditch et. Nihil anim keffiyeh helvetica, craft beer labore wes anderson cred nesciunt sapiente ea proident. Ad vegan excepteur butcher vice lomo. Leggings occaecat craft beer farm-to-table, raw denim aesthetic synth nesciunt you probably haven't heard of them accusamus labore sustainable VHS.
														</div>
													</div>
												</div>
												<div class="panel panel-default">
													<div class="panel-heading">
														<h4 class="panel-title">
														<a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion3" href="#accordion3_3">
															 3. Food truck quinoa nesciunt laborum eiusmod. Brunch 3 wolf moon tempor ?
														</a>
														</h4>
													</div>
													<div id="accordion3_3" class="panel-collapse collapse">
														<div class="panel-body">
															 Food truck quinoa nesciunt laborum eiusmod. Brunch 3 wolf moon tempor, sunt aliqua put a bird on it squid single-origin coffee nulla assumenda shoreditch et. Anim pariatur cliche reprehenderit, enim eiusmod high life accusamus terry richardson ad squid. 3 wolf moon officia aute, non cupidatat skateboard dolor brunch. Food truck quinoa nesciunt laborum eiusmod. Brunch 3 wolf moon tempor, sunt aliqua put a bird on it squid single-origin coffee nulla assumenda shoreditch et. Nihil anim keffiyeh helvetica, craft beer labore wes anderson cred nesciunt sapiente ea proident. Ad vegan excepteur butcher vice lomo. Leggings occaecat craft beer farm-to-table, raw denim aesthetic synth nesciunt you probably haven't heard of them accusamus labore sustainable VHS.
														</div>
													</div>
												</div>
												<div class="panel panel-default">
													<div class="panel-heading">
														<h4 class="panel-title">
														<a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion3" href="#accordion3_4">
															 4. Wolf moon officia aute, non cupidatat skateboard dolor brunch ?
														</a>
														</h4>
													</div>
													<div id="accordion3_4" class="panel-collapse collapse">
														<div class="panel-body">
															 3 wolf moon officia aute, non cupidatat skateboard dolor brunch. Food truck quinoa nesciunt laborum eiusmod. Brunch 3 wolf moon tempor, sunt aliqua put a bird on it squid single-origin coffee nulla assumenda shoreditch et. Nihil anim keffiyeh helvetica, craft beer labore wes anderson cred nesciunt sapiente ea proident. Ad vegan excepteur butcher vice lomo. Leggings occaecat craft beer farm-to-table, raw denim aesthetic synth nesciunt you probably haven't heard of them accusamus labore sustainable VHS.
														</div>
													</div>
												</div>
												<div class="panel panel-default">
													<div class="panel-heading">
														<h4 class="panel-title">
														<a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion3" href="#accordion3_5">
															 5. Leggings occaecat craft beer farm-to-table, raw denim aesthetic ?
														</a>
														</h4>
													</div>
													<div id="accordion3_5" class="panel-collapse collapse">
														<div class="panel-body">
															 3 wolf moon officia aute, non cupidatat skateboard dolor brunch. Food truck quinoa nesciunt laborum eiusmod. Brunch 3 wolf moon tempor, sunt aliqua put a bird on it squid single-origin coffee nulla assumenda shoreditch et. Nihil anim keffiyeh helvetica, craft beer labore wes anderson cred nesciunt sapiente ea proident. Ad vegan excepteur butcher vice lomo. Leggings occaecat craft beer farm-to-table, raw denim aesthetic synth nesciunt you probably haven't heard of them accusamus labore sustainable VHS. Food truck quinoa nesciunt laborum eiusmod. Brunch 3 wolf moon tempor, sunt aliqua put a bird on it squid single-origin coffee nulla assumenda shoreditch et
														</div>
													</div>
												</div>
												<div class="panel panel-default">
													<div class="panel-heading">
														<h4 class="panel-title">
														<a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion3" href="#accordion3_6">
															 6. Leggings occaecat craft beer farm-to-table, raw denim aesthetic synth ?
														</a>
														</h4>
													</div>
													<div id="accordion3_6" class="panel-collapse collapse">
														<div class="panel-body">
															 3 wolf moon officia aute, non cupidatat skateboard dolor brunch. Food truck quinoa nesciunt laborum eiusmod. Brunch 3 wolf moon tempor, sunt aliqua put a bird on it squid single-origin coffee nulla assumenda shoreditch et. Nihil anim keffiyeh helvetica, craft beer labore wes anderson cred nesciunt sapiente ea proident. Ad vegan excepteur butcher vice lomo. Leggings occaecat craft beer farm-to-table, raw denim aesthetic synth nesciunt you probably haven't heard of them accusamus labore sustainable VHS. Food truck quinoa nesciunt laborum eiusmod. Brunch 3 wolf moon tempor, sunt aliqua put a bird on it squid single-origin coffee nulla assumenda shoreditch et
														</div>
													</div>
												</div>
												<div class="panel panel-default">
													<div class="panel-heading">
														<h4 class="panel-title">
														<a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion3" href="#accordion3_7">
															 7. Ad vegan excepteur butcher vice lomo. Leggings occaecat craft ?
														</a>
														</h4>
													</div>
													<div id="accordion3_7" class="panel-collapse collapse">
														<div class="panel-body">
															 3 wolf moon officia aute, non cupidatat skateboard dolor brunch. Food truck quinoa nesciunt laborum eiusmod. Brunch 3 wolf moon tempor, sunt aliqua put a bird on it squid single-origin coffee nulla assumenda shoreditch et. Nihil anim keffiyeh helvetica, craft beer labore wes anderson cred nesciunt sapiente ea proident. Ad vegan excepteur butcher vice lomo. Leggings occaecat craft beer farm-to-table, raw denim aesthetic synth nesciunt you probably haven't heard of them accusamus labore sustainable VHS. Food truck quinoa nesciunt laborum eiusmod. Brunch 3 wolf moon tempor, sunt aliqua put a bird on it squid single-origin coffee nulla assumenda shoreditch et
														</div>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
						<!--end tab-pane-->
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
<script src="${baseUrl}/assets/plugins/data-tables/jquery.dataTables.js" type="text/javascript" ></script>
<script src="${baseUrl}/assets/plugins/data-tables/DT_bootstrap.js" type="text/javascript" ></script>
<script src="${baseUrl}/assets/scripts/core/app.js" type="text/javascript"></script>
<script src="${baseUrl}/assets/scripts/core/datatable.js"></script>
<script src="${baseUrl}/js/homes/myactivity-table-ajax.js" type="text/javascript"></script>
<script src="${baseUrl}/js/moment.js"></script>
</footer>

<script>
jQuery(document).ready(function() {
	App.init();
	TableAjax1.init();
	TableAjax2.init();
	TableAjax3.init();
	TableAjax4.init();
	$(".signupDateTime").each(function() {
		$( this ).text(convertUTCDateToLocalDate("${user.signupDate}", "${user.signupTime}", "${locale}"));
	});
	   
	$("#title_header").removeClass("dataTableID");
	 
	$("a[rel='tooltip']").tooltip({
	  'placement': 'top',
	  'z-index': '3000',
	});
  
	$("#viewFeedDisplay").dialog({
		width: currentWidth * 0.8,
		height: currentHeight * 0.8,
		resizable: true,
		modal:true,
		autoOpen: false,
	 	show: {
			 effect: "slide",
			 duration: 500
		}
	});
});

function viewFeed(emailDeliveryId) {
	$.ajax({
		type:"GET",
		url: "${baseUrl}/activity/viewFeed",
		data: "emailDeliveryId=" + emailDeliveryId,
		success: function(html){
			$("#viewFeedDisplay").html(html);
		}
	});	
	$("#viewFeedDisplay").show();
	$("#viewFeedDisplay").dialog("open");
}
function moveTo(jnid, role, manuscriptId, pageType, v) {
	location.href="${baseUrl}/journals/" + jnid + "/gatethrough/" + role + "?pageType=" + pageType + "&manuscriptId=" + manuscriptId + "&v=" + v;
}

function submit(jnid, manuscriptId) {
	var url = "${baseUrl}/journals/" + jnid + "/author/editManuscript?manuscriptId=" + manuscriptId;
	location.href=url;
}

</script>

<!-- END JAVASCRIPTS -->
</body>
<!-- END BODY -->
</html>