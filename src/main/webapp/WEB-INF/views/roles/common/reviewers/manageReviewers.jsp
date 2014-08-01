<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/includes/headerForAjax.jsp" %>
<link href="${baseUrl}/assets/css/plugins.css" rel="stylesheet" type="text/css"/>
<c:set var="ajaxRequestUrl1" value="${baseUrl }/journals/${jnid }/${currentPageRole }/reviewers/reviewerCandidateTable/boardMember?manuscriptId=${manuscript.id }"/>
<c:set var="ajaxRequestUrl2" value="${baseUrl }/journals/${jnid }/${currentPageRole }/reviewers/reviewerCandidateTable/member?manuscriptId=${manuscript.id }"/>
<c:set var="ajaxRequestUrl3" value="${baseUrl }/journals/${jnid }/${currentPageRole }/reviewers/reviewerCandidateTable/nonMember?manuscriptId=${manuscript.id }"/>
<c:set var="ajaxRequestUrl4" value="${baseUrl }/journals/${jnid }/${currentPageRole }/reviewers/reviewerCandidateTable/rp?manuscriptId=${manuscript.id }"/>
<input type="hidden" class="jnid" value="${jnid }"/>
<h4 class="block"><spring:message code="associateEditor.selectedReviewers"/></h4>
<div class="row form-group">
	<label class="control-label col-md-2">
	</label>
	<div class="col-md-10">
		<fieldset class="col-md-11">
			<div id="${pageType }reviewersDisplay"><div class="loadingCenter"><img src="images/loading.gif"/></div></div>
		</fieldset>
	</div>
</div>

<div class="row">
	<div class="col-md-2"></div>
	<div class="col-md-9"><hr class="soften"/></div>
</div>

<div class="row form-group">
	<label class="control-label col-md-2">1) <spring:message code="associateEditor.selectReviewerFromBoardMembers"/>
	</label>
	<div class="col-md-10">
		<fieldset class="col-md-11">
			<c:if test="${jc.manageDivision == true and not empty divisions }">
				<div class="radio-list reviewerDivision">
					<c:forEach var="division" items="${divisions }">
						<label class="radio-inline">
						<input type="checkbox" class="divisionSelect" name="division" value="${division.symbol }"/> ${division.symbol }
						</label>
					</c:forEach>
					<input type="hidden" id="${pageType }filterDivision" class="form-filterDivision" value=""/>
				</div>
			</c:if>
			<br/>
			<div class="table-container">					
				<table class="table table-bordered fixedWidthSize" id="${pageType}reviewerTable1">
					<thead>
						<tr>
							<th class="cellCenter"></th>
							<th class="cellCenter"><spring:message code="user.username"/></th>
							<th class="cellCenter"><spring:message code="user.name"/></th>
							<th class="cellCenter"><spring:message code="user.institutionSmallWidth"/></th>
							<c:if test="${jc.manageDivision == true }">
								<th class="cellCenter"><spring:message code='system.division'/></th>
							</c:if>
							<th class="cellCenter"><spring:message code="associateEditor.invitedAtThisTime"/></th>
							<th class="cellCenter"><spring:message code="associateEditor.assignedAtThisTime"/></th>
							<th class="cellCenter"><spring:message code="system.action"/></th>
						</tr>
					</thead>
					<tbody>
					</tbody>
				</table>
			</div>
			
		</fieldset>
	</div>
</div>

<div class="row">
	<div class="col-md-2 cellCenter">
	<br/><spring:message code="system.or"/>
	</div>
	<div class="col-md-9 paddingLeft30">
		<hr class="soften"/>
	</div>
</div>

<div class="row form-group">
	<label class="control-label col-md-2">2) <spring:message code="associateEditor.selectReviewerFromMembers"/>
	</label>
	<div class="col-md-10">
		<fieldset class="col-md-11">
			
			<div class="table-container">					
				<table class="table table-bordered fixedWidthSize" id="${pageType}reviewerTable2">
					<thead>
						<tr>
							<th class="cellCenter"></th>
							<th class="cellCenter"><spring:message code="user.username"/></th>
							<th class="cellCenter"><spring:message code="user.name"/></th>
							<th class="cellCenter"><spring:message code="user.institutionSmallWidth"/></th>
							<th class="cellCenter"><spring:message code="associateEditor.invitedAtThisTime"/></th>
							<th class="cellCenter"><spring:message code="associateEditor.assignedAtThisTime"/></th>
							<th class="cellCenter"><spring:message code="system.action"/></th>
						</tr>
					</thead>
					<tbody>
					</tbody>
				</table>
			</div>
			
		</fieldset>
	</div>
</div>

<div class="row">
	<div class="col-md-2 cellCenter">
	<br/><spring:message code="system.or"/>
	</div>
	<div class="col-md-9 paddingLeft30">
		<hr class="soften"/>
	</div>
