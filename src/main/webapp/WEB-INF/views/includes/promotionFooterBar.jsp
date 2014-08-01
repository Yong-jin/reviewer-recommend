<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="query_string" value="${requestScope['javax.servlet.forward.query_string']}" />
<!-- BEGIN FOOTER -->
<div class="clearfix"></div>  
<div class="footer">
    <div class="container">
        <div class="row">
            <div class="col-md-4 col-sm-4 space-mobile">
                <!-- BEGIN ABOUT -->                    
                <h2>About</h2>
                <p class="margin-bottom-10">
                	<spring:message code="home.aboutus.description"/><br/>
                	<a href="${baseUrl}/promotion"><button type="button" class="btn green btn-xs">Go to promotion page</button></a>
                </p>
                    
                <!-- END ABOUT -->          
            </div>
            <div class="col-md-4 col-sm-4 space-mobile">
                <!-- BEGIN CONTACTS -->                                    
                <h2>Contact Us</h2>
                <address class="margin-bottom-10">
                    <spring:message code="home.address"/><br/>
                    Email: <a href="mailto:cmdrkim@gmail.com">cmdrkim@gmail.com</a>                        
                </address>
                <!-- END CONTACTS -->
            </div>
            <div class="col-md-4 col-sm-4">
                <!-- BEGIN TWITTER BLOCK -->                                                    
                <h2>Feedback?</h2>
                <p class="margin-bottom-10">
                	<spring:message code="home.feedback.desc"/><br/>
                	<a href="#"><button type="button" class="btn green btn-xs">Go to feedback page</button></a>
                </p>
                <!-- END TWITTER BLOCK -->                                                                        
            </div>
        </div>
    </div>
</div>
<!-- END FOOTER -->

<!-- BEGIN COPYRIGHT -->
<div class="copyright2">
    <div class="container">
        <div class="row">
            <div class="col-md-6 col-sm-6">
                <p>
                    <span class="margin-right-10">2014 &copy; MANUSCRIPTLINK. All Rights Reserved.</span> 
                    <a href="#">Privacy Policy</a> | <a href="#">Terms of Service</a>
                </p>
            </div>
            <div class="col-md-5 col-sm-5">
              <ul class="social-footer">
                <li><a href="#"><i class="fa fa-facebook"></i></a></li>
                <li><a href="#"><i class="fa fa-google-plus"></i></a></li>
                <li><a href="#"><i class="fa fa-linkedin"></i></a></li>
                <li><a href="#"><i class="fa fa-twitter"></i></a></li>
              </ul>                
            </div>
            <div class="col-md-1 col-sm-1 pull-right languageDiv">
            	<div class="btn-group dropup" style="margin-top:0px;padding-top:0px;">
								<button class="btn btn-sm dropdown-toggle language" type="button" data-toggle="dropdown" style="margin-top:0px;padding-top:0px;">
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
									<li class="formLeft"><a href="#"><img alt="Chinese" src="assets/img/flags/cn.png"/> Chinese</a></li>
									<li class="formLeft"><a href="#"><img alt="Japanese" src="assets/img/flags/jp.png"/> Japanese</a></li>
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
									<li class="formLeft"><a href="#"><img alt="Chinese" src="assets/img/flags/cn.png"/> Chinese</a></li>
									<li class="formLeft"><a href="#"><img alt="Japanese" src="assets/img/flags/jp.png"/> Japanese</a></li>
									<li class="formLeft"><a href="${request_uri}?${query_string}&lang=ko_KR"><img alt="Korean" src="assets/img/flags/kr.png"/> Korean</a></li>
								</c:otherwise>
								</c:choose>
							</ul>
							</div>
            </div>
        </div>
    </div>
</div>
<!-- END COPYRIGHT -->
<div class="copyright2">
<div class="container">
<div class="row">


	
</ul>

</div>
</div>
</div>
</div>

<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!--[if lt IE 9]>
  <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
  <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
<![endif]-->

<!-- BEGIN CORE PLUGINS -->
<!--[if lt IE 9]>
<script src="${baseUrl}/assets/plugins/excanvas.min.js"></script> 
<![endif]-->
  
<script src="${baseUrl}/assets/plugins/jquery-1.10.2.min.js" type="text/javascript"></script>
<script src="${baseUrl}/assets/plugins/jquery-migrate-1.2.1.min.js" type="text/javascript"></script>

<script src="${baseUrl}/assets/plugins/jquery-ui/jquery-ui-1.10.3.custom.min.js" type="text/javascript"></script>
<script src="${baseUrl}/assets/plugins/jquery-slimscroll/jquery.slimscroll.min.js" type="text/javascript"></script>
<script src="${baseUrl}/assets/plugins/jquery.blockui.min.js" type="text/javascript"></script>
<script src="${baseUrl}/assets/plugins/jquery.cokie.min.js" type="text/javascript"></script>

<script src="${baseUrl}/assets/plugins/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
<script src="${baseUrl}/assets/plugins/bootstrap-hover-dropdown/bootstrap-hover-dropdown.min.js" type="text/javascript"></script>

<script src="${baseUrl}/assets/plugins/uniform/jquery.uniform.min.js" type="text/javascript"></script>

<script src="${baseUrl}/js/homes/corporate/plugins/hover-dropdown.js" type="text/javascript"></script>
<script src="${baseUrl}/js/homes/corporate/plugins/back-to-top.js" type="text/javascript"></script>    
<!-- END CORE PLUGINS -->

<script src="${baseUrl}/js/homes/corporate/scripts/app.js"></script>

<script type="text/javascript">
jQuery(document).ready(function() {
    App.init();    
});
</script>