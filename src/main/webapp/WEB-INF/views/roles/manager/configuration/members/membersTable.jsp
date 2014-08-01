<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/includes/headerForAjax.jsp" %>
<script>
$('.memberDeleteButton').click(function(event){
	event.preventDefault();
	var t = $(this);

	var userId = t.attr("data-userId");
	var url = "${baseUrl}/journals/${jnid}/manager/configuration/members/delete${roleStringUpper}";
	var postString = "userId=" + userId;
	
	jQuery.ajax({
		type:"POST",
		url: url,
		data: postString,
		success:function(html){
			$.ajax({
				type: 'GET',
				url: "${baseUrl}/journals/${jnid}/manager/configuration/members/${roleString}Table",
				success: function(html){
					$("#${roleString}Display").html(html).show();
					if("${roleString}" == 'chiefEditor')
						oTable1.fnDraw();
					else if("${roleString}" == 'manager')
						oTable2.fnDraw();
					else if("${roleString}" == 'associateEditor')
						oTable3.fnDraw();
					else if("${roleString}" == 'guestEditor')
						oTable4.fnDraw();
					else if("${roleString}" == 'boardMember')
						oTable5.fnDraw();
				}
			});
		}
	});
});

<c:if test="${jc.manageDivision == true}">
$('.divisionNotAssigned').click(function(event) {
	event.preventDefault();
	var userId = $(this).attr("data-userId");
	var divisionId = $(this).attr("data-divisionId");
	var postString = "userId=" + userId + "&divisionId=" + divisionId + "&roleString=${roleString}";
	$.ajax({
		type: 'POST',
		url: "${baseUrl}/journals/${jnid}/manager/configuration/members/setDivision",
		data: postString,
		success: function(html){
           	$.ajax({
           		type: 'GET',
           		url: "${baseUrl}/journals/${jnid}/manager/configuration/members/${roleString}Table",
           		success: function(html){
           			$("#${roleString}Display").html(html).show();
           		}
           	});
		}
	});
});

$('.divisionAssigned').click(function(event) {
	event.preventDefault();
	var userDivisionId = $(this).attr("data-userDivisionId");
	var postString = "userDivisionId=" + userDivisionId;
	$.ajax({
		type: 'POST',
		url: "${baseUrl}/journals/${jnid}/manager/configuration/members/unSetDivision",
		data: postString,
		success: function(html){
           	$.ajax({
           		type: 'GET',
           		url: "${baseUrl}/journals/${jnid}/manager/configuration/members/${roleString}Table",
           		success: function(html){
           			$("#${roleString}Display").html(html).show();
           		}
           	});
		}
	});

});
</c:if>
$('.specialIssueNotAssigned').click(function(event) {
	event.preventDefault();
	var geUserId = $(this).attr("data-geUserId");
	var specialIssueId = $(this).attr("data-specialIssueId");
	var postString = "geUserId=" + geUserId + "&specialIssueId=" + specialIssueId;
	$.ajax({
		type: 'POST',
		url: "${baseUrl}/journals/${jnid}/manager/configuration/members/setSpecialIssue",
		data: postString,
		success: function(html){
           	$.ajax({
           		type: 'GET',
           		url: "${baseUrl}/journals/${jnid}/manager/configuration/members/guestEditorTable",
           		success: function(html){
           			$("#guestEditorDisplay").html(html).show();
           		}
           	});
		}
	});
});

