<%@ page import="link.thinkonweb.configuration.SystemConstants" %>
<!DOCTYPE html>
<!--[if lt IE 7]>      <html class="no-js lt-ie9 lt-ie8 lt-ie7"> <![endif]-->
<!--[if IE 7]>         <html class="no-js lt-ie9 lt-ie8"> <![endif]-->
<!--[if IE 8]>         <html class="no-js lt-ie9"> <![endif]-->
<!--[if gt IE 8]><!--> <html class="no-js"> <!--<![endif]-->
<head>
<%@ include file="/WEB-INF/views/includes/header.jsp" %>
<title><spring:message code='superUser.dashboard.title'/></title>
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
			<h3><i class="fa fa-users"></i>&nbsp;<spring:message code='superUser.dashboard.roleManagement'/></h3>
	</div>
	
	<div class="form-group" style="width:600px">
		<label class="col-md-2 control-label" for="title">Select Journal:</label>
		<div class="col-md-7">
			<select id="journalNameId" class="form-control input-xxlarge" style="width:600px">
				<c:choose>
					<c:when test="${journalNameId=='any'}">
						<option value="any" selected="selected">Any</option>
					</c:when>
					<c:otherwise>
						<option value="any">Any</option>
					</c:otherwise>
				</c:choose>
				
				<c:forEach var="journal" items="${journals}">
					<c:choose>
						<c:when test="${journal.journalNameId==journalNameId}">
							<option value="${journal.journalNameId}" selected="selected">${journal.journalNameId} (${journal.title})</option>
						</c:when>
						<c:otherwise>
							<option value="${journal.journalNameId}">${journal.journalNameId} (${journal.title})</option>
						</c:otherwise>
					</c:choose>
				</c:forEach>
			</select>
		</div>
	</div>
	
	<br/>
	<br/>
	
	<div class="table-container">
		<table class="table table-striped table-bordered table-hover fixedWidthSize" id="roleList_ajax">
		<thead id="thead">
			<c:choose>
				<c:when test="${journalNameId=='any'}">
					<tr role='row' class='heading'>
						<th class='text-middle text-center'>No.</th>
						<th class='text-middle text-center' id='username_header'><spring:message code='user.username'/></th>
						<th class='text-middle text-center'><spring:message code='user.firstname'/></th>
						<th class='text-middle text-center'><spring:message code='user.lastname'/></th>
						<th class='text-middle text-center'><spring:message code='user.enabled'/></th>
						<th class='text-middle text-center'><spring:message code='user.role.super_manager'/></th>
						<th class='text-middle text-center'><spring:message code='user.role.journal_member'/></th>
						<th class='text-middle text-center'><spring:message code='user.role.journal_manager'/></th>
						<th class='text-middle text-center'><spring:message code='user.role.journal_c-editor'/></th>
						<th class='text-middle text-center'><spring:message code='user.role.journal_g-editor'/></th>
						<th class='text-middle text-center'><spring:message code='user.role.journal_a-editor'/></th>
						<th class='text-middle text-center'><spring:message code='user.role.journal_b-member'/></th>
						<th class='text-middle text-center'><spring:message code='user.role.journal_reviewer'/></th>
						<th class='text-middle text-center'><spring:message code='system.action'/></th>
					</tr>
				</c:when>
				<c:otherwise>
					<tr role='row' class='heading'>
						<th class='text-middle text-center' rowspan='2'>No.</th>
						<th class='text-middle text-center' id='username_header' rowspan='2'><spring:message code='user.username'/></th>
						<th class='text-middle text-center' rowspan='2'><spring:message code='user.firstname'/></th>
						<th class='text-middle text-center' rowspan='2'><spring:message code='user.lastname'/></th>
						<th class='text-middle text-center' rowspan='2'><spring:message code='user.enabled'/></th>
						<th class='text-middle text-center' rowspan='2'><spring:message code='user.role.super_manager'/></th>
						<th class='text-middle text-center' colspan='7'>${journalTitle}</th>
						<th class='text-middle text-center' rowspan='2'><spring:message code='system.action'/></th>
					</tr>
					<tr role='row' class='heading'>
						<th class='text-middle text-center'><spring:message code='user.role.journal_member'/></th>
						<th class='text-middle text-center'><spring:message code='user.role.journal_manager'/></th>
						<th class='text-middle text-center'><spring:message code='user.role.journal_c-editor'/></th>
						<th class='text-middle text-center'><spring:message code='user.role.journal_g-editor'/></th>
						<th class='text-middle text-center'><spring:message code='user.role.journal_a-editor'/></th>
						<th class='text-middle text-center'><spring:message code='user.role.journal_b-member'/></th>
						<th class='text-middle text-center'><spring:message code='user.role.journal_reviewer'/></th>
					</tr>
				</c:otherwise>
				</c:choose>
				<tr role='row' class='filter'>
					<td></td>
					<td><input type='text' class='form-control form-filter input-sm' id='filter_username'></td>
					<td><input type='text' class='form-control form-filter input-sm' id='filter_firstname'></td>
					<td><input type='text' class='form-control form-filter input-sm' id='filter_lasttname'></td>
					<td><select name='order_status' class='form-control form-filter input-sm'>
							<option value='Any'>Any</option>
							<option value='Enabled'>Enabled</option>
							<option value='Disabled'>Disabled</option>
					</select></td>
					<td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td>
					<td><button class='btn btn-xs btn-default filter-cancel'><i class='fa fa-times'></i> Reset</button></td>
				</tr>
		</thead>
		<tbody>
		</tbody>
		</table>
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
<script type="text/javascript" src="${baseUrl}/assets/plugins/select2/select2.min.js"></script>
<script type="text/javascript" src="${baseUrl}/assets/plugins/data-tables/jquery.dataTables.js"></script>
<script type="text/javascript" src="${baseUrl}/assets/plugins/data-tables/DT_bootstrap.js"></script>
<script type="text/javascript" src="${baseUrl}/js/tabletools_media/js/TableTools.min.js"></script>
<script type="text/javascript" src="${baseUrl}/js/tabletools_media/js/ZeroClipboard.js"></script>
<!-- END PAGE LEVEL PLUGINS -->
<!-- BEGIN PAGE LEVEL SCRIPTS -->
<script src="${baseUrl}/assets/scripts/core/app.js"></script>
<script src="${baseUrl}/assets/scripts/core/datatable.js"></script>
<script src="${baseUrl}/js/homes/roleList-table-ajax.js"></script>
<!-- END PAGE LEVEL SCRIPTS -->
<script>
var theadByJournal1 = "<tr role='row' class='heading'>\
	<th class='text-middle text-center' rowspan='2'>No.</th>\
	<th class='text-middle text-center' id='username_header' rowspan='2'><spring:message code='user.username'/></th>\
	<th class='text-middle text-center' rowspan='2'><spring:message code='user.firstname'/></th>\
	<th class='text-middle text-center' rowspan='2'><spring:message code='user.lastname'/></th>\
	<th class='text-middle text-center' rowspan='2'><spring:message code='user.enabled'/></th>\
	<th class='text-middle text-center' rowspan='2'><spring:message code='user.role.super_manager'/></th>\
	<th class='text-middle text-center' colspan='7'>"

