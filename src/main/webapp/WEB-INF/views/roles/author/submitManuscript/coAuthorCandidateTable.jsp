<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/includes/headerForAjax.jsp" %>
<link href="${baseUrl}/css/custom.css" rel="stylesheet" type="text/css"/>
<div class="form-inline globalSearchBar">
	<fieldset>
		<div class="input-group input-medium">
			<input class="form-control" id="q" type="text">
			<span class="input-group-btn">
				<a href="#" id="coAuthorSearch" class="btn blue">
					 <spring:message code="system.search"/> <i class="fa fa-search"></i>
				</a>
			</span>
		</div>
	</fieldset>
</div>
<table class="table table-bordered" id="coAuthorCandidates">
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
		<c:when test="${candidateUsers != null}">
			<c:forEach var="user" items="${candidateUsers}">
				<tr>
					<td class="cellCenter">
						<c:set var="originalEmail" value="${fn:split(user.username, '@')}"/>
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
							<c:when test="${journal.languageCode == 'ko' and fn:trim(user.contact.localFullName) != ''}">
								${user.contact.localFullName}
							</c:when>
							<c:otherwise>
								${user.contact.firstName } ${user.contact.lastName } 
							</c:otherwise>
						</c:choose>
					</td>
					<td class="cellCenter">
						<c:choose>
							<c:when test="${journal.languageCode == 'ko' and fn:trim(coAuthor.user.contact.localInstitution) != '' }">
								${user.contact.localInstitution }
							</c:when>
							<c:otherwise>
								${user.contact.institution }
							</c:otherwise>
						</c:choose>
					</td>
					<td class="cellCenter">
					${user.contact.countryCode.name }
					</td>
					<td class="cellCenter">
						<button type="button" class="btn btn-default btn-xs coAuthorSelectButton" data-coAuthorUserId="${user.id}" data-manuscriptId="${manuscript.id}">
							<spring:message code="system.select"/>
						</button>
					</td>
				</tr>
			</c:forEach>
		</c:when>
	</c:choose>
	</tbody>
</table>


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
<script src="${baseUrl}/js/roles/author/coAuthorCandidatesTable-editable.js" type="text/javascript"></script>


<script>
var currentQuery = "${q}";
jQuery(document).ready(function() {       
	TableEditable.init();
   $('#coAuthorSearch').click(function(event) {
		event.preventDefault();
		var query = $('#q').val();
		if(query != null && query != '') {
			var queryString =  "q=" + query;
			$.ajax({
				type: 'GET',
				url: "journals/${jnid}/author/submitManuscript/coAuthorCandidateTable",
				data: queryString,
				success: function(html){
					$("#coAuthorCandidatesDisplay").html(html).show();
				}
			});
		}
	});
   
   $('#q').keydown(function (event){
	    if(event.keyCode == 13){
			var query = $('#q').val();
			if(query != null && query != '') {
				var queryString =  "q=" + query;
				$.ajax({
					type: 'GET',
					url: "journals/${jnid}/author/submitManuscript/coAuthorCandidateTable",
					data: queryString,
					success: function(html){
						$("#coAuthorCandidatesDisplay").html(html).show();
					}
				});
			}
	    }
	})
   
   $('.coAuthorSelectButton').click(function(event){
		event.preventDefault();

		var userId = $(this).attr("data-coAuthorUserId");
		var manuscriptId =  $(this).attr("data-manuscriptId");
		var url = "${baseUrl}/journals/${jnid}/author/submitManuscript/selectCoAuthor";
		var postString = "userId=" + userId + "&manuscriptId=" + manuscriptId;
		
		jQuery.ajax({
			type:"POST",
			url: url,
			data: postString,
			success:function(html){
				$.ajax({
					type: 'GET',
					url: "journals/${jnid}/author/submitManuscript/coAuthorTable",
					success: function(html){
						$("#coAuthorsDisplay").html(html).show();
					}
				});
				$.ajax({
					type: 'GET',
					url: "journals/${jnid}/author/submitManuscript/coAuthorCandidateTable",
					data: "q=" + currentQuery,
					success: function(html){
						$("#coAuthorCandidatesDisplay").html(html).show();
					}
				});
				
			}
		});
	});
});
</script>