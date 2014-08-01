<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="org.springframework.web.servlet.support.RequestContextUtils"%>
<security:authentication property="authorities" var="authorities" />
<security:authentication property="name" var="username" />
<c:set var="req" value="${pageContext.request}" />
<c:set var="url">${req.requestURL}</c:set>
<c:set var="uri" value="${req.requestURI}" />
<c:set var="request_uri" value="${requestScope['javax.servlet.forward.request_uri']}" />
<c:set var="query_string" value="${requestScope['javax.servlet.forward.query_string']}" />
<c:set var="baseUrl" value="${fn:substring(url, 0, fn:length(url) - fn:length(uri))}${req.contextPath}" />
<c:set var="locale" value="<%=RequestContextUtils.getLocale(request).toString()%>" />

<base href="${baseUrl}/" />

<c:if test="${jnid != null and journal != null and journal.journalNameId != jnid}">
	<script>
	location.href="${baseUrl}/journals/${jnid}";
	</script>
</c:if>