</div>

<div class="row form-group">
	<label class="control-label col-md-2">3) <spring:message code="associateEditor.selectReviewerFromNonMembers"/>
	</label>
	<div class="col-md-10">
		<fieldset class="col-md-11">
			
			<div class="table-container">					
				<table class="table table-bordered fixedWidthSize" id="${pageType}reviewerTable3">
					<thead>
						<tr>
							<th class="cellCenter"><spring:message code="manuscript.number"/></th>
							<th class="cellCenter"><spring:message code="user.username"/></th>
							<th class="cellCenter"><spring:message code="user.name"/></th>
							<th class="cellCenter"><spring:message code="user.institutionSmallWidth"/></th>
							<th class="cellCenter"><spring:message code="associateEditor.invitedAtThisTime"/></th>
							<th class="cellCenter"><spring:message code="associateEditor.assignedAtThisTime"/></th>
							<th class="cellCenter"><spring:message code="system.action"/></th>
						</tr>
					</thead>
					<tbody>
					</tbody>
				</table>
			</div>	
		</fieldset>
	</div>
</div>

<div class="row">
	<div class="col-md-2 cellCenter">
	<br/><spring:message code="system.or"/>
	</div>
	<div class="col-md-9 paddingLeft30">
		<hr class="soften"/>
	</div>
</div>

<div class="row form-group">
	<label class="control-label col-md-2">4) <spring:message code="associateEditor.selectReviewerFromReviewerPreference"/>
	</label>
	<div class="col-md-10">
		<fieldset class="col-md-11">
			<div class="table-container">					
				<table class="table table-bordered fixedWidthSize" id="${pageType}reviewerTable4">
					<thead>
						<tr>
							<th class="cellCenter"><spring:message code="manuscript.number"/></th>
							<th class="cellCenter"><spring:message code="user.username"/></th>
							<th class="cellCenter"><spring:message code="user.name"/></th>
							<th class="cellCenter"><spring:message code="user.institutionSmallWidth"/></th>
							<th class="cellCenter"><spring:message code="user.country"/></th>
							<th class="cellCenter"><spring:message code="user.degree"/></th>
							<th class="cellCenter"><spring:message code="system.action"/></th>
						</tr>
					</thead>
					<tbody>
					</tbody>
				</table>
			</div>	
		</fieldset>
	</div>
</div>

<div class="row">
	<div class="col-md-2 cellCenter">
	<br/><spring:message code="system.or"/>
	</div>
	<div class="col-md-9 paddingLeft30">
		<hr class="soften"/>
	</div>
</div>

