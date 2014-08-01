<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="req" value="${pageContext.request}" />
<c:set var="url">${req.requestURL}</c:set>
<c:set var="uri" value="${req.requestURI}" />
<c:set var="baseUrl" value="${fn:substring(url, 0, fn:length(url) - fn:length(uri))}${req.contextPath}" />
<!-- BEGIN COPYRIGHT -->
<!-- END COPYRIGHT -->


<!-- BEGIN CORE PLUGINS -->
<!--[if lt IE 9]>
    <script src="${baseUrl}/assets/plugins/respond.min.js"></script>
    <script src="${baseUrl}/assets/plugins/excanvas.min.js"></script> 
    <![endif]-->
<script src="${baseUrl}/assets/plugins/jquery-1.10.2.min.js" type="text/javascript"></script>
<script src="${baseUrl}/assets/plugins/jquery-migrate-1.2.1.min.js" type="text/javascript"></script>
<script src="${baseUrl}/assets/plugins/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
<script src="${baseUrl}/assets/plugins/bootstrap/js/bootstrap2-typeahead.min.js" type="text/javascript"></script>
<script src="${baseUrl}/assets/plugins/bootstrap-hover-dropdown/bootstrap-hover-dropdown.min.js" type="text/javascript"></script>
<script src="${baseUrl}/assets/plugins/jquery-slimscroll/jquery.slimscroll.min.js" type="text/javascript"></script>
<script src="${baseUrl}/assets/plugins/jquery.blockui.min.js" type="text/javascript"></script>
<script src="${baseUrl}/assets/plugins/jquery.cokie.min.js" type="text/javascript"></script>
<script src="${baseUrl}/assets/plugins/uniform/jquery.uniform.min.js" type="text/javascript"></script>

<!-- END CORE PLUGINS -->
<script src="${baseUrl}/assets/plugins/bootbox/bootbox.min.js" type="text/javascript"></script>

