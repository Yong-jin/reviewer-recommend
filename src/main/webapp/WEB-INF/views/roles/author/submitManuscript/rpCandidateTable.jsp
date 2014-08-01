<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/includes/headerForAjax.jsp" %>
<div class="form-inline globalSearchBar">
	<fieldset>
		<div class="input-group input-medium">
			<input class="form-control" id="q" type="text">
			<span class="input-group-btn">
				<a href="#" id="reviewerSearch" class="btn blue">
					 <spring:message code="system.search"/> <i class="fa fa-search"></i>
				</a>
			</span>
		</div>

	</fieldset>
</div>
<table class="table table-bordered" id="candidateReviewers">
<thead>
<tr>
	<th>
		 <spring:message code="signin.email"/>
	</th>
	<th>
		 <spring:message code="user.name"/>
	</th>
	<th>
		 <spring:message code="user.institutionSmallWidth"/>
	</th>
	<th>
		 <spring:message code="user.country"/>
	</th>
	<th>
		 <spring:message code="system.action"/>
	</th>
</tr>
</thead>
<tbody>
<c:choose>
	<c:when test="${not empty candidateRps}">
		<c:forEach var="rpCandidate" items="${candidateRps}">
			<tr>
				<td>
					<c:set var="originalEmail" value="${fn:split(rpCandidate.username, '@')}"/>
					<c:set var="prevEmail" value="${originalEmail[0] }"/>
					<c:set var="showingEmail" value="prevEmail"/>
					<c:choose>
						<c:when test="${fn:length(prevEmail) > 2 }">
						 	<c:set var="showingEmail" value="${fn:substring(prevEmail, 0, fn:length(prevEmail) - 2)}"/>
					 		<c:set var="showingEmail" value="${showingEmail }**@${originalEmail[1]}"/>
					 	</c:when>
					 	<c:otherwise>
					 		<c:set var="showingEmail" value="${prevEmail }@${originalEmail[1]}"/>
					 	</c:otherwise>
					 </c:choose>
					 
					 ${showingEmail}
				</td>
				<td class="cellCenter">
					<c:choose>
						<c:when test="${journal.languageCode == 'ko' and fn:trim(rpCandidate.contact.localFullName) != ''}">
							${rpCandidate.contact.localFullName}
						</c:when>
						<c:otherwise>
							${rpCandidate.contact.firstName } ${rpCandidate.contact.lastName } 
						</c:otherwise>
					</c:choose>
				</td>
				<td>
					<c:choose>
						<c:when test="${journal.languageCode == 'ko' and fn:trim(rpCandidate.contact.localInstitution) != '' }">
							${rpCandidate.contact.localInstitution }
						</c:when>
						<c:otherwise>
							${rpCandidate.contact.institution }
						</c:otherwise>
					</c:choose>
				</td>
				<td>
				${rpCandidate.contact.countryCode.name }
				</td>
				<td>
					<button type="button" class="btn btn-default btn-xs rpSelectButton" data-rpUserId="${rpCandidate.id}">
						<spring:message code="system.select"/>
					</button>
				</td>
			</tr>
		</c:forEach>
	</c:when>
</c:choose>
</tbody>
</table>
<br/><br/>


<script src="${baseUrl}/assets/plugins/jquery-validation/dist/jquery.validate.min.js" type="text/javascript" ></script>
<script src="${baseUrl}/assets/plugins/jquery-validation/dist/additional-methods.min.js" type="text/javascript" ></script>
<script src="${baseUrl}/assets/plugins/bootstrap-wizard/jquery.bootstrap.wizard.min.js" type="text/javascript" ></script>

<script src="${baseUrl}/assets/plugins/bootstrap-switch/js/bootstrap-switch.min.js" type="text/javascript"></script>
<script src="${baseUrl}/assets/plugins/bootstrap-maxlength/bootstrap-maxlength.min.js" type="text/javascript"></script>
<script src="${baseUrl}/assets/plugins/bootstrap-touchspin/bootstrap.touchspin.js" type="text/javascript"></script>
<script src="${baseUrl}/assets/plugins/typeahead/handlebars.min.js" type="text/javascript"></script>
<script src="${baseUrl}/assets/plugins/typeahead/typeahead.min.js" type="text/javascript"></script>

<script src="${baseUrl}/assets/plugins/select2/select2.min.js" type="text/javascript"></script>
<script src="${baseUrl}/js/roles/author/candidate_jquery.dataTables.js" type="text/javascript"></script>
<script src="${baseUrl}/js/roles/author/candidate_DT_bootstrap.js" type="text/javascript"></script>
<script src="${baseUrl}/assets/plugins/jquery-validation/dist/additional-methods.min.js" type="text/javascript"></script>


<script src="${baseUrl}/assets/scripts/core/app.js"></script>
<script src="${baseUrl}/js/roles/author/rpCandidatesTable-editable.js"></script>
<script>
var currentQuery = "${q}";
jQuery(document).ready(function() {       
	App.init();
	TableEditable.init();   
	$('#reviewerSearch').click(function(event) {
		event.preventDefault();
		var query = $('#q').val();
		if(query != null && query != '') {
			var queryString =  "q=" + query;
			$.ajax({
				type: 'GET',
				url: "${baseUrl}/journals/${jnid}/author/submitManuscript/rpCandidateTable",
				data: queryString,
				success: function(html){
					$("#rpCandidateDisplay").html(html).show();
				}
			});
		}
	});
	
	$('#q').keydown(function (event){
		if(event.keyCode == 13) {
			var query = $('#q').val();
			if(query != null && query != '') {
				var queryString =  "q=" + query;
				$.ajax({
					type: 'GET',
					url: "${baseUrl}/journals/${jnid}/author/submitManuscript/rpCandidateTable",
					data: queryString,
					success: function(html){
						$("#rpCandidateDisplay").html(html).show();
					}
				});
			}
		}
	});

	$('.rpSelectButton').click(function(event){
		event.preventDefault();
		var rpUserId = $(this).attr("data-rpUserId");
		var url = "${baseUrl}/journals/${jnid}/author/submitManuscript/selectRp";
		var postString = "rpUserId=" + rpUserId;
		
		jQuery.ajax({
			type:"POST",
			url: url,
			data: postString,
			success:function(html){
				$.ajax({
					type: 'GET',
					url: "${baseUrl}/journals/${jnid}/author/submitManuscript/rpTable",
					success: function(html){
						$("#rpDisplay").html(html).show();
					}
				});
				
				$.ajax({
					type: 'GET',
					url: "${baseUrl}/journals/${jnid}/author/submitManuscript/rpCandidateTable",
					data: "q=" + currentQuery,
					success: function(html){
						$("#rpCandidateDisplay").html(html).show();
					}
				});
			}

		});

	});
});
</script>