<div class="row form-section_noborder_createReviewer">
	<label class="control-label col-md-2">5) <spring:message code="associateEditor.selectNewReviewerAfterCreation"/> </label>
	<form:form method="post" modelAttribute="reviewer" id="${pageType}reviewerRegisterForm">
	<div class="col-md-9 form-createReviewer">
			<fieldset class="col-md-6">
				<div class="row">
					<div class="form-group col-md-12">
						<label class="control-label"><spring:message code="signup.email"/></label>
						<div>
							<input type="hidden" name="jid" value="${journal.id}"/>
							<input type="hidden" name="manuscriptId" value="${manuscript.id}"/>
							<form:input path="user.username" type="text" class="form-control" id="${pageType}reviewerEmail" maxlength="100"/>
							<span class="help-block">
							</span>
						</div>
					</div>
				</div>
				<div class="row">
					<c:choose>
						<c:when test="${journal.languageCode == 'ko'}" >
							<div class="form-group col-md-6">
								<label class="control-label"><spring:message code="user.institutionSmallWidth"/></label>
								<div>
									<form:input path="user.contact.localInstitution" type="text" id="${pageType}reviewerLocalInstitution" class="form-control" maxlength="70"/>
									<span class="help-block"><spring:message code="system.korean"/> (<spring:message code="user.institutionSample-korean"/>)
									</span>
								</div>
								<br/>
								<label class="control-label"><spring:message code="user.department"/></label>
								<div>
									<form:input path="user.contact.localDepartment" type="text" class="form-control" maxlength="70"/>
									<span class="help-block"><spring:message code="system.korean"/> (<spring:message code="user.departmentSample-korean"/>)
									</span>
								</div>

							</div>
							
							<div class="form-group col-md-push-1 col-md-6">
								<label class="control-label">&nbsp;</label>
								<div>
									<form:input path="user.contact.institution" type="text" class="form-control" maxlength="70"/>
									<span class="help-block"><spring:message code="system.english"/> (<spring:message code="user.institutionSample-english"/>)
									</span>
								</div>
								<label class="control-label">&nbsp;</label>
								<div>
									<form:input path="user.contact.department" type="text" class="form-control" maxlength="70"/>
									<span class="help-block"><spring:message code="system.english"/> (<spring:message code="user.departmentSample-english"/>)
									</span>
								</div>
							</div>
						</c:when>
						<c:otherwise>
							<div class="form-group col-md-6">
								<label class="control-label"><spring:message code="user.institutionSmallWidth"/></label>
								<div>
									<form:input path="user.contact.institution" type="text" id="${pageType}reviewerInstitution" class="form-control" maxlength="70"/>
									<span class="help-block">
									</span>
								</div>
							</div>
							
							<div class="form-group col-md-push-1 col-md-6">
								<label class="control-label"><spring:message code="user.department"/></label>
								<div>
									<form:input path="user.contact.department" type="text" id="${pageType}reviewerDepartment" class="form-control" maxlength="30"/>
									<span class="help-block">
									</span>
								</div>
							</div>
						</c:otherwise>
					</c:choose>
				</div>
				
				<div class="row">
					<div class="form-group country-group col-push-1 col-md-12">
						<label class="control-label"><spring:message code="user.country"/></label>
						<div>
							<form:select path="user.contact.country" id="${pageType}reviewerCountry" class="select2 select2_country2 form-control">
								<%@ include file="/WEB-INF/views/includes/country.jsp" %>
							</form:select>
							<span class="help-block">
								<spring:message code="signup.countryHelp"/>
							</span>
						</div>
					</div>			
				</div>
			</fieldset>
		
			<fieldset class="col-md-6">
			<c:choose>
				<c:when test="${journal.languageCode == 'ko'}" >
					<div class="row" style="margin-right: -30px !important; padding-right: 0px">
						<div class="form-group col-md-12" style="margin-right: -15px !important; padding-right: 0px">
							<label class="control-label"><spring:message code="user.name"/></label>
							<div>
								<form:input path="user.contact.localFullName" type="text" id="${pageType}reviewerLocalFullName" class="form-control" maxlength="70"/>
								<span class="help-block"><spring:message code="user.koreanFullName"/> (<spring:message code="user.koreanFullnameSample"/>)
								</span>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="form-group col-md-7">
							<div>
								<form:input path="user.contact.firstName" type="text" class="form-control" maxlength="40"/>
								<span class="help-block"><spring:message code="user.firstname2"/> (<spring:message code="user.firstnameSample"/>)
								</span>
							</div>
						</div>	
						<div class="form-group col-md-push-1 col-md-6">
							<div>
								<form:input path="user.contact.lastName" type="text" class="form-control" maxlength="30"/>
								<span class="help-block"><spring:message code="user.lastname2"/> (<spring:message code="user.lastnameSample"/>)
								</span>
							</div>
						</div>
					</div>
				</c:when>
				<c:otherwise>
					<div class="row">
						<div class="form-group col-md-7">
							<label class="control-label"><spring:message code="user.firstname"/></label>
							<div>
								<form:input path="user.contact.firstName" type="text" id="${pageType}reviewerFirstName" class="form-control" maxlength="40"/>
								<span class="help-block">
								</span>
							</div>
						</div>	
						<div class="form-group col-md-push-1 col-md-6">
							<label class="control-label"><spring:message code="user.lastname"/></label>
							<div>
								<form:input path="user.contact.lastName" type="text" id="${pageType}reviewerLastName" class="form-control" maxlength="30"/>
								<span class="help-block">
								</span>
							</div>
						</div>
					</div>
				</c:otherwise>
			</c:choose>	

			<div class="row">
				<div class="form-group reviewerDegreeDiv col-md-12">
					<label class="control-label reviewerDegreeLabel"><spring:message code="user.degree"/></label>
					<div class="radio-list reviewerDegree">
						<c:forEach var="degreeDesignation" items="${degreeDesignations}">
							<label class="radio-inline">
							<form:radiobutton name="degree" class="reviewerDegreeRadio" path="user.contact.degree" value="${degreeDesignation.id}"/> <spring:message code="signin.degreeDesignation.${degreeDesignation.id}"/> </label>
						</c:forEach>
					</div>
					<span class="help-block">
					</span>
				</div>
			</div>
			<div class="row">
				<div class="form-group reviewerSalutationDiv col-md-12">
					<label class="control-label"><spring:message code="user.salutation"/></label>
					<div class="radio-list salutation reviewerSalutation">
						<c:forEach var="salutationDesignation" items="${salutationDesignations}">
							<label class="radio-inline">
							<form:radiobutton name="salutation" class="reviewerSalutationRadio" path="user.contact.salutation" value="${salutationDesignation.id}"/> <spring:message code="signin.salutationDesignation.${salutationDesignation.id}"/> 
							</label>
						</c:forEach>
					</div>
				</div>
			</div>
			<div>    
				<button type="submit" id="${pageType}registerReviewerButton" class="btn green pull-right">
				<spring:message code="system.createAndSelect"/> <i class="m-icon-swapright m-icon-white"></i>
				</button>
			</div>
		</fieldset>
	</div>
	</form:form>
