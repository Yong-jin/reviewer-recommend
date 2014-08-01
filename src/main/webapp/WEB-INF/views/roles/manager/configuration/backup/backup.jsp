<%@ page import="link.thinkonweb.configuration.SystemConstants" %>
<%@ taglib prefix="customTagFile" tagdir="/WEB-INF/tags" %>

<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8 no-js"> <![endif]-->
<!--[if IE 9]> <html lang="en" class="ie9 no-js"> <![endif]-->
<!--[if !IE]><!-->
<html lang="en" class="no-js">
<!--<![endif]-->
<head>
<%@ include file="/WEB-INF/views/includes/header.jsp" %>
<title><spring:message code='user.role.journal_manager'/></title>
<link href="${baseUrl}/assets/plugins/data-tables/DT_bootstrap.css" rel="stylesheet" />
<link href="${baseUrl}/assets/css/plugins.css" rel="stylesheet" type="text/css"/>
<link href="${baseUrl}/assets/css/style-metronic.css" rel="stylesheet" type="text/css"/>
<link href="${baseUrl}/css/dataTables.tableTools.css" rel="stylesheet" type="text/css"/>
<link href="${baseUrl}/assets/plugins/bootstrap-datepicker/css/datepicker.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css" href="${baseUrl}/assets/plugins/bootstrap-select/bootstrap-select.min.css"/>
<link rel="stylesheet" type="text/css" href="${baseUrl}/assets/plugins/jquery-multi-select/css/multi-select.css"/>
<link href="${baseUrl}/css/custom.css" rel="stylesheet" type="text/css"/>
</head>
<body>
<%@ include file="/WEB-INF/views/includes/headerBar.jsp" %>
<div class="page-container">
    <div class="container">
		<div class="row page-boxed">
			<div class="col-md-12">
				<customTagFile:breadcrumb link_1="${baseUrl}/journals/${jnid }" label_1="system.journalHome"
																	link_2="${baseUrl}/journals/${jnid}/${currentPageRole }/" label_2="user.role.journal_manager"
																	link_3="${baseUrl}/journals/${jnid}/${currentPageRole }/configuration/backup" label_3="manager.menu.manuscriptsBackup"/>
				
				<div class="tabbable tabbable-custom tabbable-full-width">
					<ul class="nav nav-tabs">
						<li class="active">
							<a id="tab0" class="tabClick" href="#manuscriptsList" data-toggle="tab">
								<spring:message code='manager.menu.submittedManuscripts'/>
							</a>
						</li>
						<li>
							<a id="tab1" class="tabClick" href="#backup" data-toggle="tab">
								<spring:message code="manager.menu.manuscriptsBackup"/>
							</a>
						</li>
					</ul>
					
					<div class="tab-content">
						<div class="tab-pane mainTab active" id="manuscriptsList">
							<div class="row">
								<div class="col-md-12">
									<div class="searchOptionsField">
										<select class="bs-select form-control columnSelect marginRight15" multiple data-width="200px">
											<c:forEach var="indexName" items="${indexNames }" varStatus="status">
												<option value="${indexName.getType(status.index) }"><spring:message code="manager.backup.column.${indexName.id}"/></option>
											</c:forEach>
										</select>
										<select class="bs-select form-control statusSelect" name="status" multiple data-width="200px"">
											<c:forEach var="status" items="${allStatus }">
												<option value="${status}">${status}. <spring:message code="system.title${status}"/></option>
											</c:forEach>
										</select>
										<input type="hidden" id="filterStatus" class="form-filter" value=""/>
									</div>
									<div id="manuscriptsDisplay"></div>
									<br/>
									<br/>
								</div>
							</div>
						</div>
						<div class="tab-pane mainTab" id="backup">
							<div class="row">
								<div class="col-md-12">
									<h4><spring:message code="manager.menu.manuscriptsBackup"/></h4>
									<div class="row">
										<label class="control-label col-md-2"></label>
										<div class="col-md-10">
											<div class="portlet">
												<div class="portlet-body" >
													<fieldset class="col-md-11">
														<spring:message code="manager.config.clickToDownload"/><br/><br/>
														<button id="backupButton" class="btn green">
															<i class="fa fa-save "></i> <spring:message code="system.download"/>
														</button>
													</fieldset>
												</div>
											</div>
										</div>
									</div>
									<br/>
									<br/>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<footer>
<%@ include file="/WEB-INF/views/includes/footerBar.jsp" %>
<script src="${baseUrl}/assets/plugins/bootstrap-datepicker/js/bootstrap-datepicker.js"></script>
<script src="${baseUrl}/assets/plugins/jquery-validation/dist/jquery.validate.js" type="text/javascript" ></script>
<script src="${baseUrl}/assets/plugins/jquery-validation/dist/additional-methods.min.js" type="text/javascript"></script>
<script src="${baseUrl}/js/roles/datatable.js"></script>
<script src="${baseUrl}/js/roles/manuscriptTable_jquery.dataTables.js" type="text/javascript"></script>
<script src="${baseUrl}/js/roles/manuscriptTable_DT_bootstrap.js" type="text/javascript"></script>
<script src="${baseUrl}/js/roles/manager/manuscriptsBackup_dataTables.tableTools.js" type="text/javascript"></script>
<script src="${baseUrl}/js/roles/manager/dataTables.colReorder.js" type="text/javascript"></script>
<script src="${baseUrl}/js/roles/manager/dataTables.fixedHeader.js" type="text/javascript"></script>
<script src="${baseUrl}/js/roles/manager/dataTables.colVis.js" type="text/javascript"></script>
<script type="text/javascript" src="${baseUrl}/assets/plugins/bootstrap-select/bootstrap-select.min.js"></script>
<script src="${baseUrl}/assets/plugins/bootstrap-hover-dropdown/bootstrap-hover-dropdown.min.js" type="text/javascript"></script>
</footer>

