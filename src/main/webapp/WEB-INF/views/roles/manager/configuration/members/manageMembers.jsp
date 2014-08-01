<%@ taglib prefix="customTagFile" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8 no-js"> <![endif]-->
<!--[if IE 9]> <html lang="en" class="ie9 no-js"> <![endif]-->
<!--[if !IE]><!-->
<html lang="en" class="no-js">
<!--<![endif]-->
<head>
<title>My Page</title>
<%@ include file="/WEB-INF/views/includes/header.jsp" %>
<link href="${baseUrl}/assets/plugins/data-tables/DT_bootstrap.css" rel="stylesheet" />
<link href="${baseUrl}/assets/css/plugins.css" rel="stylesheet" type="text/css"/>
<link href="${baseUrl}/css/custom.css" rel="stylesheet" type="text/css"/>
</head>
<c:set var="ajaxRequestUrl" value="${baseUrl }/journals/${jnid }/manager/configuration/members/"/>
<body>
<%@ include file="/WEB-INF/views/includes/headerBar.jsp" %>
<div class="page-container">
<div class="container">
		<div class="row page-boxed">
			<div class="col-md-12">
				<customTagFile:breadcrumb link_1="${baseUrl}/journals/${jnid }" label_1="system.journalHome"
																	link_2="${baseUrl}/journals/${jnid}/manager/" label_2="user.role.journal_manager"
																	link_3="${baseUrl}/journals/${jnid}/manager/configuration/members/manageMembers" label_3="manager.menu.editorialMemberManagement"/>

				<div class="tabbable tabbable-custom tabbable-full-width">
					<ul class="nav nav-tabs">
						<li class="active">
							<a id="tab0" class="tabClick" href="#tabchiefEditor" data-toggle="tab">
								<spring:message code="manager.config.chiefEditor"/>
							</a>
						</li>
						<li>
							<a id="tab1" class="tabClick" href="#tabmanager" data-toggle="tab">
								<spring:message code="manager.config.manager"/>
							</a>
						</li>
						<li>
							<a id="tab2" class="tabClick" href="#tabassociateEditor" data-toggle="tab">
								<spring:message code="manager.config.associateEditor"/>
							</a>
						</li>
						<li>
							<a id="tab3" class="tabClick" href="#tabguestEditor" data-toggle="tab">
								<spring:message code="manager.config.guestEditor"/>
							</a>
						</li>
						<li>
							<a id="tab4" class="tabClick" href="#tabboardMember" data-toggle="tab">
								<spring:message code="manager.config.boardMember"/>
							</a>
						</li>
					</ul>
					<div class="tab-content">
						<c:forEach var="roleString" items="${roleStrings }">
							<div class="tab-pane <c:if test="${roleString == 'chiefEditor'}">active</c:if>" id="tab${roleString }">
								<%@ include file="/WEB-INF/views/roles/manager/configuration/members/createMember.jsp" %>
							</div>
						</c:forEach>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<footer>
<%@ include file="/WEB-INF/views/includes/footerBar.jsp" %>
<script src="${baseUrl}/assets/plugins/jquery-validation/dist/jquery.validate.min.js" type="text/javascript" ></script>
<script src="${baseUrl}/assets/plugins/jquery-validation/dist/additional-methods.min.js" type="text/javascript" ></script>
<script src="${baseUrl}/assets/plugins/bootstrap-wizard/jquery.bootstrap.wizard.min.js" type="text/javascript" ></script>

<script src="${baseUrl}/assets/plugins/bootstrap-switch/js/bootstrap-switch.min.js" type="text/javascript"></script>
<script src="${baseUrl}/assets/plugins/bootstrap-maxlength/bootstrap-maxlength.min.js" type="text/javascript"></script>
<script src="${baseUrl}/assets/plugins/bootstrap-touchspin/bootstrap.touchspin.js" type="text/javascript"></script>
<script src="${baseUrl}/assets/plugins/typeahead/handlebars.min.js" type="text/javascript"></script>
<script src="${baseUrl}/assets/plugins/typeahead/typeahead.min.js" type="text/javascript"></script>

<script src="${baseUrl}/js/roles/manuscriptTable_jquery.dataTables.js" type="text/javascript" ></script>
<script src="${baseUrl}/js/roles/manuscriptTable_DT_bootstrap.js" type="text/javascript"></script>
<script src="${baseUrl}/js/roles/datatable.js"></script>