</div>
<script>
var errorMessages = new Array();
errorMessages['user.required.newUser.email'] = "<spring:message code='user.required.newUser.email' javaScriptEscape='true' />";
errorMessages['user.required.validEmail'] = "<spring:message code='user.required.validEmail' javaScriptEscape='true' />";
errorMessages['user.required.emailAlreadyUsed'] = "<spring:message code='user.required.emailAlreadyUsed' javaScriptEscape='true' />";
errorMessages['user.required.emailAlreadyUsed2'] = "<spring:message code='user.required.emailAlreadyUsed2' javaScriptEscape='true' />";
errorMessages['user.required.newUser.fullnameNative'] = "<spring:message code='user.required.newUser.fullnameNative' javaScriptEscape='true' />";
errorMessages['user.required.newUser.firstname'] = "<spring:message code='user.required.newUser.firstname' javaScriptEscape='true' />";
errorMessages['user.required.newUser.lastname'] = "<spring:message code='user.required.newUser.lastname' javaScriptEscape='true' />";
errorMessages['user.required.newUser.institution'] = "<spring:message code='user.required.newUser.institution' javaScriptEscape='true' />";
errorMessages['user.required.newUser.department'] = "<spring:message code='user.required.newUser.department' javaScriptEscape='true' />";
errorMessages['user.required.newUser.localInstitution'] = "<spring:message code='user.required.newUser.localInstitution' javaScriptEscape='true' />";
errorMessages['user.required.newUser.localDepartment'] = "<spring:message code='user.required.newUser.localDepartment' javaScriptEscape='true' />";
errorMessages['user.required.newUser.degree'] = "<spring:message code='user.required.newUser.degree' javaScriptEscape='true' />";
errorMessages['user.required.newUser.salutation'] = "<spring:message code='user.required.newUser.salutation' javaScriptEscape='true' />";	
errorMessages['user.required.minlength'] = "<spring:message code='user.required.minlength' javaScriptEscape='true' />";	
errorMessages['user.required.maxlength'] = "<spring:message code='user.required.maxlength' javaScriptEscape='true' />";
errorMessages['signup.countryHelp'] = "<spring:message code='signup.countryHelp' javaScriptEscape='true' />";
errorMessages['author.newPaperSubmit.keywordRequired'] = "<spring:message code='author.newPaperSubmit.keywordRequired' javaScriptEscape='true' />";
errorMessages['author.newPaperSubmit.minLength'] = "<spring:message code='author.newPaperSubmit.minLength' javaScriptEscape='true' />";
errorMessages['author.newPaperSubmit.divisionRequired'] = "<spring:message code='author.newPaperSubmit.divisionRequired' javaScriptEscape='true' />";

function reviewerHistory(reviewerUserId) {
	$.ajax({
		type:"GET",
		url: "${baseUrl}/journals/${jnid}/${currentPageRole }/reviewers/reviewerHistory",
		data: "reviewerUserId=" + reviewerUserId,
		success: function(html) {
			$("#reviewerHistoryDisplay").html(html);
		}
	});				
	$("#reviewerHistoryDisplay").dialog("open");
}

function selectReviewer(reviewerUserId, manuscriptId) {
	$.ajax({
		type: 'POST',
		url: "${baseUrl}/journals/${jnid}/${currentPageRole }/reviewers/selectReviewer",
		data: "reviewerUserId=" + reviewerUserId + "&manuscriptId=" + manuscriptId, 
		success: function(html){
			$.ajax({
				type: 'GET',
				url: "${baseUrl}/journals/${jnid}/${currentPageRole }/reviewers/${pageType}/reviewerTable",
				data: "manuscriptId=" + "${manuscript.id}", 
				success: function(html){
					$('#' + "${pageType}" + "reviewersDisplay").html(html).show();
					oTable1.fnDraw();
					oTable2.fnDraw();
					oTable3.fnDraw();
					oTable4.fnDraw();
					App.scrollTo($('#' + "${pageType}" + 'selectedReviewers tr:last'));
				}
			});
		}
	});
}

function format(state) {
    if (!state.id) return state.text;
    return "<img class='flag' src='assets/img/flags/" + state.id.toLowerCase() + ".png'/>&nbsp;&nbsp;" + state.text;
}