var theadByJournal2="</th><th class='text-middle text-center' rowspan='2'><spring:message code='system.action'/></th>\
	</tr>\
	<tr role='row' class='heading'>\
	<th class='text-middle text-center'><spring:message code='user.role.journal_member'/></th>\
	<th class='text-middle text-center'><spring:message code='user.role.journal_manager'/></th>\
	<th class='text-middle text-center'><spring:message code='user.role.journal_c-editor'/></th>\
	<th class='text-middle text-center'><spring:message code='user.role.journal_g-editor'/></th>\
	<th class='text-middle text-center'><spring:message code='user.role.journal_a-editor'/></th>\
	<th class='text-middle text-center'><spring:message code='user.role.journal_b-member'/></th>\
	<th class='text-middle text-center'><spring:message code='user.role.journal_reviewer'/></th>\
	</tr>";
	


jQuery(document).ready(function() {    
  App.init();
  TableAjax.init();

	oTable = $('#roleList_ajax').dataTable(); 
		
	$(".form-filter").on("keyup change", function () {
		oTable.fnFilter( this.value, $(".form-filter").index(this) );
	} );
	
	$(".filter-cancel").click(function() {
	    var oSettings = oTable.fnSettings();
	    var iCol;
	    for(iCol = 0; iCol < oSettings.aoPreSearchCols.length; iCol++) {
	        oSettings.aoPreSearchCols[ iCol ].sSearch = '';
	    }
	    //oTable.fnDraw();
	    //console.log(oSettings);
	 });
	
	$(".dataTables_filter input").addClass("input-sm");
	$(".dataTables_filter input").css("margin-bottom","0px");
	$(".dataTables_filter input").css("padding-bottom","0px");
	
	$("#cancel").click(function(event) {
		var url = "${baseUrl}";    
		$(location).attr('href', url);
		return false;
	});

	$("#journalNameId").change(function() {		
		window.location.href = "superManager/roleList?jnid=" + $("#journalNameId").val();
	});
	
	$("#username_header").removeClass("dataTableID");
	
	$(".userRole").live('click',function() {		
		var tokens = $(this).attr('id').split(':');

		if (tokens[2].indexOf("ROLE_SUPER_MANAGER") != -1 || tokens[2].indexOf("ROLE_MEMBER") != -1) {
			if (confirm('Are you sure?')) {
				if ($(this).attr('checked')) {
					$.ajax({
						  type: "POST",
						  url: "superManager/changeRole",
						  data: { userId: tokens[0], jnid: tokens[1], role: tokens[2], action: "<%=SystemConstants.addRole%>" }
					}).done(function( msg ) {
					    //alert( "Data Saved: " + msg );
					});
				} else {
					$.ajax({
						  type: "POST",
						  url: "superManager/changeRole",
						  data: { userId: tokens[0], jnid: tokens[1], role: tokens[2], action: "<%=SystemConstants.deleteRole%>" }
					}).done(function( msg ) {
					    //alert( "Data Saved: " + msg );
					});
				}
			} else {
				if ($(this).attr('checked')) {
					$(this).attr('checked',false);
				} else {
					$(this).attr('checked',true);
				}
			}	
		} else {
			if ($(this).attr('checked')) {
				$.ajax({
					  type: "POST",
					  url: "superManager/changeRole",
					  data: { userId: tokens[0], jnid: tokens[1], role: tokens[2], action: "<%=SystemConstants.addRole%>" }
				}).done(function( msg ) {
				    //alert( "Data Saved: " + msg );
				});
			} else {
				$.ajax({
					  type: "POST",
					  url: "superManager/changeRole",
					  data: { userId: tokens[0], jnid: tokens[1], role: tokens[2], action: "<%=SystemConstants.deleteRole%>" }
				}).done(function( msg ) {
				    //alert( "Data Saved: " + msg );
				});
			}
		}
		oTable.fnDraw();
	});
});
</script>
</footer>
</body>
<!-- END BODY -->
</html>