<c:set var="manuscriptsUrl" value="${baseUrl}/journals/${jnid}/manager/configuration/backup/manuscripts"/>
<script src="${baseUrl}/js/roles/hashChange.js"></script>
<script>
Map = function(){
	this.map = new Object();
};  
Map.prototype = {  
    put : function(key, value){  
        this.map[key] = value;
    },  
    get : function(key){  
        return this.map[key];
    },
    containsKey : function(key){   
     return key in this.map;
    },
    containsValue : function(value){   
     for(var prop in this.map){
      if(this.map[prop] == value) return true;
     }
     return false;
    },
    isEmpty : function(key){   
     return (this.size() == 0);
    },
    clear : function(){  
     for(var prop in this.map){
      delete this.map[prop];
     }
    },
    remove : function(key){   
     delete this.map[key];
    },
    keys : function(){  
        var keys = new Array();  
        for(var prop in this.map){  
            keys.push(prop);
        }  
        return keys;
    },
    values : function(){  
     var values = new Array();  
        for(var prop in this.map){  
         values.push(this.map[prop]);
        }  
        return values;
    },
    size : function(){
      var count = 0;
      for (var prop in this.map) {
        count++;
      }
      return count;
    }
};
$(document).ready(function() {
	var parameterMap = new Map();
	var statusMap = new Map();
	var url = "${manuscriptsUrl}";
	parameterMap.put("num", true);
	parameterMap.put("temporaryId", false);
	parameterMap.put("submitId", true);
	parameterMap.put("submitter", true);
	parameterMap.put("institution", false);
	parameterMap.put("revision", false);
	parameterMap.put("title", true);
	parameterMap.put("submitDate", true);
	parameterMap.put("acceptDate", false);
	parameterMap.put("reviewResult", true);
	parameterMap.put("reviewers", false);
	parameterMap.put("chiefEditor", false);
	parameterMap.put("manager", false);
	parameterMap.put("associateEditor", false);
	parameterMap.put("guestEditor", false);
	parameterMap.put("status", true);
	var keys = parameterMap.keys();
	
	for(var i=0; i<keys.length; i++) {
		if(i == 0) url += "?";
		else url += "&";
		url += keys[i] + "=";
		if(parameterMap.get(keys[i])) url += "1";
		else url += "0";
	}
	<c:forEach var="status" items="${allStatus }">
		<c:choose>
			<c:when test ="${status == 'B' or status == 'W'}">
				statusMap.put("${status}", false);
			</c:when>
			<c:otherwise>
				statusMap.put("${status}", true);
			</c:otherwise>
		</c:choose>
	</c:forEach>

	var statusKeys = statusMap.keys();
	

    $('.bs-select').selectpicker({
        iconBase: 'fa',
        tickIcon: 'fa-check'
    });
	
	for(var i=0; i<$("select.columnSelect option").length; i++) {
		if(parameterMap.get(keys[i]))
			$("select.columnSelect option:eq(" + i + ")").attr("selected", "selected");
	}
	
	for(var i=0; i<$("select.statusSelect option").length; i++) {
		if(statusMap.get(statusKeys[i]))
			$("select.statusSelect option:eq(" + i + ")").attr("selected", "selected");
	}	
	$('.statusSelect > div.dropdown-menu > ul.dropdown-menu.inner.selectpicker > li').removeClass("selected");
	var statusSelectList = $('.statusSelect > div.dropdown-menu > ul.dropdown-menu.inner.selectpicker > li');
 	for(var i=0; i<statusSelectList.length; i++) {
 		if(statusMap.get(statusKeys[i]))
			statusSelectList[i].className += " selected";
	}
	
	
	$('.columnSelect > div.dropdown-menu > ul.dropdown-menu.inner.selectpicker > li').removeClass("selected");
	var columnSelectList = $('.columnSelect > div.dropdown-menu > ul.dropdown-menu.inner.selectpicker > li');
 	for(var i=0; i<columnSelectList.length; i++) {
 		if(parameterMap.get(keys[i]))
			columnSelectList[i].className += " selected";
	}
	
	$('.columnSelect > button > .filter-option').text('<spring:message code="manager.config.selectColumns"/>');
    $('select.columnSelect').change(function(event) {
    	var selectedValue = "";
    	$(".columnSelect > option:selected").each(function() {
    		selectedValue += "&" + $(this).val() + "=1";
    	});
		selectedValue = selectedValue.replace("&", "?");
		$('.columnSelect > button > .filter-option').text('<spring:message code="manager.config.selectColumns"/>');
    	$.ajax({
    		type:"GET",
    		url: "${baseUrl}/journals/${jnid}/manager/configuration/backup/manuscripts" + selectedValue,
    		success:function(html){
    			$('#manuscriptsDisplay').html(html).show();
    		}
    	}); 
    });
    
	
	$.ajax({
		type:"GET",
		url: url,
		success:function(html){
			$('#manuscriptsDisplay').html(html).show();
		}
	});
	
	$('#backupButton').click(function(event) {
		location.href="${baseUrl}/journals/${journal.journalNameId}/download/backupJournal";
	});
});
</script>
</body>
</html>