function selectReviewerPreference(rpString, manuscriptId) {
	var rpStrings = rpString.split("--");
	var rpId = rpStrings[0];
	var email = rpStrings[1];
	var institution = rpStrings[2];
	var department = rpStrings[3];
	var firstName = rpStrings[4];
	var lastName = rpStrings[5];
	var countryCode = rpStrings[6];
	var degree = rpStrings[7];
	var salutation = rpStrings[8];
	var localFullName = rpStrings[9];
	var localInstitution = rpStrings[10];
	$('#' + pageType + 'reviewerEmail').val(email);
	$('#' + pageType + 'reviewerInstitution').val(institution);
	$('#' + pageType + 'reviewerDepartment').val(department);
	$('#' + pageType + 'reviewerFirstName').val(firstName);
	$('#' + pageType + 'reviewerLastName').val(lastName);
	$('#' + pageType + 'reviewerLocalFullName').val(localFullName);
	$('#' + pageType + 'reviewerLocalInstitution').val(localInstitution);
	
	var degrees = $('.reviewerDegreeRadio');
	for(var i=0; i<degrees.length; i++) {
		var value = Number(degrees[i].value);
		if(value == degree)
			degrees[i].checked = true;	
	}
	var salutations = $('.reviewerSalutationRadio');
	for(var i=0; i<salutations.length; i++) {
		var value = Number(salutations[i].value);
		if(value == salutation)
			salutations[i].checked = true;	
	}
	
	$("#" + pageType + "reviewerCountry").val(countryCode).attr("selected", "selected");
	$("#" + pageType + "reviewerCountry").select2({
	  	placeholder: '<i class="fa fa-map-marker"></i>&nbsp;&nbsp;&nbsp;' + errorMessages['signup.countryHelp'],
        allowClear: true,
        formatResult: format,
        formatSelection: format,
        escapeMarkup: function (m) {
            return m;
        }
    });
	
	App.scrollTo($('#${pageType}registerReviewerButton'));
}

