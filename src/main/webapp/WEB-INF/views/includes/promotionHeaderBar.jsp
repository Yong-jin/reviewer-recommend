<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!-- BEGIN HEADER -->
<div class="header navbar navbar-default navbar-fixed-top">
<div class="container">
	<div class="navbar-header">
		<!-- BEGIN LOGO (you can use logo image instead of text)-->
		<a class="navbar-brand logo-v1" href="${baseUrl}/promotion">
			<span class="logo_first">MANUSCRIPT</span><span class="logo_second">LINK</span>
		</a>
		<!-- END LOGO -->
	</div>

	<!-- BEGIN TOP NAVIGATION MENU -->
	<div class="navbar-collapse collapse pull-right">
		<ul class="nav navbar-nav">
     		<c:choose>
				<c:when test="${fn:contains(request_uri, '/features/')}">
					<li class="dropdown active">
				</c:when>
				<c:otherwise>
					<li class="dropdown">
				</c:otherwise>
			</c:choose>
          <a href="#" class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown" data-delay="0" data-close-others="false">
              <spring:message code="system.feature"/>
              <i class="fa fa-angle-down"></i>
          </a>
          <ul class="dropdown-menu">
              <li><a href="submitJournal"><spring:message code="home.open"/></a></li>
              <li class="divider"></li>
              <li><a href="${baseUrl}/promotion/features/management"><spring:message code="home.manage"/></a></li>
              <li><a href="${baseUrl}/promotion/features/submission"><spring:message code="home.submit"/></a></li>
              <li><a href="${baseUrl}/promotion/features/review"><spring:message code="home.review"/></a></li>
              <li><a href="${baseUrl}/promotion/features/editorship"><spring:message code="home.editorship"/></a></li>
          </ul>
      </li>
			
			<c:choose>
						<c:when test="${fn:contains(request_uri, '/customerSupport/')}">
							<li class="dropdown active">
						</c:when>
						<c:otherwise>
							<li class="dropdown">
						</c:otherwise>
			</c:choose>
          <a href="#" class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown" data-delay="0" data-close-others="false">
              <spring:message code="system.customerSupport"/>
              <i class="fa fa-angle-down"></i>
          </a>
          <ul class="dropdown-menu">
              <li><a href="${baseUrl}/promotion/customerSupport/aboutus"><spring:message code="system.aboutus"/></a></li>
              <li><a href="${baseUrl}/promotion/customerSupport/prices"><spring:message code="system.prices"/></a></li>
              <li><a href="${baseUrl}/promotion/customerSupport/faq"><spring:message code="system.faq"/></a></li>
              <li><a href="${baseUrl}/promotion/customerSupport/gallery"><spring:message code="system.gallery"/></a></li>
              <li><a href="${baseUrl}/promotion/customerSupport/contactus"><spring:message code="system.contactus"/></a></li>
          </ul>
      </li>
	      
			<li>
          <a data-close-others="false" href="${baseUrl}">
          	<spring:message code="system.journalList"/>
          </a>
			</li>

			<security:authorize ifAllGranted="ROLE_ANONYMOUS">	      
				<c:choose>
						<c:when test="${fn:contains(request_uri, '/promotionSignin')}">
							<li class="active">
						</c:when>
						<c:otherwise>
							<li>
						</c:otherwise>
				</c:choose>
	     			  <a href="${baseUrl}/promotionSignin"><spring:message code="signin.signInSubmit"/></a>
	     	</li>
		    
	     	<li class="dropdownLast">
	     			  <a href="${baseUrl}/signup"><spring:message code="signin.signUpSubmit"/></a>
	     	</li>
			</security:authorize>
		  
		  
		  
			<security:authorize ifNotGranted="ROLE_ANONYMOUS">				
				<li class="dropdown dropdownLast">
					<a href="#" class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown" data-delay="0" data-close-others="false" href="#">
						<span class="username">
							 <spring:message code="system.myPage"/>
						</span>
						<i class="fa fa-angle-down"></i>
					</a>
					<ul class="dropdown-menu">
						<li>
							<a href="#" id="username">
								<strong class="text-primary" id="username">${user.username}</strong>
							</a>
						</li>
						<li>
							<a href="${baseUrl}/activity/myActivity">
								<i class="fa fa-user"></i> <spring:message code="system.myActivity"/>
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
			</security:authorize>
		</ul>                           
	</div>
	<!-- BEGIN TOP NAVIGATION MENU -->
</div>
</div>
<!-- END HEADER -->