<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/includes/headerForAjax.jsp" %>
<script>
$('.coAuthorDeleteButton').click(function(event){
	event.preventDefault();
	var userId = $(this).attr("data-coAuthorUserId");
	var manuscriptId =  $(this).attr("data-manuscriptId");
	var url = "${baseUrl}/journals/${jnid}/author/submitManuscript/deleteCoAuthor";
	var postString = "userId=" + userId + "&manuscriptId=" + manuscriptId;
	$.ajax({
		type:"POST",
		url: url,
		data: postString,
		success:function(html){
			$.ajax({
				type: 'GET',
				url: "${baseUrl}/journals/${jnid}/author/submitManuscript/coAuthorTable",
				success: function(html){
					$("#coAuthorsDisplay").html(html).show();
				}
			});
			$.ajax({
				type: 'GET',
				url: "${baseUrl}/journals/${jnid}/author/submitManuscript/coAuthorCandidateTable",
				data: "q=" + currentQuery,
				success: function(html){
					$("#coAuthorCandidatesDisplay").html(html).show();
				}
			});
			
			
		}
	});
});

$(".correspondingRadio").click(function(event) {
    var selectedOrder = $(this).children("option:selected").text();
    var selectedCoAuthorUserId = $(this).children("option:selected").attr("data-coAuthorUserId");
    var coAuthors = $('.coAuthorName');
	var i = 0;
	var j = 0;
	var coAuthorValidation = true;
	var totalSelectors = $(".authorOrderSelector");
	var selectors = $(".authorOrderSelector > option:selected");
	var originallySelectedIndex = -1;
	var options;
	
	var corres = $('.correspondingRadio');
	var corresIndex = -1;
	for(i=0; i<corres.length; i++) {
		if(corres[i].checked) {
			corresIndex = i;
			break;
		}
	}
	
	if(corresIndex == -1)
		coAuthorValidation = false;
	
	if(coAuthorValidation) {
		var url = "${baseUrl}/journals/${jnid}/author/submitManuscript/setAuthorOrder";
		var postString = "manuscriptId=${manuscript.id}&";
		for(i=0; i<selectors.length; i++) {
			var authorOrder = selectors[i].value;
			postString += "user_" + coAuthors[i].value + "=" + authorOrder + "&";
		}
		
		postString += "corresponding=" + coAuthors[corresIndex].value;
		
		$.ajax({
			type:"POST",
			url: url,
			data: postString,
			success:function(html){
				$.ajax({
					type: 'GET',
					url: "${baseUrl}/journals/${jnid}/author/submitManuscript/coAuthorTable",
					success: function(html2) {
						$("#coAuthorsDisplay").html(html2).show();
					}
				});
			}
		});
	} else 
		bootbox.alert("Invalid Author Order Or Corresponding Author");
});

$(".authorOrderSelector").change(function(event) {
    var selectedOrder = $(this).children("option:selected").text();
    var selectedCoAuthorUserId = $(this).children("option:selected").attr("data-coAuthorUserId");
    var coAuthors = $('.coAuthorName');
	var i = 0;
	var j = 0;
	var validOrderValues = [];
	var orderValues = [];
	var coAuthorValidation = true;
	var needToSwitchIndex = -1;
	var selectedIndex = -1;
	var totalSelectors = $(".authorOrderSelector");
	var selectors = $(".authorOrderSelector > option:selected");
	var originallySelectedIndex = -1;
	var options;
	
	for(i=0; i<coAuthors.length; i++)
		if(Number(coAuthors[i].value) == Number(selectedCoAuthorUserId))
			selectedIndex = i;
	
	for(i=0; i<selectors.length; i++) {
		validOrderValues[i] = i + 1;
		orderValues[i] = selectors[i].value;
		if(selectors[i].value == selectedOrder && i != selectedIndex)
			needToSwitchIndex = i;
	}

		
	if(selectedIndex < needToSwitchIndex) {
		//2, 0
		for(i=selectedIndex+1; i<=needToSwitchIndex; i++) {	// 1, 2
			options = totalSelectors[i].options;
			for(j=0; j<options.length; j++) {
				if(options[j].selected) {
					options[j].selected = false;
					originallySelectedIndex = j;
				}
			}
			for(j=0; j<options.length; j++) {
				if(j == originallySelectedIndex - 1) {
					options[j].selected = true;
				}
			}
		}
	
	} else {
		for(i=needToSwitchIndex; i<selectedIndex; i++) {
			options = totalSelectors[i].options;
			for(j=0; j<options.length; j++) {
				if(options[j].selected) {
					options[j].selected = false;
					originallySelectedIndex = j;
				}
			}
			for(j=0; j<options.length; j++) {
				if(j == originallySelectedIndex + 1)
					options[j].selected = true;
			}
		}
	}

	selectors = $(".authorOrderSelector > option:selected");
	// Corresponding Author Check
	var corres = $('.correspondingRadio');
	var corresIndex = -1;
	for(i=0; i<corres.length; i++) {
		if(corres[i].checked) {
			corresIndex = i;
			break;
		}
	}
	
	if(corresIndex == -1)
		coAuthorValidation = false;
	
 	if(coAuthorValidation) {
		var url = "${baseUrl}/journals/${jnid}/author/submitManuscript/setAuthorOrder";
		var postString = "manuscriptId=${manuscript.id}&";
		for(i=0; i<selectors.length; i++) {
			var authorOrder = selectors[i].value;
			postString += "user_" + coAuthors[i].value + "=" + authorOrder + "&";
		}
		
		postString += "corresponding=" + coAuthors[corresIndex].value;
		
		$.ajax({
			type:"POST",
			url: url,
			data: postString,
			success:function(html){
				$.ajax({
					type: 'GET',
					url: "${baseUrl}/journals/${jnid}/author/submitManuscript/coAuthorTable",
					success: function(html2) {
						$("#coAuthorsDisplay").html(html2).show();
					}
				});
			}
		}); 
	} else 
		bootbox.alert("Invalid Author Order");
});