var url = "${baseUrl}/journals/${jnid}";
SignupReviewer.init(url, "${pageType}");
var ReviewerTableAjax = function () {
    var handleRecordsBoardMember = function(ajaxRequestUrl, pageType, member) {
        var grid = new Datatable(ajaxRequestUrl, pageType, member);

            grid.init({
                src: $("#" + pageType + "reviewerTable1"),
                onSuccess: function(grid) {
                    // execute some code after table records loaded
                },
                onError: function(grid) {
                    // execute some code on network or other general error  
                },
                dataTable: {  // here you can define a typical datatable settings from http://datatables.net/usage/options 
                   	"sDom": "<'row form-section_noborder_table'<'col-md-6 col-sm-12'lp><'col-md-6 col-sm-12'f>>rt",
                   	"sPaginationType": "bootstrap_extended",
                 	"oSearch": {
        				"sSearch": "",
        				"bSmart" : true,
        				"bCaseInsensitive" : true
        			},
                    "sFilter": true,
                    "bFilter": true,
                    "bInfo": true,
                    "bAutoWidth": false,
                    "aLengthMenu": [
                        [10, 20, 50, 100],	  
                        [10, 20, 50, 100] 
                    ],
                    "bDeferRender": true,
                    "iDisplayStart": 0,
                    "iDisplayLength": 10, 
                    "bProcessing": true,
                    "bPaginate": true,
                    "bServerSide": true, 
                    "sAjaxSource": ajaxRequestUrl, 
                    "aaSorting": [[ 1, "asc" ]], 
                    "aoColumnDefs": [
                                     { "sClass": "cellCenter", "aTargets": [ 0 ] },
                                     { "sClass": "cellCenter", "aTargets": [ 1 ] },
                                     { "sClass": "cellCenter", "aTargets": [ 2 ] },
                                     { "sClass": "cellCenter", "aTargets": [ 3 ] },
                                     { "sClass": "cellCenter", "aTargets": [ 4 ] },
                                     { "sClass": "cellCenter", "aTargets": [ 5 ] },
                                     { "sClass": "cellCenter", "aTargets": [ 6 ] },
                                     <c:if test="${jc.manageDivision == true}">
                                     { "sClass": "cellCenter", "aTargets": [ 7 ] },
                                     </c:if>
                                     ],
                    "aoColumns": [
	                                 { "bSortable": false, "bSearchable": false, "sWidth": "40px" },
	                                 { "bSortable": true, "bSearchable": true, "sWidth": "150px" },
	                                 { "bSortable": true, "bSearchable": true},
	                                 { "bSortable": true, "bSearchable": true, "sWidth": "110px" },
	                                 <c:if test="${jc.manageDivision == true}">
	                                 { "bSortable": false, "bSearchable": true},
	                                 </c:if>
	                                 { "bSortable": false, "bSearchable": false},
	                                 { "bSortable": false, "bSearchable": false},
	                                 { "bSortable": false, "bSearchable": false, "sWidth": "80px" },
                                 ],
                    "fnServerParams": function (aoData) {
                        //aoData.push({name: "firstDivision", value: $('#firstDivision').val()});
                    },
                }
            });
            $('.select2-container').addClass("marginRight30"); // modify table per page dropdown
    };
    
    var handleRecordsMember = function(ajaxRequestUrl, pageType, member) {
        var grid = new Datatable(ajaxRequestUrl, pageType, member);

            grid.init({
                src: $("#" + pageType + "reviewerTable2"),
                onSuccess: function(grid) {
                    // execute some code after table records loaded
                },
                onError: function(grid) {
                    // execute some code on network or other general error  
                },
                dataTable: {  // here you can define a typical datatable settings from http://datatables.net/usage/options 
                   	"sDom": "<'row form-section_noborder_table'<'col-md-6 col-sm-12'lp><'col-md-6 col-sm-12'f>>rt",
                   	"sPaginationType": "bootstrap_extended",
                 	"oSearch": {
        				"sSearch": "",
        				"bSmart" : true,
        				"bCaseInsensitive" : true
        			},
                    "sFilter": true,
                    "bFilter": true,
                    "bInfo": true,
                    "bAutoWidth": false,
                    "aLengthMenu": [
                        [10, 20, 50, 100],	  
                        [10, 20, 50, 100] 
                    ],
                    "bDeferRender": true,
                    "iDisplayStart": 0,
                    "iDisplayLength": 10, 
                    "bProcessing": true,
                    "bPaginate": true,
                    "bServerSide": true, 
                    "sAjaxSource": ajaxRequestUrl, 
                    "aaSorting": [[ 1, "asc" ]], 
                    "aoColumnDefs": [
                                     { "sClass": "cellCenter", "aTargets": [ 0 ] },
                                     { "sClass": "cellCenter", "aTargets": [ 1 ] },
                                     { "sClass": "cellCenter", "aTargets": [ 2 ] },
                                     { "sClass": "cellCenter", "aTargets": [ 3 ] },
                                     { "sClass": "cellCenter", "aTargets": [ 4 ] },
                                     { "sClass": "cellCenter", "aTargets": [ 5 ] },
                                     { "sClass": "cellCenter", "aTargets": [ 6 ] },
                                     ],
                    "aoColumns": [
	                                 { "bSortable": false, "bSearchable": false, "sWidth": "40px" },
	                                 { "bSortable": true, "bSearchable": true, "sWidth": "150px" },
	                                 { "bSortable": true, "bSearchable": true},
	                                 { "bSortable": true, "bSearchable": true},
	                                 { "bSortable": false, "bSearchable": false},
	                                 { "bSortable": false, "bSearchable": false},
	                                 { "bSortable": false, "bSearchable": false, "sWidth": "80px" },
                                 ],
                    "fnServerParams": function (aoData) {
                        aoData.push({name: "jnid", value: $(".jnid").val()});
                    },
                }
            });
            $('.select2-container').addClass("marginRight30"); // modify table per page dropdown
    };
    
    var handleRecordsNonMember = function(ajaxRequestUrl, pageType, member) {
        var grid = new Datatable(ajaxRequestUrl, pageType, member);

            grid.init({
            	src: $("#" + pageType + "reviewerTable3"),
                onSuccess: function(grid) {
                    // execute some code after table records loaded
                },
                onError: function(grid) {
                    // execute some code on network or other general error  
                },
                dataTable: {  // here you can define a typical datatable settings from http://datatables.net/usage/options 
                	"sDom": "<'row form-section_noborder_table'<'col-md-6 col-sm-12'lp><'col-md-6 col-sm-12'f>>rt",
                   	"sPaginationType": "bootstrap_extended",
                 	"oSearch": {
        				"sSearch": "",
        				"bSmart" : true,
        				"bCaseInsensitive" : true
        			},
                    "sFilter": true,
                    "bFilter": true,
                    "bInfo": true,
                    "bAutoWidth": false,
                    "aLengthMenu": [
                        [10, 20, 50, 100],	  
                        [10, 20, 50, 100] 
                    ],
                    "bDeferRender": true,
                    "iDisplayStart": 0,
                    "iDisplayLength": 10, 
                    "bProcessing": true,
                    "bPaginate": true,
                    "bServerSide": true, 
                    "sAjaxSource": ajaxRequestUrl, 
                    "aaSorting": [[ 1, "asc" ]], 
                    "aoColumnDefs": [
                                     { "sClass": "cellCenter", "aTargets": [ 0 ] },
                                     { "sClass": "cellCenter", "aTargets": [ 1 ] },
                                     { "sClass": "cellCenter", "aTargets": [ 2 ] },
                                     { "sClass": "cellCenter", "aTargets": [ 3 ] },
                                     { "sClass": "cellCenter", "aTargets": [ 4 ] },
                                     { "sClass": "cellCenter", "aTargets": [ 5 ] },
                                     { "sClass": "cellCenter", "aTargets": [ 6 ] },
                                     ],
                    "aoColumns": [
	                                 { "bSortable": false, "bSearchable": false, "sWidth": "40px" },
	                                 { "bSortable": true, "bSearchable": true, "sWidth": "150px" },
	                                 { "bSortable": true, "bSearchable": true},
	                                 { "bSortable": true, "bSearchable": true},
	                                 { "bSortable": false, "bSearchable": false},
	                                 { "bSortable": false, "bSearchable": false},
	                                 { "bSortable": false, "bSearchable": false, "sWidth": "80px" },
                                 ],
                    "fnServerParams": function (aoData) {
                        aoData.push({name: "jnid", value: $("#jnid").val()});
                    },
                }
            });
            $('.select2-container').addClass("marginRight30"); // modify table per page dropdown
    };
    
    var handleRecordsRp = function(ajaxRequestUrl, pageType, member) {
        var grid = new Datatable(ajaxRequestUrl, pageType, member);

            grid.init({
            	src: $("#" + pageType + "reviewerTable4"),
                onSuccess: function(grid) {
                    // execute some code after table records loaded
                },
                onError: function(grid) {
                    // execute some code on network or other general error  
                },
                dataTable: {  // here you can define a typical datatable settings from http://datatables.net/usage/options 
                	"sDom": "<'row form-section_noborder_table'<'col-md-6 col-sm-12'lp><'col-md-6 col-sm-12'f>>rt",
                   	"sPaginationType": "bootstrap_extended",
                 	"oSearch": {
        				"sSearch": "",
        				"bSmart" : true,
        				"bCaseInsensitive" : true
        			},
                    "sFilter": true,
                    "bFilter": true,
                    "bInfo": true,
                    "bAutoWidth": false,
                    "aLengthMenu": [
                        [10, 20, 50, 100],	  
                        [10, 20, 50, 100] 
                    ],
                    "bDeferRender": true,
                    "iDisplayStart": 0,
                    "iDisplayLength": 10, 
                    "bProcessing": true,
                    "bPaginate": true,
                    "bServerSide": true, 
                    "sAjaxSource": ajaxRequestUrl, 
                    "aaSorting": [[ 1, "asc" ]], 
                    "aoColumnDefs": [
                                     { "sClass": "cellCenter", "aTargets": [ 0 ] },
                                     { "sClass": "cellCenter", "aTargets": [ 1 ] },
                                     { "sClass": "cellCenter", "aTargets": [ 2 ] },
                                     { "sClass": "cellCenter", "aTargets": [ 3 ] },
                                     { "sClass": "cellCenter", "aTargets": [ 4 ] },
                                     { "sClass": "cellCenter", "aTargets": [ 5 ] },
                                     { "sClass": "cellCenter", "aTargets": [ 6 ] },
                                     ],
                    "aoColumns": [
	                                 { "bSortable": false, "bSearchable": false, "sWidth": "40px" },
	                                 { "bSortable": false, "bSearchable": true, "sWidth": "150px" },
	                                 { "bSortable": false, "bSearchable": true},
	                                 { "bSortable": false, "bSearchable": true},
	                                 { "bSortable": false, "bSearchable": false},
	                                 { "bSortable": false, "bSearchable": false},
	                                 { "bSortable": false, "bSearchable": false, "sWidth": "80px" },
                                 ],
                    "fnServerParams": function (aoData) {
                        aoData.push({name: "jnid", value: $("#jnid").val()});
                    },
                }
            });
            $('.select2-container').addClass("marginRight30"); // modify table per page dropdown
    };

    return {
        //main function to initiate the module
        init: function (ajaxRequestUrl, pageType, member) {
        	if(member == 1)
        		handleRecordsBoardMember(ajaxRequestUrl, pageType, member);
        	else if(member == 2)
        		handleRecordsMember(ajaxRequestUrl, pageType, member);
        	else if(member == 3)
        		handleRecordsNonMember(ajaxRequestUrl, pageType, member);
        	else if(member == 4)
        		handleRecordsRp(ajaxRequestUrl, pageType, member);
        }
    };
}();


