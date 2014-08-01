<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="query_string" value="${requestScope['javax.servlet.forward.query_string']}" />
<!-- BEGIN FOOTER -->
<div class="clearfix"></div>  
<!-- BEGIN COPYRIGHT -->
<div class="copyright2">
	<div class="container">
		<div class="row">
			<div class="col-md-5 col-sm-5">
				<p>
					<span class="margin-right-10"><span id="currentYear"></span> &copy; MANUSCRIPTLINK. All Rights Reserved.</span> 
					<security:authorize ifAllGranted="ROLE_SUPER_MANAGER">
						<a href="#">Privacy Policy</a> | <a href="#">Terms of Service</a>
					</security:authorize>
				</p>
			</div>
			<div class="col-md-6 col-sm-6" style="margin-top:0px;padding-top:0px;">
				<ul class="social-footer">
              		<security:authorize ifAllGranted="ROLE_SUPER_MANAGER">
						<li>
							<a href="superManager/dashboard"><i class="fa fa-unlock"></i> <spring:message code="system.superuser.dashboard"/> </a>
						</li>
						<li>
							<a href="${baseUrl}/promotion"><i class="fa fa-tasks"></i> <spring:message code="system.promotion"/> </a>
						</li>
              		</security:authorize>
              		<!--
								<li>
									<a href="#"><i class="fa fa-comment"></i> <spring:message code="system.feedback"/> </a>
								</li>
								-->
					<security:authorize ifAllGranted="ROLE_SUPER_MANAGER">
						<li>
							<a href="promotion/customerSupport/contactus"><i class="fa fa-envelope-o"></i><span class="footBarRightTexts"><spring:message code="system.contactus"/></span> </a>
						</li>
						<li>&nbsp;&nbsp;</li>

						<li>
							<a href="#"><i class="fa fa-facebook"></i></a>
						</li>
						<li>
							<a href="#"><i class="fa fa-google-plus"></i></a>
						</li>
						<li>
							<a href="#"><i class="fa fa-linkedin"></i></a>
						</li>
						<li>
							<a href="#"><i class="fa fa-twitter"></i></a>
						</li>
					</security:authorize>
					<li>
						<a href="feedbackForm"><i class="fa fa-comments"></i><span class="footBarRightTexts"><spring:message code="system.feedback"/></span> </a>
					</li>
					<li>&nbsp;&nbsp;</li>
		           
				</ul>
			</div>
			<div class="btn-group dropup languageDiv col-md-1 col-sm-1" style="margin-top:0px;padding-top:0px;">
				<button class="btn btn-sm dropdown-toggle fontSize12" type="button" data-toggle="dropdown" style="margin-top:0px;padding-top:0px;background-color: #ffffff">
					<c:if test="${locale == 'en_US' and (param.lang == null || param.lang == 'en_US')}">
						<img alt="" src="assets/img/flags/us.png"/>
						<span class="username">English</span>
					</c:if>
					<c:if test="${locale == 'ko_KR' || param.lang =='ko_KR'}"> 
						<img alt="" src="assets/img/flags/kr.png"/>
						<span class="username">Korean</span>
					</c:if>
					<i class="fa fa-angle-up"></i>
				</button>
				<ul class="dropdown-menu pull-right lang" role="menu">
					<c:choose>
						<c:when test = "${query_string == null}">
							<li class="formLeft"><a href="${request_uri}?lang=en_US"><img alt="English" src="assets/img/flags/us.png"/> English</a></li>
							<!--<li class="formLeft"><a href="#"><img alt="Chinese" src="assets/img/flags/cn.png"/> Chinese</a></li>-->
							<!--<li class="formLeft"><a href="#"><img alt="Japanese" src="assets/img/flags/jp.png"/> Japanese</a></li>-->
							<li class="formLeft"><a href="${request_uri}?lang=ko_KR"><img alt="Korean" src="assets/img/flags/kr.png"/> Korean</a></li>
						</c:when>
						<c:otherwise>
							<c:choose>
								<c:when test = "${fn:contains(query_string, '&lang=')}">
		            				<c:set var="query_string" value="${fn:substringBefore(query_string, '&lang=')}"/>
		            			</c:when>	      
	            				<c:when test = "${fn:contains(query_string, 'lang=')}">
		            				<c:set var="query_string" value="${fn:substringBefore(query_string, 'lang=')}"/>
		           				</c:when>
	           				</c:choose>
	           				<li class="formLeft"><a href="${request_uri}?${query_string}&lang=en_US"><img alt="English" src="assets/img/flags/us.png"/> English</a></li>
							<!--<li class="formLeft"><a href="#"><img alt="Chinese" src="assets/img/flags/cn.png"/> Chinese</a></li>-->
							<!--<li class="formLeft"><a href="#"><img alt="Japanese" src="assets/img/flags/jp.png"/> Japanese</a></li>-->
							<li class="formLeft"><a href="${request_uri}?${query_string}&lang=ko_KR"><img alt="Korean" src="assets/img/flags/kr.png"/> Korean</a></li>
						</c:otherwise>
					</c:choose>
				</ul>
			</div>            
		</div>
	</div>
