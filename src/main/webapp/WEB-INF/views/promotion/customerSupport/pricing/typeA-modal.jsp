<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="org.springframework.web.servlet.support.RequestContextUtils"%>
<link href="${baseUrl}/assets/plugins/bootstrap-modal/css/bootstrap-modal-bs3patch.css" rel="stylesheet" type="text/css"/>
<link href="${baseUrl}/assets/plugins/bootstrap-modal/css/bootstrap-modal.css" rel="stylesheet" type="text/css"/>
<c:set var="req" value="${pageContext.request}" />
<c:set var="url">${req.requestURL}</c:set>
<c:set var="uri" value="${req.requestURI}" />
<c:set var="baseUrl" value="${fn:substring(url, 0, fn:length(url) - fn:length(uri))}${req.contextPath}" />
<c:set var="locale" value="<%=RequestContextUtils.getLocale(request).toString()%>" />

<html lang="en" class="no-js">
<!--<![endif]-->

<head>
<base href="${baseUrl}/" />
</head>
<body>
	<div class="modal-header">
	  <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
	  <h3><spring:message code="system.typeA2"/>. <spring:message code="system.nameTypeA"/></h3>
	</div>
	<div class="modal-body">
		<%@ include file="/WEB-INF/views/promotion/features/management/typeA-description.jsp" %>
	</div>
	<div class="modal-footer">
	  <button type="button" data-dismiss="modal" class="btn"><spring:message code="system.close"/></button>
	</div>
</body>
</html>