ReviewerTableAjax.init("${ajaxRequestUrl1}", "${pageType}", 1);
ReviewerTableAjax.init("${ajaxRequestUrl2}", "${pageType}", 2);
ReviewerTableAjax.init("${ajaxRequestUrl3}", "${pageType}", 3);
ReviewerTableAjax.init("${ajaxRequestUrl4}", "${pageType}", 4);

oTable1 = $('#' + "${pageType}" + 'reviewerTable1').dataTable();
oTable2 = $('#' + "${pageType}" + 'reviewerTable2').dataTable();
oTable3 = $('#' + "${pageType}" + 'reviewerTable3').dataTable();
oTable4 = $('#' + "${pageType}" + 'reviewerTable4').dataTable();

jQuery('#' + "${pageType}" + 'reviewerTable1 .dataTables_filter input').addClass("form-control input-medium input-inline");
jQuery('#' + "${pageType}" + 'reviewerTable2 .dataTables_filter input').addClass("form-control input-medium input-inline");
jQuery('#' + "${pageType}" + 'reviewerTable3 .dataTables_filter input').addClass("form-control input-medium input-inline");
jQuery('#' + "${pageType}" + 'reviewerTable4 .dataTables_filter input').addClass("form-control input-medium input-inline");


$(".form-filter1").on("keyup change", function () {
	oTable2.fnFilter( this.value, $(".form-filter1").index(this) );
});