</div>
<!-- END COPYRIGHT -->

<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!--[if lt IE 9]>
  <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
  <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
<![endif]-->

<!--[if lt IE 9]>
<script src="${baseUrl}/assets/plugins/excanvas.min.js"></script> 
<![endif]-->  
<script src="${baseUrl}/assets/plugins/jquery-1.10.2.min.js" type="text/javascript"></script>
<script src="${baseUrl}/assets/plugins/jquery-migrate-1.2.1.min.js" type="text/javascript"></script>
<script src="${baseUrl}/assets/plugins/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
<script src="${baseUrl}/assets/plugins/jquery-slimscroll/jquery.slimscroll.min.js" type="text/javascript"></script>
<script src="${baseUrl}/assets/plugins/jquery.blockui.min.js" type="text/javascript"></script>
<script src="${baseUrl}/assets/plugins/jquery.cokie.min.js" type="text/javascript"></script>
<script src="${baseUrl}/assets/plugins/uniform/jquery.uniform.min.js" type="text/javascript"></script>
<script src="${baseUrl}/assets/plugins/bootbox/bootbox.min.js" type="text/javascript"></script>
<script src="${baseUrl}/assets/plugins/select2/select2.min.js" type="text/javascript" ></script>
<script src="${baseUrl}/js/roles/jquery-ui.js"></script>
<script src="${baseUrl}/js/homes/corporate/plugins/hover-dropdown.js" type="text/javascript" ></script>
<script src="${baseUrl}/js/homes/corporate/plugins/back-to-top.js" type="text/javascript"></script>    

<script src="${baseUrl}/js/homes/corporate/scripts/app.js"></script>
<script src="${baseUrl}/assets/scripts/core/app.js"></script>
<script src="${baseUrl}/js/homes/corporate/scripts/index.js"></script>
<script src="${baseUrl}/assets/plugins/bootstrap-sessiontimeout/jquery.sessionTimeout.min.js" type="text/javascript"></script>

<script type="text/javascript">
var currentWidth = $(window).width();
var currentHeight = $(window).height();
var date = new Date();
var year = date.getFullYear(); 
$('#currentYear').text(year);

jQuery(document).ready(function() {
  App.init();    
  MetronicApp.init();    
  $.sessionTimeout({
      title: '<spring:message code="system.timeoutTitle"/>',
      message: '<spring:message code="system.timeoutMessage"/>',
      keepAliveUrl: '${baseUrl}/sessionRefresh?username=${user.username}',
      redirUrl: '${baseUrl}/signout',
      logoutUrl: '${baseUrl}/signout',
      warnAfter: 3300000,  //warn after 55 minutes (=3,300,000 ms)
      redirAfter: 3600000, //redirect after 60 minutes (=3,600,000 ms)
  });
  
	$('textarea').live('keyup change', function() {
		var str = $(this).val();
		if (str.length > 10000) {
			$(this).val(str.substr(0, 10000));
			return false;
		} 
	});

  
});
</script>