$('.specialIssueAssigned').click(function(event) {
	event.preventDefault();
	var geSpecialIssueId = $(this).attr("data-geSpecialIssueId");
	var specialIssueId = $(this).attr("data-specialIssueId");
	var postString = "geSpecialIssueId=" + geSpecialIssueId + "&specialIssueId=" + specialIssueId;
	$.ajax({
		type: 'POST',
		url: "${baseUrl}/journals/${jnid}/manager/configuration/members/unSetSpecialIssue",
		data: postString,
		success: function(html){
           	$.ajax({
           		type: 'GET',
           		url: "${baseUrl}/journals/${jnid}/manager/configuration/members/guestEditorTable",
           		success: function(html){
           			$("#guestEditorDisplay").html(html).show();
           		}
           	});
		}
	});
});
</script>
<c:choose>
	<c:when test="${not empty members}">
		<table class="table table-bordered" id="selected${roleStringUpper}s">
			<thead>
			<tr>
				<c:if test="${(roleString == 'associateEditor' or roleString == 'boardMember') and not empty divisions }">
					<th class="cellCenter">
						 <spring:message code='system.division'/>
					</th>
				</c:if>
				<c:if test="${roleString == 'guestEditor' and not empty specialIssues }">
					<th class="cellCenter">
						 <spring:message code='author.newPaperSubmit.specialIssue'/>
					</th>
				</c:if>
				<th class="cellCenter">
					 <spring:message code='signin.username'/> (<spring:message code='user.username'/>)
				</th>
				<th class="cellCenter">
					 <spring:message code='user.name'/>
				</th>
				<th class="cellCenter">
					 <spring:message code='user.institutionSmallWidth'/>
				</th>
				<th class="cellCenter">
					 <spring:message code='system.action'/>
				</th>
			</tr>
			</thead>
			<tbody>
				<c:forEach var="member" items="${members}">
					<tr>
						<c:if test="${(roleString == 'associateEditor' or roleString == 'boardMember') and jc.manageDivision == true and not empty divisions }">
							<td class="cellCenter">
								<div class="btn-group">
									<button type="button" class="btn btn-xs btn-default">
										<c:choose>
											<c:when test="${not empty member.userDivisions}">
	
												<c:forEach var="ud" varStatus="status" items="${member.userDivisions}">
													${ud.division.symbol}
													<c:if test="${!status.last}">
														,&nbsp;
													</c:if>
												</c:forEach>
											</c:when>
											<c:otherwise>    
												<spring:message code='system.notAvailable2'/>
											</c:otherwise>
										</c:choose>
									</button>
									<button type="button" class="btn btn-xs btn-default dropdown-toggle" data-toggle="dropdown"><i class="fa fa-angle-down"></i></button>
									<ul class="dropdown-menu divisionDropdownMenu" role="menu">
	
										<c:forEach var="division" items="${divisions}">
											<c:set var="found" value="false"/>
											<c:forEach var="ud" items="${member.userDivisions}">
												<c:if test="${ud.journalId == journal.id}">
													<c:choose>
														<c:when test="${division.id == ud.divisionId}">
															<li class="divisionDropdown">
																<a href="#" class="btn blue divisionAssigned" style="padding-right: 10px; padding-top: 13px" data-userId="${member.userId}"  data-userDivisionId="${ud.id}">
																	 <p style="text-align:left"><i class="fa fa-angle-down"></i> ${division.symbol}. ${division.name}</p>
																</a>
															</li>
															<c:set var="found" value="true"/>
														</c:when>
													</c:choose>
												</c:if>
	
											</c:forEach>
											<c:if test="${found == 'false'}">
												<li class="divisionDropdown">
													<a href="#" class="btn divisionNotAssigned" style="padding-right: 10px; padding-top: 13px" data-userId="${member.userId}"  data-divisionId="${division.id}">
														<p style="text-align:left">${division.symbol}. ${division.name}</p>
													</a>
												</li>
											</c:if>
	
										</c:forEach>
									</ul>
								</div>
	
							</td>
						</c:if>
						<c:if test="${roleString == 'guestEditor' and not empty specialIssues }">
							<td class="cellCenter">
								<div class="btn-group">
									<button type="button" class="btn btn-xs btn-default">
										<c:choose>
											<c:when test="${not empty member.geSpecialIssues}">
	
												<c:forEach var="gs" varStatus="status" items="${member.geSpecialIssues}">
													${gs.specialIssue.title}
													<c:if test="${!status.last}">
														,&nbsp;
													</c:if>
												</c:forEach>
	
											</c:when>
											<c:otherwise>    
												<spring:message code='system.notAvailable2'/>
											</c:otherwise>
										</c:choose>
									</button>
									<button type="button" class="btn btn-xs btn-default dropdown-toggle" data-toggle="dropdown"><i class="fa fa-angle-down"></i></button>
									<ul class="dropdown-menu specialIssueDropdownMenu" role="menu">
										<c:forEach var="specialIssue" items="${specialIssues}">
											<c:set var="found" value="false"/>
											<c:forEach var="gs" items="${member.geSpecialIssues}">
												<c:if test="${gs.journalId == journal.id}">
													<c:choose>
														<c:when test="${specialIssue.id == gs.specialIssueId}">
															<li class="specialIssueDropdown">
																<a href="#" class="btn blue specialIssueAssigned" style="padding-right: 10px; padding-top: 13px" data-geUserId="${member.userId}"  data-specialIssueId="${specialIssue.id}" data-geSpecialIssueId="${gs.id}">
																	 <p style="text-align:left"><i class="fa fa-angle-down"></i> ${specialIssue.title }</p>
																</a>
															</li>
															<c:set var="found" value="true"/>
														</c:when>
													</c:choose>
												</c:if>
											</c:forEach>
											<c:if test="${found == 'false'}">
												<li class="specialIssueDropdown">
													<a href="#" class="btn specialIssueNotAssigned" style="padding-right: 10px; padding-top: 13px" data-geUserId="${member.userId}"  data-specialIssueId="${specialIssue.id}">
														<p style="text-align:left">${specialIssue.title}</p>
													</a>
												</li>
											</c:if>
										</c:forEach>
									</ul>
								</div>
							</td>
						</c:if>
						<td class="cellCenter">
						${member.user.username}
						</td>
						<td class="cellCenter">
							<c:choose>
								<c:when test="${journal.languageCode ==  'ko' and fn:trim(member.user.contact.localFullName) != ''}">
									${member.user.contact.localFullName } 
								</c:when>
								<c:otherwise>
									${member.user.contact.firstName } ${member.user.contact.lastName }
								</c:otherwise>
							</c:choose>
						</td>
						<td class="cellCenter">
							<c:choose>
								<c:when test="${journal.languageCode == 'ko' and fn:trim(member.user.contact.localInstitution) != '' }">
									${member.user.contact.localInstitution }
								</c:when>
								<c:otherwise>
									${member.user.contact.institution }
								</c:otherwise>
							</c:choose>
						</td>
						<td class="cellCenter">
							<button type="button" class="btn btn-default btn-xs memberDeleteButton" data-userId="${member.user.id}">
								<spring:message code='system.delete'/>
							</button>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</c:when>
	<c:otherwise>
		<spring:message code="system.notAvailable"/></div>
	</c:otherwise>
</c:choose>