$(".form-filter2").on("keyup change", function () {
	oTable2.fnFilter( this.value, $(".form-filter2").index(this) );
});

$(".form-filter3").on("keyup change", function () {
	oTable3.fnFilter( this.value, $(".form-filter3").index(this) );
});

$(".form-filter4").on("keyup change", function () {
	oTable4.fnFilter( this.value, $(".form-filter4").index(this) );
});

$('.divisionSelect').click(function(event) {
	var value = "";
	$(":checkbox[name='division']:checked").each(function(i, checkedDivision){
		value += checkedDivision.value + ",";
	});
	$('.form-filterDivision').val(value);
	oTable1.fnFilter( value, $(".form-filterDivision").index($(".form-filterDivision")) );
});

$(".form-filterDivision").on("keyup change", function () {
	oTable1.fnFilter( this.value, $(".form-filterDivision").index(this) );
});

$.ajax({
	type: 'GET',
	url: "${baseUrl}/journals/${jnid}/${currentPageRole }/reviewers/${pageType}/reviewerTable",
	data: "manuscriptId=" + "${manuscript.id}", 
	success: function(html) {
		$("#" + "${pageType}" + "reviewersDisplay").html(html).show();
	}
});

$('#' + "${pageType}" + 'confirmButton').click(function(event) {
	var manuscriptId = $(this).attr("data-manuscriptId");
	var commentToChief = $('#' + "${pageType }" + 'commentToChief').val();
	var commentToAuthor = $('#' + "${pageType }" + 'commentToAuthor').val();
	var recommend = $('.aeRecommend').children("option:selected").val();
	var scopeToManager = 0;
	$("#" + "${pageType}" + "scopeToManager:checked").each(function() {
		scopeToManager = Number($(this).val());
	});

	bootbox.confirm("<spring:message code='system.areYouSure' javaScriptEscape='true' />", function(result) {
		if(result == true) {
			var url = "${baseUrl}/journals/${jnid}/${currentPageRole }/manuscripts/confirmManuscript";
			var data = "manuscriptId=" + manuscriptId + "&recommend=" + recommend + "&commentToChief=" 
			+ commentToChief + "&commentToAuthor=" + commentToAuthor + "&scopeToManager=" + scopeToManager;
			$.ajax({
				type:"POST",
				url: url,
				data: data,
				success:function(html){
					location.href="${baseUrl}/journals/${jnid}/${currentPageRole }/manuscripts?pageType=${pageType}";
				}
			});
		}
	});
});

$('#' + "${pageType}" + "registerReviewerButton").click(function(event) {
	event.preventDefault();
	var emailId = "#${pageType}reviewerEmail";
	if($(emailId).val().trim() != '') {
		$.ajax({
			type: 'GET',
			url: 'usernameDuplicateCheck?username=' + $(emailId).val(),
		    type: "POST",  
		    contentType: "application/json; charset=utf-8",  
		    dataType: "json",  
			success: function(result){
				if(result == true) {
					var parameter = $('#' + "${pageType}" + "reviewerRegisterForm").serialize();
					$.ajax({
						type: 'POST',
						url: url + "/${currentPageRole }/reviewers/signupReviewer",
						data: parameter,
						success: function(html){
							$('#' + "${pageType}" + "reviewerRegisterForm").each(function() {
								if(this.className  != "control-label" && this.className != "help-block") {
									this.reset();  
								}
							});
							$.ajax({
								type: 'GET',
								url: url + "/${currentPageRole }/reviewers/${pageType}/reviewerTable",
								data: "manuscriptId=" + "${manuscript.id}", 
								success: function(html){
									$('#' + "${pageType}" + "reviewersDisplay").html(html).show();
									App.scrollTo($('#' + "${pageType}" + 'selectedReviewers tr:last'));
								}
							});
						}
					});
				} else if(result == false)
					bootbox.alert(errorMessages['user.required.emailAlreadyUsed2']);
			}
		});
	} else
		bootbox.alert("<spring:message code='user.required.newUser.email' javaScriptEscape='true' />");
});

$('.reviewerDegreeRadio').click(function() {
	$(".reviewerDegreeDiv").css("color", "#1C853B");
	return true;
});

$('.reviewerSalutationRadio').click(function() {
	$(".reviewerSalutationDiv").css("color", "#1C853B");
	return true;
});

$("#reviewerHistoryDisplay").dialog({
	width: currentWidth * 0.7,
	height: currentHeight * 0.9,
	resizable: true,
	modal:true,
	autoOpen: false,
 	show: {
		effect: "slide",
		duration: 500
	}
});
</script>

