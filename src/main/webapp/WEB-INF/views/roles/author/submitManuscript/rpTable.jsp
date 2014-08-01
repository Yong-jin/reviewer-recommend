<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/includes/headerForAjax.jsp" %>
<script>
$('.rpDeleteButton').click(function(event){
	event.preventDefault();
	var rpId = $(this).attr("data-rpId");
	var url = "${baseUrl}/journals/${jnid}/author/submitManuscript/deleteRp";
	var postString = "rpId=" + rpId;
	
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
</script>
<c:set var="rpExist" value="false"/>
<c:if test="${not empty rps }">
	<c:forEach var="rp" items="${rps}">
		<c:if test="${rp.revisionCount == manuscript.revisionCount }">
			<c:set var="rpExist" value="true"/>
		</c:if>
	</c:forEach>
</c:if>
<table class="table table-bordered" id="selectedReviewers">
	<thead>
		<tr>
			<th class="cellCenter">
				 <spring:message code="signin.email"/>
			</th>
			<th class="cellCenter">
				 <spring:message code="user.name"/>
			</th>
			<th class="cellCenter">
				 <spring:message code="user.institutionSmallWidth"/>
			</th>
			<c:if test="${manuscript.revisionCount == 0 or jc.changeRp == true }">
				<th class="cellCenter">
					 <spring:message code="system.action"/>
				</th>
			</c:if>
		</tr>
	</thead>
	<c:if test="${rpExist == true }">
		<tbody>
			<c:forEach var="rp" items="${rps}">
				<tr>
					<td class="cellCenter">
					${rp.email}
					</td>
					<td class="cellCenter">
						<c:choose>
							<c:when test="${journal.languageCode ==  'ko'}">
								<c:if test="${fn:trim(rp.localFullName) != '' }">${rp.localFullName }</c:if>
								 <c:if test="${fn:trim(rp.localFullName) == '' }">${rp.firstName } ${rp.lastName }</c:if>
							</c:when>
							<c:otherwise>
								${rp.firstName } ${rp.lastName }
							</c:otherwise>
						</c:choose>
					</td>
					<td class="cellCenter">
						<c:choose>
							<c:when test="${journal.languageCode == 'ko' and fn:trim(rp.localInstitution) != '' }">
								${rp.localInstitution }
							</c:when>
							<c:otherwise>
								${rp.institution }
							</c:otherwise>
						</c:choose>
					</td>
					<c:if test="${manuscript.revisionCount == 0 or jc.changeRp == true }">
						<td class="cellCenter">
							<button type="button" class="btn btn-default btn-xs rpDeleteButton" data-rpId="${rp.id}">
								<spring:message code="system.delete"/>
							</button>
						</td>
					</c:if>
				</tr>
			</c:forEach>
		</tbody>
	</c:if>
	<c:if test="${rpExist == false }">
		<tbody>
			<tr>
				<c:set var="colSpanSize" value="3"/>
				<c:if test="${manuscript.revisionCount == 0 or jc.changeRp == true }">
					<c:set var="colSpanSize" value="4"/>
				</c:if>
				
				<td colspan="${colSpanSize }" class="cellCenter">
					<spring:message code="system.noDataInTable"/>
				</td>
			</tr>
		</tbody>
	</c:if>
</table>