<script src="${baseUrl}/js/roles/manager/signupMember.js"></script>
<script src="${baseUrl}/js/roles/manager/memberCandidateList-table-ajax.js"></script>
</footer>
<%@ include file="/WEB-INF/views/roles/manager/configuration/members/createMemberCommonScripts.jsp" %>
<script>
var errorMessages = new Array();
errorMessages['user.required.newUser.email'] = "<spring:message code='user.required.newUser.email' javaScriptEscape='true' />";
errorMessages['user.required.validEmail'] = "<spring:message code='user.required.validEmail' javaScriptEscape='true' />";
errorMessages['user.required.emailAlreadyUsed'] = "<spring:message code='user.required.emailAlreadyUsed' javaScriptEscape='true' />";
errorMessages['user.required.newUser.fullnameNative'] = "<spring:message code='user.required.newUser.fullnameNative' javaScriptEscape='true' />";
errorMessages['user.required.newUser.firstname'] = "<spring:message code='user.required.newUser.firstname' javaScriptEscape='true' />";
errorMessages['user.required.newUser.lastname'] = "<spring:message code='user.required.newUser.lastname' javaScriptEscape='true' />";
errorMessages['user.required.newUser.institution'] = "<spring:message code='user.required.newUser.institution' javaScriptEscape='true' />";
errorMessages['user.required.newUser.department'] = "<spring:message code='user.required.newUser.department' javaScriptEscape='true' />";
errorMessages['user.required.newUser.localInstitution'] = "<spring:message code='user.required.newUser.localInstitution' javaScriptEscape='true' />";
errorMessages['user.required.newUser.localDepartment'] = "<spring:message code='user.required.newUser.localDepartment' javaScriptEscape='true' />";
errorMessages['user.required.newUser.country'] = "<spring:message code='user.required.newUser.country' javaScriptEscape='true' />";
errorMessages['user.required.newUser.degree'] = "<spring:message code='user.required.newUser.degree' javaScriptEscape='true' />";
errorMessages['user.required.newUser.salutation'] = "<spring:message code='user.required.newUser.salutation' javaScriptEscape='true' />";
errorMessages['user.required.minlength'] = "<spring:message code='user.required.minlength' javaScriptEscape='true' />";
errorMessages['user.required.maxlength'] = "<spring:message code='user.required.maxlength' javaScriptEscape='true' />";
errorMessages['user.required.newUser.jobTitle'] = "<spring:message code='user.required.newUser.jobTitle' javaScriptEscape='true' />";
errorMessages['signup.countryHelp'] = "<spring:message code='signup.countryHelp' javaScriptEscape='true' />";

function select(role, roleStringUpper, userId) {
	var url = "${baseUrl}/journals/${jnid}/manager/configuration/members/select" + roleStringUpper;
	var postString = "userId=" + userId;
	jQuery.ajax({
		type:"POST",
		url: url,
		data: postString,
		success:function(html){
			$.ajax({
				type: 'GET',
				url: "${baseUrl}/journals/${jnid}/manager/configuration/members/" + role + "Table",
				success: function(html){
					$("#" + role + "Display").html(html).show();
					if(role == "chiefEditor")
						oTable1.fnDraw();
					else if(role == "manager")
						oTable2.fnDraw();
					else if(role == "associateEditor")
						oTable3.fnDraw();
					else if(role == "guestEditor")
						oTable4.fnDraw();
					else if(role == "boardMember")
						oTable5.fnDraw();
				}
			});
		}
	});
}


var buttonClicked;
jQuery(document).ready(function() {
	var url = "${baseUrl}/journals/${jnid}";
	SignupMember.init("chiefEditor");
	SignupMember.init("manager");
	SignupMember.init("associateEditor");
	SignupMember.init("guestEditor");
	SignupMember.init("boardMember");
	
	TableAjax.init("${ajaxRequestUrl}", "chiefEditor");
	$.ajax({
		type: 'GET',
		url: "${baseUrl}/journals/${jnid}/manager/configuration/members/chiefEditorTable",
		success: function(html){
			$("#chiefEditorDisplay").html(html).show();
		}
	});
	
	oTable1 = $('#chiefEditorTable').dataTable();
	$(".form-filterchiefEditor").on("keyup change", function () {
		oTable1.fnFilter( this.value, $(".form-filterchiefEditor").index(this) );
	});
	
	var tabNames = ["chiefEditor", "manager", "associateEditor", "guestEditor", "boardMember"];
	var tabStatus = [true, false, false, false, false];
	
	$('.tabClick').click(function() {
		var idString = $(this).attr("id");
		idString = idString.replace("tab", "");
		var index = Number(idString);
		if(!tabStatus[index]) {
			if(index == 1) {
				TableAjax.init("${ajaxRequestUrl}", "manager");
				oTable2 = $('#managerTable').dataTable();
				$(".form-filtermanager").on("keyup change", function () {
					oTable2.fnFilter( this.value, $(".form-filtermanager").index(this) );
				});
			} else if(index == 2) {
				TableAjax.init("${ajaxRequestUrl}", "associateEditor");
				oTable3 = $('#associateEditorTable').dataTable();
				$(".form-filterassociateEditor").on("keyup change", function () {
					oTable3.fnFilter( this.value, $(".form-filterassociateEditor").index(this) );
				});
			} else if(index == 3) {
				TableAjax.init("${ajaxRequestUrl}", "guestEditor");
				oTable4 = $('#guestEditorTable').dataTable();
				$(".form-filterguestEditor").on("keyup change", function () {
					oTable4.fnFilter( this.value, $(".form-filterguestEditor").index(this) );
				});
			} else if(index == 4) {
				TableAjax.init("${ajaxRequestUrl}", "boardMember");
				oTable5 = $('#boardMemberTable').dataTable();
				$(".form-filterboardMember").on("keyup change", function () {
					oTable5.fnFilter( this.value, $(".form-filterboardMember").index(this) );
				});
			}
			
			$.ajax({
				type: 'GET',
				url: "${baseUrl}/journals/${jnid}/manager/configuration/members/" + tabNames[index] + "Table",
				success: function(html){
					$("#" + tabNames[index] + "Display").html(html).show();
					tabStatus[index] = true;
				}
			});	
		}
	});
});
</script>
</body>
</html>