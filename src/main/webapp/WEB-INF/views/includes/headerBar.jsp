<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="link.thinkonweb.configuration.SystemConstants" %> 

<!-- BEGIN HEADER -->
<div class="header navbar navbar-default navbar-fixed-top">
<div class="container">
	<div class="navbar-header">
		<!-- BEGIN LOGO (you can use logo image instead of text)-->
		<c:if test="${not empty journal && fn:contains(request_uri, '/journals/')}">
			<a class="navbar-brand logo-v1" href="${baseUrl}/journals/${journal.journalNameId}?lang=${pageContext.response.locale}" >
				<span class="logo_journal">${journal.shortTitle}</span>
			</a>
		</c:if>
		<c:if test="${not fn:contains(request_uri, '/journals/')}">
			<a class="navbar-brand logo-v1" href="${baseUrl}/activity/myActivity">
				<span class="logo_first">MANUSCRIPT</span><span class="logo_second">LINK</span>
			</a>
		</c:if>
		<!-- END LOGO -->
	</div>
			
	<!-- BEGIN TOP NAVIGATION MENU -->
	<div class="navbar-collapse collapse pull-right">
		<ul class="nav navbar-nav">		  	
			<!-- BEGIN USER LOGIN DROPDOWN -->
			<c:if test="${fn:contains(request_uri, '/journals/')}">
				<c:if test="${fn:contains(roles, 'ROLE_MANAGER')}">
					<c:choose>
						<c:when test="${fn:contains(request_uri, '/manager/')}">
							<li class="dropdown active">
						</c:when>
						<c:otherwise>
							<li class="dropdown">
						</c:otherwise>
					</c:choose>
						<a href="#" class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown" data-delay="0" data-close-others="false">
							<i class="fa fa-tasks"></i><spring:message code="user.role.journal_manager"/>
						</a>
						<ul class="dropdown-menu">
							<li>
								<a href="${baseUrl}/journals/${journal.journalNameId}/manager/manuscriptStatusOverview">
									<i class="fa fa-reorder"></i> <spring:message code="system.manuscriptStatusOverview"/>
								</a>
							</li>
							<li>
								<a href="${baseUrl}/journals/${journal.journalNameId}/manager/manuscripts">
									<i class="fa fa-folder-open-o"></i> <spring:message code="system.manuscriptManagement"/>
								</a>
							</li>
							<li class="divider"></li>
							<li>
								<a href="${baseUrl}/journals/${journal.journalNameId}/manager/configuration/journal/settings">
									<i class="fa fa-cog "></i> <spring:message code="manager.config.journalManagement"/>
								</a>
							</li>
							<li>
								<a href="${baseUrl}/journals/${journal.journalNameId}/manager/configuration/accounts/manageAccounts">
									<i class="fa fa-group "></i> <spring:message code="manager.menu.accountManagement"/>
								</a>
							</li>
							<li>
								<a href="${baseUrl}/journals/${journal.journalNameId}/manager/configuration/divisions/manageDivisions">
									<i class="fa fa-sitemap "></i> <spring:message code="manager.config.divisionManagement"/>
								</a>
							</li>
							<li>
								<a href="${baseUrl}/journals/${journal.journalNameId}/manager/configuration/specialIssues/manageSpecialIssue">
									<i class="fa fa-bookmark-o "></i> <spring:message code="manager.config.specialIssueManagement"/>
								</a>
							</li>
							<li>
								<a href="${baseUrl}/journals/${journal.journalNameId}/manager/configuration/members/manageMembers">
									<i class="fa  fa-suitcase "></i> <spring:message code="manager.menu.editorialMemberManagement"/>
								</a>
							</li>
							<!--
							<li>
								<a href="${baseUrl}/journals/${journal.journalNameId}/manager/configuration/backup">
									<i class="fa fa-list-alt "></i> <spring:message code="manager.config.manuscriptsStatistics"/>
								</a>
							</li>
							-->
							<li>
								<a href="${baseUrl}/journals/${journal.journalNameId}/manager/configuration/backup">
									<i class="fa fa-save "></i> <spring:message code="manager.menu.manuscriptsBackup"/>
								</a>
							</li>
							<!--
							<li>
								<a href="${baseUrl}/journals/${journal.journalNameId}/manager/billing">
									<i class="fa fa-dollar"></i> <spring:message code="manager.menu.billingPaymentHistory"/>
								</a>
							</li>
							-->
						</ul>
					</li>
				</c:if>
				
				<c:if test="${fn:contains(roles, 'ROLE_C-EDITOR')}">
					<c:choose>
						<c:when test="${fn:contains(request_uri, '/chiefEditor/')}">
							<li class="dropdown active">
						</c:when>
						<c:otherwise>
							<li class="dropdown">
						</c:otherwise>
					</c:choose>
						<a href="#" class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown" data-delay="0" data-close-others="false">
							<i class="fa fa-gavel"></i><spring:message code="user.role.journal_c-editor"/>
						</a>
						<ul class="dropdown-menu">
							<li>
								<a href="${baseUrl}/journals/${journal.journalNameId}/chiefEditor/manuscriptStatusOverview">
									<i class="fa fa-reorder"></i> <spring:message code="system.manuscriptStatusOverview"/>
								</a>
							</li>
							<li>
								<a href="${baseUrl}/journals/${journal.journalNameId}/chiefEditor/manuscripts">
									<i class="fa fa-folder-open-o"></i> <spring:message code="system.manuscriptManagement"/>
								</a>
							</li>
						</ul>
					</li>
				</c:if>

				<c:if test="${journal.type == 'A' or journal.type == 'B'}">
					<c:if test="${fn:contains(roles, 'ROLE_A-EDITOR')}">
						<c:choose>
							<c:when test="${fn:contains(request_uri, '/associateEditor/')}">
								<li class="dropdown active">
							</c:when>
							<c:otherwise>
								<li class="dropdown">
							</c:otherwise>
						</c:choose>
							<a href="#" class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown" data-delay="0" data-close-others="false">
								<i class="fa fa-briefcase"></i><spring:message code="user.role.journal_a-editor"/>
							</a>
							<ul class="dropdown-menu">
								<li>
									<a href="${baseUrl}/journals/${journal.journalNameId}/associateEditor/manuscripts">
										<i class="fa fa-folder-open-o"></i> <spring:message code="system.managementReviewProcess"/>
									</a>
								</li>
							</ul>
						</li>
					</c:if>
				</c:if>
				
				<c:if test="${fn:contains(roles, 'ROLE_G-EDITOR')}">
					<c:choose>
						<c:when test="${fn:contains(request_uri, '/guestEditor/')}">
							<li class="dropdown active">
						</c:when>
						<c:otherwise>
							<li class="dropdown">
						</c:otherwise>
					</c:choose>
						<a href="#" class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown" data-delay="0" data-close-others="false">
							<i class="fa fa-suitcase"></i><spring:message code="user.role.journal_g-editor"/>
						</a>
						<ul class="dropdown-menu">
							<li>
								<a href="${baseUrl}/journals/${journal.journalNameId}/guestEditor/manuscripts">
									<i class="fa fa-folder-open-o"></i> <spring:message code="system.managementReviewProcess"/>
								</a>
							</li>
						</ul>
					</li>
				</c:if>
				
				<c:if test="${fn:contains(roles, 'ROLE_B-EDITOR')}">
					<c:choose>
						<c:when test="${fn:contains(request_uri, '/boardMember/')}">
							<li class="dropdown active">
						</c:when>
						<c:otherwise>
							<li class="dropdown">
						</c:otherwise>
					</c:choose>
						<a href="#" class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown" data-delay="0" data-close-others="false">
							<i class="fa fa-group"></i><spring:message code="user.role.journal_b-member"/>
						</a>
						<ul class="dropdown-menu">
							<li>
								<a href="${baseUrl}/journals/${journal.journalNameId}/boardMember/manuscripts">
									<i class="fa fa-folder-open-o"></i> <spring:message code="boardMember.viewManuscript"/>
								</a>
							</li>
						</ul>
					</li>
				</c:if>
				
				<c:if test="${fn:contains(roles, 'ROLE_REVIEWER')}">
					<c:choose>
						<c:when test="${fn:contains(request_uri, '/reviewer/')}">
							<li class="dropdown active">
						</c:when>
						<c:otherwise>
							<li class="dropdown">
						</c:otherwise>
					</c:choose>
						<a href="#" class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown" data-delay="0" data-close-others="false">
							<i class="fa fa-pencil-square"></i><spring:message code="user.role.journal_reviewer"/>
						</a>
						<ul class="dropdown-menu">
							<li>
								<a href="${baseUrl}/journals/${journal.journalNameId}/reviewer/manuscripts">
									<i class="fa fa-folder-open-o"></i> <spring:message code="home.review"/>
								</a>
							</li>
						</ul>
					</li>
				</c:if>
				
				<c:if test="${fn:contains(roles, 'ROLE_MEMBER')}">
					<c:choose>
						<c:when test="${fn:contains(request_uri, '/author/')}">
							<li class="dropdown active">
						</c:when>
						<c:otherwise>
							<li class="dropdown">
						</c:otherwise>
					</c:choose>
						<a href="#" class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown" data-delay="0" data-close-others="false">
							<i class="fa fa-book"></i><spring:message code="user.role.journal_member"/>
						</a>
						<ul class="dropdown-menu">
							<li>
								<a href="${baseUrl}/journals/${journal.journalNameId}/author/submitManuscript/">
									<i class="fa fa-file-o "></i> <spring:message code="author.menu.submitNewManuscript"/>
								</a>
							</li>
							<li>
								<a href="${baseUrl}/journals/${journal.journalNameId}/author/manuscripts">
									<i class="fa fa-folder-open-o"></i> <spring:message code="system.manuscriptManagement"/>
								</a>
							</li>
						</ul>
					</li>
				</c:if>
			</c:if>
			

				
			<li class="dropdown">
				<a href="#" class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown" data-delay="0" data-close-others="false">
					<i class="fa fa-user"></i><spring:message code="system.myPage"/>
				</a>
				<ul class="dropdown-menu">
					<li>
						<a href="#" id="username" onClick="return false;">
							<strong class="text-primary" id="username">${user.username}</strong>
						</a>
					</li>
					<li>
						<a href="${baseUrl}/activity/myActivity">
							<i class="fa fa-pencil"></i> <spring:message code="system.myActivity"/>
						</a>
					</li>
					<li>
						<a href="${baseUrl}/account/myAccount">
							<i class="fa fa-tasks"></i> <spring:message code="system.myAccount"/>
<!-- 						<span class="badge badge-success">
									 7
								</span> -->
						</a>
					</li>
					<li class="divider">
					</li>
					<li>
						<a href="<c:url value="/signout" />">
							<i class="fa fa-sign-out"></i><spring:message code="system.signout"/>
						</a>
					</li>
				</ul>
			</li>
			<!-- END USER LOGIN DROPDOWN -->
		</ul>                           
	</div>
	<!-- BEGIN TOP NAVIGATION MENU -->
</div>
</div>
<!-- END HEADER -->