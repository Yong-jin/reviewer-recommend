<!DOCTYPE html>
<!--[if lt IE 7]>      <html class="no-js lt-ie9 lt-ie8 lt-ie7"> <![endif]-->
<!--[if IE 7]>         <html class="no-js lt-ie9 lt-ie8"> <![endif]-->
<!--[if IE 8]>         <html class="no-js lt-ie9"> <![endif]-->
<!--[if gt IE 8]><!--> <html class="no-js"> <!--<![endif]-->
<head>
<title>Superuser Dashboard</title>
<%@ include file="/WEB-INF/views/includes/header.jsp" %>
<link href="${baseUrl}/css/custom.css" rel="stylesheet" type="text/css"/>
<link href="${baseUrl}/assets/plugins/select2/select2.css" rel="stylesheet" type="text/css" />
<link href="${baseUrl}/assets/plugins/select2/select2-metronic.css" rel="stylesheet" type="text/css"/>
<link href="${baseUrl}/js/tabletools_media/css/TableTools.css" rel="stylesheet" type="text/css" />
<link href="${baseUrl}/js/tabletools_media/css/TableTools_JUI.css" rel="stylesheet" type="text/css" />
<link href="${baseUrl}/assets/css/style-metronic.css" rel="stylesheet" type="text/css"/>
<link href="${baseUrl}/assets/css/plugins.css" rel="stylesheet" type="text/css"/>
<link href="${baseUrl}/assets/css/custom.css" rel="stylesheet" type="text/css"/>
<!-- END THEME STYLES -->
</head>


<body class="content">
<%@ include file="/WEB-INF/views/includes/headerBar.jsp" %>
<br/>

<div class="container">
<div class="caption">
	<h3><i class="fa fa-users"></i>&nbsp;Email Template Test</h3>
</div>
<br/>
<c:choose>
	<c:when test="${journalType == 'A'}">
		<c:set var="journalTypeNum" value="0"/>
	</c:when>
	<c:when test="${journalType == 'B'}">
		<c:set var="journalTypeNum" value="1"/>
	</c:when>
	<c:when test="${journalType == 'C'}">
		<c:set var="journalTypeNum" value="2"/>
	</c:when>
	<c:when test="${journalType == 'D'}">
		<c:set var="journalTypeNum" value="3"/>
	</c:when>
</c:choose>		
<div class="form-group row">
	<label class="col-md-1 control-label" for="title"><spring:message code="system.journalType"/>:</label>
	<div class="col-md-6">
		<select id="selectJournalTypeId" class="form-control input-xxlarge" style="width:400px">				
			<c:forEach var="map2" items="${journalTypeDesignationSet}">
				<c:choose>
					<c:when test="${map2.key==journalTypeNum}">
						<option value="${map2.value}" selected="selected">${map2.value}. <spring:message code="system.nameType${map2.value}"/></option>
					</c:when>
					<c:otherwise>
						<option value="${map2.value}">${map2.value}. <spring:message code="system.nameType${map2.value}"/></option>
					</c:otherwise>
				</c:choose>
			</c:forEach>
		</select>
	</div>

	<label class="col-md-1 control-label" for="title"><spring:message code="author.newPaperSubmit.manuscriptTrack"/>:</label>
	<div class="col-md-4">
		<select id="selectIsSI" class="form-control input-xxlarge" style="width:200px">				
			<c:forEach var="map3" items="${manuscriptTrackSet}">
				<c:choose>
					<c:when test="${map3.key==manuscriptTrack}">
						<option value="${map3.key}" selected="selected">${map3.key}. ${map3.value}</option>
					</c:when>
					<c:otherwise>
						<option value="${map3.key}">${map3.key}. ${map3.value}</option>
					</c:otherwise>
				</c:choose>
			</c:forEach>
		</select>
	</div>
</div>

<div class="form-group row">
	<label class="col-md-1 control-label" for="title">Email ID:</label>
	<div class="col-md-11">
		<select id="selectEmailId" class="form-control input-xxlarge" style="width:600px">
			<c:forEach var="map" items="${emailDesignationSet}">
				<c:choose>
					<c:when test="${map.key==mailId}">
						<option value="${map.key}" selected="selected">${map.key}. ${map.value}</option>
					</c:when>
					<c:otherwise>
						<option value="${map.key}">${map.key}. ${map.value}</option>
					</c:otherwise>
				</c:choose>
			</c:forEach>
		</select>
	</div>
