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
<div id="editAccountDisplay" class="modalDialog"></div>
<c:set var="ajaxRequestUrl" value="${baseUrl }/journals/${jnid }/manager/configuration/accounts/accountsTable"/>
<body>
<%@ include file="/WEB-INF/views/includes/headerBar.jsp" %>
<div class="page-container">
<div class="container">
		<div class="row page-boxed">
			<div class="col-md-12">
				<customTagFile:breadcrumb link_1="${baseUrl}/journals/${jnid }" label_1="system.journalHome"
																	link_2="${baseUrl}/journals/${jnid}/manager/" label_2="user.role.journal_manager"
																	link_3="${baseUrl}/journals/${jnid}/manager/configuration/accounts/manageAccounts" label_3="manager.menu.accountManagement"/>

				<div class="tabbable tabbable-custom tabbable-full-width">
					<ul class="nav nav-tabs">
						<li class="active">
							<a id="tab0" class="tabClick" href="#tab_1_1" data-toggle="tab">
								<spring:message code="manager.menu.accountManagement"/>
							</a>
						</li>
					</ul>
					<div class="tab-content">
						<div class="tab-pane active" id="tab_1_1">

							<div class="form form-wizard">
								<div class="form-body">
								
									<div class="row form-section">
										<div class="col-md-12">
											<div class="table-container">					
												<table class="table table-bordered fixedWidthSize" id="accountsTable">
												<thead>
												<tr>
													<th> </th>			
													<th><spring:message code='signin.username'/> (<spring:message code='user.username'/>)</th>
													<th><spring:message code="user.name"/></th>
													<th><spring:message code="user.institution"/></th>
													<th><spring:message code="user.department"/></th>
													<th><spring:message code="user.country"/></th>
													<th><spring:message code="system.action"/></th>
												</tr>
												<tr class="filter">
													<td></td>
													<td>
														<input type="text" class="form-control form-filter">
													</td>
													<td>
														<input type="text" class="form-control form-filter">
													</td>
													<td>
														<input type="text" class="form-control form-filter">
													</td>
													<td>
														<input type="text" class="form-control form-filter">
													</td>
													<td>
														<div>
															<select class="select2 countryFilter form-control form-filter">
																<option value=""></option>
																<%@ include file="/WEB-INF/views/includes/country.jsp" %>
																</select>
														</div>
													</td>
													<td>
													</td>
												</tr>
												</thead>
												<tbody>
												</tbody>
												</table>
											</div>
										</div>
									</div>
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
<script src="${baseUrl}/js/roles/jquery-ui.js"></script>
<script src="${baseUrl}/js/roles/manager/accountsList-table-ajax.js"></script>
</footer>
<script>
var errorMessages = new Array();
errorMessages['user.required.newUser.email'] = "<spring:message code='user.required.newUser.email' javaScriptEscape='true' />";
errorMessages['user.required.validEmail'] = "<spring:message code='user.required.validEmail' javaScriptEscape='true' />";
errorMessages['user.required.emailAlreadyUsed'] = "<spring:message code='user.required.emailAlreadyUsed' javaScriptEscape='true' />";
errorMessages['user.required.fullnameNative'] = "<spring:message code='user.required.fullnameNative' javaScriptEscape='true' />";
errorMessages['user.required.firstname'] = "<spring:message code='user.required.firstname' javaScriptEscape='true' />";
errorMessages['user.required.lastname'] = "<spring:message code='user.required.lastname' javaScriptEscape='true' />";
errorMessages['user.required.institution'] = "<spring:message code='user.required.institution' javaScriptEscape='true' />";
errorMessages['user.required.department'] = "<spring:message code='user.required.department' javaScriptEscape='true' />";
errorMessages['user.required.localInstitution'] = "<spring:message code='user.required.localInstitution' javaScriptEscape='true' />";
errorMessages['user.required.localDepartment'] = "<spring:message code='user.required.localDepartment' javaScriptEscape='true' />";
errorMessages['user.required.country'] = "<spring:message code='user.required.country' javaScriptEscape='true' />";
errorMessages['user.required.degree'] = "<spring:message code='user.required.degree' javaScriptEscape='true' />";
errorMessages['user.required.salutation'] = "<spring:message code='user.required.salutation' javaScriptEscape='true' />";
errorMessages['user.required.currentPasswordEqual'] = "<spring:message code='user.required.currentPasswordEqual' javaScriptEscape='true' />";
errorMessages['user.required.password'] = "<spring:message code='user.required.password' javaScriptEscape='true' />";	
errorMessages['user.required.passwordConfirm'] = "<spring:message code='user.required.passwordConfirm' javaScriptEscape='true' />";
errorMessages['user.required.passwordEqual'] = "<spring:message code='user.required.passwordEqual' javaScriptEscape='true' />";
errorMessages['user.required.minlength'] = "<spring:message code='user.required.minlength' javaScriptEscape='true' />";	
errorMessages['user.required.maxlength'] = "<spring:message code='user.required.maxlength' javaScriptEscape='true' />";
errorMessages['user.required.website'] = "<spring:message code='user.required.website' javaScriptEscape='true' />";
errorMessages['myaccount.required.newPasswordConfirm'] = "<spring:message code='myaccount.required.newPasswordConfirm' javaScriptEscape='true' />";
errorMessages['myaccount.required.passwordConfirm'] = "<spring:message code='myaccount.required.passwordConfirm' javaScriptEscape='true' />";
errorMessages['user.required.jobTitle'] = "<spring:message code='user.required.jobTitle' javaScriptEscape='true' />";
function editAccount(userId) {
	$.ajax({
		type:"GET",
		url: "${baseUrl}/journals/${jnid}/manager/configuration/accounts/editAccount",
		data: "userId=" + userId,
		success: function(html){
			$("#editAccountDisplay").html(html);
		}
	});	
	$("#editAccountDisplay").show();
	$("#editAccountDisplay").dialog("open");
}

jQuery(document).ready(function() {
	TableAjax.init("${ajaxRequestUrl}");
	
	oTable = $('#accountsTable').dataTable();
	$(".form-filter").on("keyup change", function () {
		oTable.fnFilter( this.value, $(".form-filter").index(this) );
	});
	$(".countryFilter").select2({
	    allowClear: true,
	    dropdownAutoWidth: true,
	    formatResult: function(state) {
	    	if (!state.id) return state.text;
	        return "<img class='flag' src='assets/img/flags/" + state.id.toLowerCase() + ".png' />&nbsp;" + state.text;
	    },
	    formatSelection: function(state) {
	    	if (!state.id) return state.text;
	        return "<img class='flag' src='assets/img/flags/" + state.id.toLowerCase() + ".png'/>&nbsp;<small>" + state.text + "<small>";
	    },
	    escapeMarkup: function (m) {
	        return m;
	    },
	    containerCssClass: "muted"
	});
	
	$("#editAccountDisplay").dialog({
		width: currentWidth * 0.8,
		height: currentHeight * 0.8,
		resizable: true,
		modal:true,
		autoOpen: false,
	 	show: {
			 effect: "slide",
			 duration: 500
		}
	});
});
</script>
</body>
</html>