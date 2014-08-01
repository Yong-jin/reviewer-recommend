<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<c:set var="req" value="${pageContext.request}" />
<c:set var="url">${req.requestURL}</c:set>
<c:set var="uri" value="${req.requestURI}" />
<c:set var="baseUrl" value="${fn:substring(url, 0, fn:length(url) - fn:length(uri))}${req.contextPath}" />
<!DOCTYPE html>
<!--[if lt IE 7]>      <html class="no-js lt-ie9 lt-ie8 lt-ie7"> <![endif]-->
<!--[if IE 7]>         <html class="no-js lt-ie9 lt-ie8"> <![endif]-->
<!--[if IE 8]>         <html class="no-js lt-ie9"> <![endif]-->
<!--[if gt IE 8]><!--> <html class="no-js"> <!--<![endif]-->
<head>
<jsp:include page="/WEB-INF/views/includes/header.jsp" flush="false" />
<title>Journal Setup &amp; Initialization</title>
<script src="${baseUrl}/js/dateFormat.js"></script>
<script type="text/javascript" charset="utf-8">
$(document).ready(function() {
	var scntDiv = $('#p_scents');
	var i = $('#td #p_scents p').size() + 1;
	var maxInputs = 4;

	$("body").on("click", '#remScnt', function() {
		if( i > 2 ) {
			$(this).parent().parent().parent().parent().parent().remove();
			i--;
		}
		return false;
	});
	
	$('#addScnt').click(function() {
		if (i <= maxInputs) {
			$("#c-editor").append('<tr><td class="span-5">&nbsp;</td><td class="span-15"><div id="p_scents"><p><label for="p_scnts"><input type="text" id="p_scnt" size="20" name="p_scnt_' + i +'" value="" placeholder="Input Value" /> <a id="remScnt" href="#" >Remove</a></label></p></div></td></tr>');
//			$('<p><label for="p_scnts"><input type="text" id="p_scnt" size="20" name="p_scnt_' + i +'" value="" placeholder="Input Value" /> <a id="remScnt" href="#" >Remove</a></label></p>').appendTo(scntDiv);
//			$('<p><label for="p_scnts"><input type="text" id="p_scnt" size="20" name="p_scnt_' + i +'" value="" placeholder="Input Value" /></label> <button id="remScnt" class="button negative" ><img src="${baseUrl}/css/blueprint/plugins/buttons/icons/key.png" alt=""/> Remove</button></p>').appendTo(scntDiv);
			i++;
		}
		return false;
	});
	
	var dateUTC="${journal.registeredDateTime}";	
	dateUTC = dateUTC.substr(0, dateUTC.lastIndexOf("."));
	dateUTC = dateUTC + " UTC";

	var dateLocal = new Date(dateUTC);
	var tz = jstz.determine();
	dateLocal = DateFormat.format.date(dateLocal, "yyyy-MM-dd HH:mm:ss") + " " + tz.name();
	$('p[id="dateTime"]').html(dateLocal + " (" + dateUTC + ")"); 
});
</script>
</head>

<body>
<div class="container">
<br/>
<h2 class="text-center">Journal Setup &amp; Initialization</h2>

<br/>

<div class="row">
<form class="form-horizontal">
<fieldset>
<legend>Basic Journal Information</legend>
  <div class="form-group">
    <label class="col-sm-2 control-label"><spring:message code="journal.journalNameId"/></label>
    <div class="col-sm-10">
      <p class="form-control-static">${journal.journalNameId}</p>
    </div>
  </div>
  
  <div class="form-group">
    <label class="col-sm-2 control-label"><spring:message code="journal.title"/></label>
    <div class="col-sm-10">
      <p class="form-control-static">${journal.title}</p>
    </div>
  </div>
  
  <div class="form-group">
    <label class="col-sm-2 control-label"><spring:message code="journal.creator.username"/></label>
    <div class="col-sm-10">
      <p class="form-control-static">${journal.creator.username}</p>
    </div>
  </div>
  
  <div class="form-group">
    <label class="col-sm-2 control-label"><spring:message code="journal.organization"/></label>
    <div class="col-sm-10">
      <p class="form-control-static">${journal.organization}</p>
    </div>
  </div>
  
  <div class="form-group">
    <label class="col-sm-2 control-label"><spring:message code="journal.registeredDateTime"/></label>
    <div class="col-sm-10">
      <p class="form-control-static" id="dateTime"></p>
    </div>
  </div>
  
  <div class="form-group">
    <label class="col-sm-2 control-label"><spring:message code="journal.homeURL"/></label>
    <div class="col-sm-10">
      <p class="form-control-static"><a class="noicon" href="${baseUrl}/journals/${journal.journalNameId}">${baseUrl}/journals/${journal.journalNameId}</a></p>
    </div>
  </div>
</fieldset>  
</form>
</div>

<br/>

<div class="row">
<form class="form-horizontal">
<fieldset>
<legend>Chief Editor(s)</legend>
<table id="c-editor">
	<tr>
		<td class="span-5">Username of Chief Editor(s)</td>
		<td id="td" class="span-15">
			<div id="p_scents">
			    <p>
					<label for="p_scnts">
					<input type="text" id="p_scnt" size="20" name="p_scnt" value="" placeholder="Input Value" />
					</label>
				</p>
			</div>
		</td>	
	</tr>
</table>
<table>
<tr>
	<td class="span-5"></td>
	<td class="span-15">
		<div>
			<button id="addScnt" class="button positive" >
				<img src="${baseUrl}/css/blueprint/plugins/buttons/icons/key.png" alt="" /> Add Chief Editor
			</button>
		</div>
	</td>
</tr>
</table>
</fieldset>
</form>
</div>

<jsp:include page="/WEB-INF/views/includes/footerBar.jsp" flush="false" />
</div>	
</body>