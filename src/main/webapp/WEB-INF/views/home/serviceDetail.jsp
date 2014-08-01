<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="link.thinkonweb.configuration.SystemConstants" %>
<%@ include file="/WEB-INF/views/includes/headerForAjax.jsp" %>

<link href="${baseUrl}/css/custom.css" rel="stylesheet" type="text/css"/>
<link href="${baseUrl}/css/jquery-ui.css" rel="stylesheet" type="text/css"/>
<link href="${baseUrl}/assets/plugins/bootstrap-datepicker/css/datepicker.css" rel="stylesheet" type="text/css" />
<div class="row page-boxed">
	<div class="col-md-12">
		<div class="promo-page">
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
		</div>
	</div>
</div>