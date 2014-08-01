<%@ tag body-content="empty" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ attribute name="baseUrl" %>
<div class="row">
	<div class="col-md-8 profile-info">
		<h1><c:if test="${user.contact.salutation != '-1' }"><spring:message code="signin.salutationDesignation.${user.contact.salutation}"/> </c:if>${user.contact.firstName} ${user.contact.lastName}</h1>
		<c:if test="${not empty user.contact.about}">
			<p class="about">${user.contact.about}</p>
		</c:if>
		<p><spring:message code="signin.username"/> (<spring:message code="signin.email"/>):
			<a href="mailto:${user.username}">
				 ${user.username}
			</a>
		</p>
		<ul class="list-inline">
			<li>
				<img src="${baseUrl}/assets/img/flags/${fn:toLowerCase(user.contact.countryCode.alpha2)}.png" border="0" /> ${user.contact.countryCode.name}
			</li>
			<li>
				<i class="fa fa-building-o"></i> ${user.contact.institution}
			</li>
			<li>
				<i class="fa fa-star"></i> <spring:message code="signin.degreeDesignation.${user.contact.degree}"/>
			</li>
			<li>
				<i class="fa fa-calendar"></i> <spring:message code="system.signupdate"/> - <span class="signupDateTime"></span>
				
			</li>
		</ul>
		<ul class="list-inline top-narrow">
			<c:if test="${not empty user.contact.phone}">
				<li>
					<i class="fa fa-phone"></i> ${user.contact.phone}
				</li>
			</c:if>
			<c:if test="${not empty user.contact.mobile}">
				<li>
					<i class="fa fa-mobile-phone"></i> ${user.contact.mobile}
				</li>
			</c:if>
			<c:if test="${not empty user.contact.fax}">
				<li>
					<i class="fa fa-labtop"></i> ${user.contact.fax}
				</li>
			</c:if>
			<c:if test="${not empty user.contact.website}">
				<li>
					<i class="fa fa-hand-o-right"></i> ${user.contact.website}
				</li>
			</c:if>
		</ul>
	</div>
	<!--end col-md-8-->
	<div class="col-md-4">
		<div class="portlet sale-summary">
			<div class="portlet-title">
				<div class="caption text-right">
					 <h2><spring:message code="system.activitySummary"/></h2>
				</div>
				<div class="tools">
					<a class="reload" href="javascript:;">
					</a>
				</div>
			</div>
			<div class="portlet-body">
				<ul class="list-unstyled">
					<li>
						<span class="sale-info">
							 <spring:message code="system.myJournal"/>
						</span>
						<span class="sale-num">
							 ${numberOfjournalsInMember}
						</span>
					</li>
					<li>
						<span class="sale-info">
							 <spring:message code="system.myManuscripts"/>
						</span>
						<span class="sale-num">
							 ${numberOfCoWrittenManuscriptsInMember}
						</span>
					</li>
					<li>
						<span class="sale-info">
							 <spring:message code="system.myReviewManuscripts"/>
						</span>
						<span class="sale-num">
							 ${numberOfReviewMenuscriptsInMember}
						</span>
					</li>
					<li>
						<span class="sale-info">
							 <spring:message code="system.myfeeds"/>
						</span>
						<span class="sale-num">
							 ${numberOfFeeds }
						</span>
					</li>
				</ul>
			</div>
		</div>
	</div>
	<!--end col-md-4-->
</div>
<!--end row-->