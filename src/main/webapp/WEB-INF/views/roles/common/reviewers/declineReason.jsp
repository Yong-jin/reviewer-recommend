<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="link.thinkonweb.configuration.SystemConstants" %>
<%@ include file="/WEB-INF/views/includes/headerForAjax.jsp" %>
<link href="${baseUrl}/assets/plugins/data-tables/DT_bootstrap.css" rel="stylesheet" />
<link href="${baseUrl}/css/jquery-ui.css" rel="stylesheet" type="text/css"/>
<link href="${baseUrl}/css/custom.css" rel="stylesheet" type="text/css"/>

<div id ="modal-header" class="modal-header ">
	<h4 class="modal-title"><spring:message code='reviewer.declinedReviewer'/></h4>
</div>
<div class="modal-body">
	<h5 class="marginLeft15"><spring:message code='user.role.journal_reviewer'/></h5>
	<div class="row">
		<label class="control-label col-md-2 text-right fontSize12"><spring:message code='user.name'/>: </label>
		<div class="col-md-9">
			<p class="form-control-static sentenseJustifyAlign fontSize12">
				<c:choose>
					<c:when test="${journal.languageCode == 'ko' and fn:trim(review.user.contact.localFullName) != ''}">
						${review.user.contact.localFullName} (<a href="mailto:${review.user.username}">${review.user.username}</a>)
					</c:when>
					<c:otherwise>
						${review.user.contact.firstName} ${review.user.contact.lastName} (<a href="mailto:${review.user.username}">${review.user.username}</a>)
					</c:otherwise>
				</c:choose>
			</p>
		</div>
	</div>	
	<div class="row">
		<label class="control-label col-md-2 text-right fontSize12"><spring:message code='user.institutionSmallWidth'/>: </label>
		<div class="col-md-9">
			<p class="form-control-static sentenseJustifyAlign fontSize12">
				<c:choose>
					<c:when test="${journal.languageCode == 'ko' and fn:trim(review.user.contact.localInstitution) != '' }">
						${review.user.contact.localInstitution }
					</c:when>
					<c:otherwise>
						${review.user.contact.institution}
					</c:otherwise>
				</c:choose>
			</p>
		</div>
	</div>
	<c:if test="${fn:trim(review.user.contact.localDepartment) != '' || fn:trim(review.user.contact.department) != '' }">
		<div class="row">
			<label class="control-label col-md-2 text-right fontSize12"><spring:message code='user.department'/>: </label>
			<div class="col-md-9">
				<p class="form-control-static sentenseJustifyAlign fontSize12">
					<c:choose>
						<c:when test="${journal.languageCode == 'ko' and fn:trim(review.user.contact.localDepartment) != '' }">
							${review.user.contact.localDepartment }
						</c:when>
						<c:otherwise>
							${review.user.contact.department}
						</c:otherwise>
					</c:choose>
				</p>
			</div>
		</div>
	</c:if>
	<div class="row">
		<label class="control-label col-md-2 text-right fontSize12"><spring:message code='reviewer.declineReason2'/>: </label>
		<div class="col-md-9">
			<p class="form-control-static sentenseJustifyAlign fontSize12">
				<spring:message code='reviewer.decline.reason.${rs.reason }'/>
			</p>
		</div>
	</div>
	<div class="row">
		<label class="control-label col-md-2 text-right fontSize12"><spring:message code='reviewer.messageToEditorial'/>:</label>
		<div class="col-md-9">
			<p class="form-control-static sentenseJustifyAlign fontSize12">
				<c:choose>
					<c:when test="${rs.comment != null and fn:trim(rs.comment) != ''}">
						${rs.comment }
					</c:when>
					<c:otherwise>
						<spring:message code='system.notAvailable2'/>
					</c:otherwise>
				</c:choose>
			</p>
		</div>
	</div>
	
	<h5 class="marginLeft15"><spring:message code='reviewer.reviewerSuggest'/></h5>
	<div class="row">
		<label class="control-label col-md-2 text-right fontSize12"><spring:message code='signin.email'/>: </label>
		<div class="col-md-9">
			<p class="form-control-static sentenseJustifyAlign fontSize12">
				<c:choose>
					<c:when test="${rs.email != null and fn:trim(rs.email) != ''}">
						<a href="mailto:${rs.email}">${rs.email}</a>
					</c:when>
					<c:otherwise>
						<spring:message code='system.notAvailable2'/>
					</c:otherwise>
				</c:choose>
			</p>
		</div>
	</div>
	<div class="row">
		<label class="control-label col-md-2 text-right fontSize12"><spring:message code='user.name'/>: </label>
		<div class="col-md-9">
			<p class="form-control-static sentenseJustifyAlign fontSize12">
				<c:if test="${rs.salutation != null and rs.salutation != '-1' }"><spring:message code='signin.salutationDesignation.${rs.salutation }'/></c:if>
				<c:choose>
					<c:when test="${journal.languageCode == 'ko' and fn:trim(rs.localFullName) != ''}">
						${rs.localFullName}
					</c:when>
					<c:otherwise>
						<c:choose>
							<c:when test="${(rs.firstName != null and fn:trim(rs.firstName) != '') or (rs.lastName != null and fn:trim(rs.lastName) != '')}">
								${rs.firstName} ${rs.lastName}
							</c:when>
							<c:otherwise>
								<spring:message code='system.notAvailable2'/>
							</c:otherwise>
						</c:choose>
						
					</c:otherwise>
				</c:choose>
			</p>
		</div>
	</div>	
	<div class="row">
		<label class="control-label col-md-2 text-right fontSize12"><spring:message code='user.institutionSmallWidth'/>: </label>
		<div class="col-md-9">
			<p class="form-control-static sentenseJustifyAlign fontSize12">
				<c:choose>
					<c:when test="${journal.languageCode == 'ko' and fn:trim(rs.localInstitution) != '' }">
						${rs.localInstitution }
					</c:when>
					<c:otherwise>
						<c:choose>
							<c:when test="${rs.institution != null and fn:trim(rs.institution) != ''}">
								${rs.institution}
							</c:when>
							<c:otherwise>
								<spring:message code='system.notAvailable2'/>
							</c:otherwise>
						</c:choose>
					</c:otherwise>
				</c:choose>
			</p>
		</div>
	</div>
	<div class="row">
		<label class="control-label col-md-2 text-right fontSize12"><spring:message code='user.department'/>: </label>
		<div class="col-md-9">
			<p class="form-control-static sentenseJustifyAlign fontSize12">
				<c:choose>
					<c:when test="${journal.languageCode == 'ko' and fn:trim(rs.localDepartment) != '' }">
						${rs.localDepartment }
					</c:when>
					<c:otherwise>
						<c:choose>
							<c:when test="${rs.department != null and fn:trim(rs.department) != ''}">
								${rs.department}
							</c:when>
							<c:otherwise>
								<spring:message code='system.notAvailable2'/>
							</c:otherwise>
						</c:choose>
					</c:otherwise>
				</c:choose>
			</p>
		</div>
	</div>
	<div class="row">
		<label class="control-label col-md-2 text-right fontSize12"><spring:message code='user.degree'/>: </label>
		<div class="col-md-9">
			<p class="form-control-static sentenseJustifyAlign fontSize12">
				<c:choose>
					<c:when test="${rs.degree != null and rs.degree != '-1' }">
						<spring:message code='signin.degreeDesignation.${rs.degree }'/>
					</c:when>
					<c:otherwise>
						<spring:message code='system.notAvailable2'/>
					</c:otherwise>
				</c:choose>
			</p>
		</div>
	</div>
	<div class="row">
		<label class="control-label col-md-2 text-right fontSize12"><spring:message code='user.country'/>: </label>
		<div class="col-md-9">
			<p class="form-control-static sentenseJustifyAlign fontSize12">
				<c:choose>
					<c:when test="${country != null }">
						${country }
					</c:when>
					<c:otherwise>
						<spring:message code='system.notAvailable'/>
					</c:otherwise>
				</c:choose>
			</p>
		</div>
	</div>
</div>