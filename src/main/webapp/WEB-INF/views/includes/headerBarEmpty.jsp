<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="link.thinkonweb.configuration.SystemConstants" %>

<div class="header navbar navbar-default navbar-fixed-top headerBarEmpty">
<div class="container">
	<div class="navbar-header">
		<!-- BEGIN LOGO (you can use logo image instead of text)-->
		<c:if test="${not fn:contains(request_uri, '/journals/')}">
			<c:choose>			
				<c:when test="${fn:contains(request_uri, '/signinSuccess')}">
					<a class="navbar-brand logo-v1" href="${baseUrl}/activity/myActivity">
						<span class="logo_first">MANUSCRIPT</span><span class="logo_second">LINK</span>
					</a>
				</c:when>
				<c:when test="${fn:contains(request_uri, '/submitJournal') or fn:contains(request_uri, '/signup') or fn:contains(request_uri, '/changePassword')}">
					<a class="navbar-brand logo-v1" href="${baseUrl}/promotion">
						<span class="logo_first">MANUSCRIPT</span><span class="logo_second">LINK</span>
					</a>
				</c:when>				
			 </c:choose>
		</c:if>
		<c:if test="${fn:contains(request_uri, '/reviewInvitation') or fn:contains(request_uri, '/setup') or fn:contains(request_uri, '/journalSignup')}">			
			<a class="navbar-brand logo-v1" href="${baseUrl}/journals/${journal.journalNameId}" >
				<span class="logo_journal">${journal.shortTitle}</span>
			</a>
		</c:if>	
		<!-- END LOGO -->
	</div>
	<br/><br/>
</div>
</div>