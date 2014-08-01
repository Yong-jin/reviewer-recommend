<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/includes/headerForAjax.jsp" %>
<table class="table table-bordered" id="selectedDivisions">
	<thead>
	<tr>
		<th class="cellCenter">
			 <spring:message code="system.symbol"/>
		</th>
		<th class="cellCenter">
			 <spring:message code="system.division"/> <spring:message code="user.name"/>
		</th>
		<th class="cellCenter">
			 <spring:message code="system.description"/>
		</th>
		<th class="cellCenter">
			 <spring:message code="system.action"/>
		</th>
	</tr>
	</thead>
	<tbody>
	<c:choose>
		<c:when test="${not empty divisions}">
			<c:forEach var="dv" items="${divisions}">
				<tr>
					<td class="cellCenter">
					${dv.symbol}
					
					</td>
					<td class="cellCenter">
					${dv.name} 
					</td>
					<td class="cellCenter">
					${dv.description }
					</td>
					<td class="cellCenter">
						<input type="hidden" class="divisionId" name="divisionId" value="${dv.id}"/>
						<button class="btn btn-xs btn-default editButton" data-divisionId="${dv.id }"><spring:message code="system.edit"/></button>
					</td>
				</tr>
			</c:forEach>
		</c:when>
	</c:choose>
	</tbody>
</table>
<script>
var currentWidth = $(window).width();
var currentHeight = $(window).height();
$('.editButton').click(function(event){
	event.preventDefault();
	var divisionId = $(this).attr("data-divisionId");
	$.ajax({
		type:"GET",
			url: "${baseUrl}/journals/${jnid}/manager/configuration/divisions/editDivision",
			data: "divisionId=" + divisionId,
			success: function(html){
				$("#editDivisionDisplay").html(html);
			}
	});	
	$("#editDivisionDisplay").show();
	$("#editDivisionDisplay").dialog("open");
});


$("#editDivisionDisplay").dialog({
	width: currentWidth * 0.6,
	height: currentHeight * 0.7,
	resizable: true,
	modal:true,
	autoOpen: false,
 	show: {
		 effect: "slide",
		 duration: 500
	}
});


</script>