</div>

<hr/>

<div class="form-group row">
	<label class="col-md-1 control-label" for="title">Closing Role:</label>
	<div class="col-md-5">
		<c:if test="${not empty closingRole}">
			<input type="text" class="form-control" value="<spring:message code='user.role2.${closingRole}'/>">
		</c:if>
  </div>
  <label class="col-md-1 control-label" for="title">To Role:</label>
	<div class="col-md-5">
		<c:if test="${not empty toRole}">
			<input type="text" class="form-control" value="<spring:message code='user.role2.${toRole}'/>">
		</c:if>
  </div>
</div>

<div class="form-group row">
  <label class="col-md-1 control-label" for="title">CC Roles:</label>
	<div class="col-md-11">
		<c:if test="${not empty ccRoles}">
			<input type="text" class="form-control" value="${ccRoles}">
		</c:if>
  </div>
</div>

<div class="form-group row">
	<label class="col-md-1 control-label" for="title">Subject:</label>
	<div class="col-md-5">
		<input type="text" class="form-control" id="subjectEn" value="${subjectEn}">
   </div>
   <div class="col-md-push-1 col-md-5">
		<input type="text" class="form-control" id="subjectKr" value="${subjectKr}">
   </div>
</div>

<div class="form-group row">
	<label class="col-md-1 control-label" for="title">body:</label>
	<div class="col-md-5">
		<textarea class="field" id="emailBody" rows="30" style="width:476px">${bodyEn}</textarea>
   </div>
   <div class="col-md-push-1 col-md-5">
		<textarea class="field" id="emailBody" rows="30" style="width:476px">${bodyKr}</textarea>
   </div>
</div>

</div>	
	
<!-- END PAGE CONTENT-->
<br/>
<br/>
<br/>
<footer>
<%@ include file="/WEB-INF/views/includes/footerBar.jsp" %>
<!-- BEGIN PAGE LEVEL PLUGINS -->
<script type="text/javascript" src="${baseUrl}/js/custom_global.js"></script>
<!-- BEGIN PAGE LEVEL PLUGINS -->
<script type="text/javascript" src="${baseUrl}/js/custom_global.js"></script>
<script type="text/javascript" src="${baseUrl}/assets/plugins/select2/select2.min.js"></script>
<script type="text/javascript" src="${baseUrl}/assets/plugins/data-tables/jquery.dataTables.js"></script>
<script type="text/javascript" src="${baseUrl}/assets/plugins/data-tables/DT_bootstrap.js"></script>
<script type="text/javascript" src="${baseUrl}/assets/plugins/bootstrap-datepicker/js/bootstrap-datepicker.js"></script>
<script type="text/javascript" src="${baseUrl}/js/tabletools_media/js/TableTools.min.js"></script>
<script type="text/javascript" src="${baseUrl}/js/tabletools_media/js/ZeroClipboard.js"></script>
<!-- END PAGE LEVEL PLUGINS -->
<!-- BEGIN PAGE LEVEL SCRIPTS -->
<script src="${baseUrl}/assets/scripts/core/app.js"></script>
<!-- END PAGE LEVEL SCRIPTS -->
<script>
jQuery(document).ready(function() {    
  App.init();
  
  $('#selectEmailId').change(function(){
	  window.location.href = 'superManager/emailTemplateTest?mailId=' + $(this).val() + '&journalType=' + $('#selectJournalTypeId').val() + '&manuscriptTrack=' + $('#selectIsSI').val();
  });
  
  $('#selectJournalTypeId').change(function(){
	  window.location.href = 'superManager/emailTemplateTest?mailId=' + $('#selectEmailId').val() + '&journalType=' + $(this).val() + '&manuscriptTrack=' + $('#selectIsSI').val();
  });
  
  $('#selectIsSI').change(function(){
	  window.location.href = 'superManager/emailTemplateTest?mailId=' + $('#selectEmailId').val() + '&journalType=' + $('#selectJournalTypeId').val() + '&manuscriptTrack=' + $(this).val();
  });   
});
</script>
</footer>
</body>
<!-- END BODY -->
</html>