</script>
<table class="table table-bordered" id="selectedCoAuthors">
	<thead>
	<tr>
		<th class="cellCenter">
			 <spring:message code="signin.email"/>
		</th>
		<th class="cellCenter">
			 <spring:message code='user.name'/>
		</th>
		<th class="cellCenter">
			 <spring:message code="user.institutionSmallWidth"/>
		</th>
		<th class="cellCenter">
			 <spring:message code="manuscript.authorsOrder"/>
		</th>
		<th class="cellCenter">
			 <spring:message code="manuscript.correspondingAuthor"/>
		</th>
		<c:if test="${manuscript.revisionCount == 0 or jc.changeAuthor == true }">
			<th class="cellCenter">
				 <spring:message code="system.action"/>
			</th>
		</c:if>
	</tr>
	</thead>
	<tbody>
	<c:choose>
		<c:when test="${not empty coAuthors}">
			<c:forEach var="coAuthor" items="${coAuthors}">
				<tr>
					<td class="cellCenter">
					${coAuthor.user.username}
					<input type="hidden" class="coAuthorName" name="coAuthorUserId" value="${coAuthor.userId}"/>
					</td>
					<td class="cellCenter">
						<c:choose>
							<c:when test="${journal.languageCode ==  'ko' and fn:trim(coAuthor.user.contact.localFullName) != ''}">
								${coAuthor.user.contact.localFullName }
							</c:when>
							<c:otherwise>
								${coAuthor.user.contact.firstName } ${coAuthor.user.contact.lastName }
							</c:otherwise>
						</c:choose>
					</td>
					<td class="cellCenter">
						<c:choose>
							<c:when test="${journal.languageCode == 'ko' and fn:trim(coAuthor.user.contact.localInstitution) != '' }">
								${coAuthor.user.contact.localInstitution }
							</c:when>
							<c:otherwise>
								${coAuthor.user.contact.institution }
							</c:otherwise>
						</c:choose>
					</td>
					<td class="cellCenter">
						<c:choose>
							<c:when test="${manuscript.revisionCount == 0 or jc.changeAuthor == true }">
								<select name="authorOrderSelect" id="authorOrderSelect" class="authorOrderSelector select2 form-control option-xxsmall">
									<c:forEach var="coAuthorUser" varStatus="varStatus" items="${coAuthors}">
										<option class="authorOrder" data-coAuthorUserId="${coAuthor.userId }" <c:if test="${coAuthor.userId == coAuthorUser.userId and coAuthorUser.authorOrder == varStatus.count }">selected</c:if>>${varStatus.count }</option>
									</c:forEach>
								</select>
							</c:when>
							<c:otherwise>
								${coAuthor.authorOrder }
							</c:otherwise>
						</c:choose>
						
					</td>
					<td class="cellCenter correspondingAuthor">
						<c:choose>
							<c:when test="${manuscript.revisionCount == 0 or jc.changeAuthor == true }">
								<c:if test="${coAuthor.corresponding == true}">
									<input type="radio" class="correspondingRadio" name="optionsRadios" id="optionsRadios1" value="corresponding" checked>
								</c:if>
								<c:if test="${coAuthor.corresponding == false}">
									<input type="radio" class="correspondingRadio" name="optionsRadios" id="optionsRadios1" value="corresponding">
								</c:if>
							</c:when>
							<c:otherwise>
								<c:if test="${coAuthor.corresponding == true}">
									<span class="required">*</span>
								</c:if>
							</c:otherwise>
						</c:choose>
					</td>
					<c:if test="${manuscript.revisionCount == 0 or jc.changeAuthor == true }">
						<td class="cellCenter">
							<c:if test="${manuscript.userId != coAuthor.userId }">
								<button type="button" class="btn btn-default btn-xs coAuthorDeleteButton" data-coAuthorUserId="${coAuthor.userId}" data-manuscriptId="${manuscript.id}">
									<spring:message code="system.delete"/>
								</button>
							</c:if>
						</td>
					</c:if>
				</tr>
			</c:forEach>
		</c:when>
	</c:choose>
	</tbody>
</table>
