<%@ tag body-content="empty" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ attribute name="link_1" %>
<%@ attribute name="label_1" %>
<%@ attribute name="link_2" %>
<%@ attribute name="label_2" %>
<%@ attribute name="link_3" %>
<%@ attribute name="label_3" %>
<ul class="page-breadcrumb breadcrumb">
	<li>
		<i class="fa fa-home"></i>
		<a href="${link_1}?lang=${pageContext.response.locale}"><spring:message code="${label_1}"/></a>
	</li>
	<li>
		<a href="${link_2}"><spring:message code="${label_2}"/></a>
	</li>
	<li>
		<a href="${link_3}"><spring:message code="${label_3}"/></a>
	</li>
</ul>