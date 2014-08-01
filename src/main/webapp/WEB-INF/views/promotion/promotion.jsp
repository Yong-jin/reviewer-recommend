<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8 no-js"> <![endif]-->
<!--[if IE 9]> <html lang="en" class="ie9 no-js"> <![endif]-->
<!--[if !IE]><!--> <html lang="en"> <!--<![endif]-->

<head>
<title>MANUSCRIPTLINK Promotion</title>
<%@ include file="/WEB-INF/views/includes/header.jsp" %>
<!-- BEGIN PAGE LEVEL PLUGIN STYLES --> 
<link href="${baseUrl}/js/homes/corporate/plugins/fancybox/source/jquery.fancybox.css" rel="stylesheet" />              
<link href="${baseUrl}/js/homes/corporate/plugins/revolution_slider/css/rs-style.css" rel="stylesheet" media="screen">
<link href="${baseUrl}/js/homes/corporate/plugins/revolution_slider/rs-plugin/css/settings.css" rel="stylesheet" media="screen"> 
<link href="${baseUrl}/js/homes/corporate/plugins/bxslider/jquery.bxslider.css" rel="stylesheet" />
<!-- END PAGE LEVEL PLUGIN STYLES -->

<link href="${baseUrl}/css/custom.css" rel="stylesheet" type="text/css"/>
<!-- END THEME STYLES -->
</head>



<body class="page-header-fixed">
<!--[if lt IE 7]>
<div class="page-container">
<div class="col-md-push-4 col-md-5">
	<br/>
	<p class="browsehappy">You are using an <strong>outdated</strong> browser. Please <a href="http://browsehappy.com/">upgrade your browser</a> to improve your experience.</p>
</div>
</div>
<![endif]-->	
<%@ include file="/WEB-INF/views/includes/promotionHeaderBar.jsp" %>
    
   <div class="page-container">
       <!-- BEGIN REVOLUTION SLIDER -->
       <div class="fullwidthbanner-container slider-main">
           <div class="fullwidthabnner">
               <ul id="revolutionul" style="display:none;">            
                       <!-- THE FIRST SLIDE -->
                       <li data-transition="fade" data-slotamount="8" data-masterspeed="700" data-delay="9400" data-thumb="${baseUrl}/js/homes/corporate/img/sliders/revolution/thumbs/thumb2.jpg">
                           <!-- THE MAIN IMAGE IN THE FIRST SLIDE -->
                           <img src="${baseUrl}/js/homes/corporate/img/sliders/revolution/bg1.jpg" alt="">
                           
                           <div class="caption lft slide_title slide_item_left"
                                data-x="0"
                                data-y="105"
                                data-speed="400"
                                data-start="1500"
                                data-easing="easeOutExpo">
                                <spring:message code="home.title.question"/> 
                           </div>
                           <div class="caption lft slide_subtitle slide_item_left"
                                data-x="0"
                                data-y="180"
                                data-speed="400"
                                data-start="2000"
                                data-easing="easeOutExpo">
                                <spring:message code="home.title.answer"/>
                           </div>
                           
                           <div class="caption lft slide_desc slide_item_left"
                                data-x="0"
                                data-y="220"
                                data-speed="400"
                                data-start="2500"
                                data-easing="easeOutExpo">
                                <spring:message code="home.belowTitle1"/><br/>
                                <spring:message code="home.belowTitle2"/><br/>
                                <spring:message code="home.belowTitle3"/>
                           </div>
                           
                           <a class="caption lft btn green slide_btn slide_item_left" href="submitJournal" target="_blank"
                                data-x="0"
                                data-y="300"
                                data-speed="400"
                                data-start="3000"
                                data-easing="easeOutExpo">     
                                <spring:message code="home.open"/>
                           </a>

                           <div class="caption lfb"
                                data-x="640" 
                                data-y="125" 
                                data-speed="700" 
                                data-start="1000" 
                                data-easing="easeOutExpo"  >
                                <img src="${baseUrl}/js/homes/corporate/img/sliders/revolution/publication.png" alt="Image 1">
                           </div>
                       </li>

                       <!-- THE SECOND SLIDE -->
                       <li data-transition="fade" data-slotamount="7" data-masterspeed="300" data-delay="9400" data-thumb="${baseUrl}/js/homes/corporate/img/sliders/revolution/thumbs/thumb2.jpg">                        
                           <img src="${baseUrl}/js/homes/corporate/img/sliders/revolution/bg2.jpg" alt="">
                           <div class="caption lfl slide_title slide_item_left"
                                data-x="0"
                                data-y="125"
                                data-speed="400"
                                data-start="3500"
                                data-easing="easeOutExpo">
                                <spring:message code="home.simple"/>
                           </div>
                           <div class="caption lfl slide_subtitle slide_item_left"
                                data-x="0"
                                data-y="200"
                                data-speed="400"
                                data-start="4000"
                                data-easing="easeOutExpo">
                                <spring:message code="home.responsive"/>
                           </div>
                           <div class="caption lfl slide_desc slide_item_left"
                                data-x="0"
                                data-y="245"
                                data-speed="400"
                                data-start="4500"
                                data-easing="easeOutExpo">
                                <spring:message code="home.responsive.long1"/><br/>
                                <spring:message code="home.responsive.long2"/>
                           </div>                        
                           <div class="caption lfr slide_item_right" 
                                data-x="755" 
                                data-y="105" 
                                data-speed="1200" 
                                data-start="1500" 
                                data-easing="easeOutBack">
                                <img src="${baseUrl}/js/homes/corporate/img/sliders/revolution/mac.png" alt="Image 1">
                           </div>
                           <div class="caption lfr slide_item_right" 
                                data-x="690" 
                                data-y="245" 
                                data-speed="1200" 
                                data-start="2000" 
                                data-easing="easeOutBack">
                                <img src="${baseUrl}/js/homes/corporate/img/sliders/revolution/ipad.png" alt="Image 1">
                           </div>
                           <div class="caption lfr slide_item_right" 
                                data-x="855" 
                                data-y="290" 
                                data-speed="1200" 
                                data-start="2500" 
                                data-easing="easeOutBack">
                                <img src="${baseUrl}/js/homes/corporate/img/sliders/revolution/iphone.png" alt="Image 1">
                           </div>
                           <div class="caption lfr slide_item_right" 
                                data-x="955" 
                                data-y="230" 
                                data-speed="1200" 
                                data-start="3000" 
                                data-easing="easeOutBack">
                                <img src="${baseUrl}/js/homes/corporate/img/sliders/revolution/macbook.png" alt="Image 1">
                           </div>
                           <div class="caption lft slide_item_right" 
                                data-x="985" 
                                data-y="45" 
                                data-speed="500" 
                                data-start="5000" 
                                data-easing="easeOutBack">
                                <img src="${baseUrl}/js/homes/corporate/img/sliders/revolution/hint1-blue.png" id="rev-hint1" alt="Image 1">
                           </div>                        
                           <div class="caption lfb slide_item_right" 
                                data-x="475" 
                                data-y="355" 
                                data-speed="500" 
                                data-start="5500" 
                                data-easing="easeOutBack">
                                <img src="${baseUrl}/js/homes/corporate/img/sliders/revolution/hint2-blue.png" id="rev-hint2" alt="Image 1">
                           </div>
                       </li>
                                               
                       <!-- THE THIRD SLIDE -->
                       <li data-transition="fade" data-slotamount="8" data-masterspeed="700" data-delay="9400" data-thumb="${baseUrl}/js/homes/corporate/img/sliders/revolution/thumbs/thumb2.jpg">
                           <!-- THE MAIN IMAGE IN THE FIRST SLIDE -->
                           <img src="${baseUrl}/js/homes/corporate/img/sliders/revolution/bg4.jpg" alt="">                        
                            <div class="caption lft slide_title"
                                data-x="0"
                                data-y="105"
                                data-speed="400"
                                data-start="1500"
                                data-easing="easeOutExpo">
                                <spring:message code="home.satifaction"/>
                           </div>
                           <div class="caption lft slide_subtitle"
                                data-x="0"
                                data-y="180"
                                data-speed="400"
                                data-start="2000"
                                data-easing="easeOutExpo">
                                <spring:message code="home.faster"/>
                           </div>
                           <div class="caption lft slide_desc"
                                data-x="0"
                                data-y="225"
                                data-speed="400"
                                data-start="2500"
                                data-easing="easeOutExpo">
                                <spring:message code="home.satifaction.description1"/><br/>
                                <spring:message code="home.satifaction.description2"/>
                           </div>                        
                           
                           <div class="caption lft start"  
                                data-x="850" 
                                data-y="80" 
                                data-speed="400" 
                                data-start="2400" 
                                data-easing="easeOutBack"  >
                                <img width="20%" src="${baseUrl}/js/homes/corporate/img/sliders/revolution/man-winner.png" alt="Image 3">
                           </div>                        
                       </li>
               </ul>
               <div class="tp-bannertimer tp-bottom"></div>
           </div>
       </div>
       <!-- END REVOLUTION SLIDER -->
   	
          
       <div class="container">
           <!-- BEGIN SERVICE BOX -->   
           <div class="row service-box">
               <div class="col-md-3 col-sm-3">
                   <div class="service-box-heading">
                       <em><i class="fa fa-cog blue"></i></em>
                       <span><spring:message code="home.manage"/></span>
                   </div>
                   <p>Journal manager opens a journal manuscript management service and operate the overall process...</p>
                   <p><a class="btn btn-default" href="${baseUrl}/promotion/features/management" role="button">View details &raquo;</a></p>
               </div>
               <div class="col-md-3 col-sm-3">
                   <div class="service-box-heading">
                       <em><i class="fa fa-check red"></i></em>
                       <span><spring:message code="home.submit"/></span>
                   </div>
                   <p>Substantive editing and rewriting your manuscript and submit...</p>
                   <p><a class="btn btn-default" href="${baseUrl}/promotion/features/submission" role="button">View details &raquo;</a></p>
               </div>
               <div class="col-md-3 col-sm-3">
                   <div class="service-box-heading">
                       <em><i class="fa fa-compress green"></i></em>
                       <span><spring:message code="home.review"/></span>
                   </div>
                   <p>Selected reviewers review the manuscript...</p>
                   <p><a class="btn btn-default" href="${baseUrl}/promotion/features/review" role="button">View details &raquo;</a></p>
               </div>
               <div class="col-md-3 col-sm-3">
                   <div class="service-box-heading">
                       <em><i class="fa fa-location-arrow blue"></i></em>
                       <span><spring:message code="home.editorship"/></span>
                   </div>
                   <p>Chief or associate editors select reviewers for the submitted manuscript...</p>
                   <p><a class="btn btn-default" href="${baseUrl}/promotion/features/editorship" role="button">View details &raquo;</a></p>
               </div>
           </div>
           <!-- END SERVICE BOX -->  

           <!-- BEGIN BLOCKQUOTE BLOCK -->   
           <div class="row quote-v1">
               <div class="col-md-9 quote-v1-inner">
                   <span>Are you a journal manager? If you are, open a new journal manuscript service.</span>
               </div>
               <div class="col-md-3 quote-v1-inner text-right">
                   <a class="btn-transparent" href="submitJournal" target="_blank"><i class="fa fa-rocket margin-right-10"></i>Open a new service</a>
                   <!--<a class="btn-transparent" href="http://themeforest.net/item/metronic-responsive-admin-dashboard-template/4021469"><i class="icon-gift margin-right-10"></i>Purchase 2 in 1</a>-->
               </div>
           </div>
           <!-- END BLOCKQUOTE BLOCK -->

           <div class="clearfix"></div>

           <!-- BEGIN RECENT WORKS -->
           <div class="row recent-work margin-bottom-40">
               <div class="col-md-3">
                   <h2><a href="portfolio.html">Recent Works</a></h2>
                   <p>Lorem ipsum dolor sit amet, dolore eiusmod quis tempor incididunt ut et dolore Ut veniam unde voluptatem. Sed unde omnis iste natus error sit voluptatem.</p>
               </div>
               <div class="col-md-9">
                   <ul class="bxslider">
                       <li>
                           <em>
                               <img src="${baseUrl}/js/homes/corporate/img/works/img1.jpg" alt="" />
                               <a href="portfolio_item.html"><i class="fa fa-link icon-hover icon-hover-1"></i></a>
                               <a href="${baseUrl}/js/homes/corporate/img/works/img1.jpg" class="fancybox-button" title="Project Name #1" data-rel="fancybox-button"><i class="fa fa-search icon-hover icon-hover-2"></i></a>
                           </em>
                           <a class="bxslider-block" href="#">
                               <strong>Amazing Project</strong>
                               <b>Agenda corp.</b>
                           </a>
                       </li>
                       <li>
                           <em>
                               <img src="${baseUrl}/js/homes/corporate/img/works/img2.jpg" alt="" />
                               <a href="portfolio_item.html"><i class="fa fa-link icon-hover icon-hover-1"></i></a>
                               <a href="${baseUrl}/js/homes/corporate/img/works/img2.jpg" class="fancybox-button" title="Project Name #2" data-rel="fancybox-button"><i class="fa fa-search icon-hover icon-hover-2"></i></a>
                           </em>
                           <a class="bxslider-block" href="#">
                               <strong>Amazing Project</strong>
                               <b>Agenda corp.</b>
                           </a>
                       </li>
                       <li>
                           <em>
                               <img src="${baseUrl}/js/homes/corporate/img/works/img3.jpg" alt="" />
                               <a href="portfolio_item.html"><i class="fa fa-link icon-hover icon-hover-1"></i></a>
                               <a href="${baseUrl}/js/homes/corporate/img/works/img3.jpg" class="fancybox-button" title="Project Name #3" data-rel="fancybox-button"><i class="fa fa-search icon-hover icon-hover-2"></i></a>
                           </em>
                           <a class="bxslider-block" href="#">
                               <strong>Amazing Project</strong>
                               <b>Agenda corp.</b>
                           </a>
                       </li>
                       <li>
                           <em>
                               <img src="${baseUrl}/js/homes/corporate/img/works/img4.jpg" alt="" />
                               <a href="portfolio_item.html"><i class="fa fa-link icon-hover icon-hover-1"></i></a>
                               <a href="${baseUrl}/js/homes/corporate/img/works/img4.jpg" class="fancybox-button" title="Project Name #4" data-rel="fancybox-button"><i class="fa fa-search icon-hover icon-hover-2"></i></a>
                           </em>
                           <a class="bxslider-block" href="#">
                               <strong>Amazing Project</strong>
                               <b>Agenda corp.</b>
                           </a>
                       </li>
                       <li>
                           <em>
                               <img src="${baseUrl}/js/homes/corporate/img/works/img5.jpg" alt="" />
                               <a href="portfolio_item.html"><i class="fa fa-link icon-hover icon-hover-1"></i></a>
                               <a href="${baseUrl}/js/homes/corporate/img/works/img5.jpg" class="fancybox-button" title="Project Name #5" data-rel="fancybox-button"><i class="fa fa-search icon-hover icon-hover-2"></i></a>
                           </em>
                           <a class="bxslider-block" href="#">
                               <strong>Amazing Project</strong>
                               <b>Agenda corp.</b>
                           </a>
                       </li>
                       <li>
                           <em>
                               <img src="${baseUrl}/js/homes/corporate/img/works/img6.jpg" alt="" />
                               <a href="portfolio_item.html"><i class="fa fa-link icon-hover icon-hover-1"></i></a>
                               <a href="${baseUrl}/js/homes/corporate/img/works/img6.jpg" class="fancybox-button" title="Project Name #6" data-rel="fancybox-button"><i class="fa fa-search icon-hover icon-hover-2"></i></a>
                           </em>
                           <a class="bxslider-block" href="#">
                               <strong>Amazing Project</strong>
                               <b>Agenda corp.</b>
                           </a>
                       </li>
                       <li>
                           <em>
                               <img src="${baseUrl}/js/homes/corporate/img/works/img3.jpg" alt="" />
                               <a href="portfolio_item.html"><i class="fa fa-link icon-hover icon-hover-1"></i></a>
                               <a href="${baseUrl}/js/homes/corporate/img/works/img3.jpg" class="fancybox-button" title="Project Name #3" data-rel="fancybox-button"><i class="fa fa-search icon-hover icon-hover-2"></i></a>
                           </em>
                           <a class="bxslider-block" href="#">
                               <strong>Amazing Project</strong>
                               <b>Agenda corp.</b>
                           </a>
                       </li>
                       <li>
                           <em>
                               <img src="${baseUrl}/js/homes/corporate/img/works/img4.jpg" alt="" />
                               <a href="portfolio_item.html"><i class="fa fa-link icon-hover icon-hover-1"></i></a>
                               <a href="${baseUrl}/js/homes/corporate/img/works/img4.jpg" class="fancybox-button" title="Project Name #4" data-rel="fancybox-button"><i class="fa fa-search icon-hover icon-hover-2"></i></a>
                           </em>
                           <a class="bxslider-block" href="#">
                               <strong>Amazing Project</strong>
                               <b>Agenda corp.</b>
                           </a>
                       </li>
                   </ul>        
               </div>
           </div>   
           <!-- END RECENT WORKS -->

           <div class="clearfix"></div>

           <!-- BEGIN TABS AND TESTIMONIALS -->
           <div class="row mix-block">
               <!-- TABS -->
               <div class="col-md-7 tab-style-1 margin-bottom-20">
                   <ul class="nav nav-tabs">
                       <li class="active"><a href="#tab-1" data-toggle="tab">Multipurpose</a></li>
                       <li><a href="#tab-2" data-toggle="tab">Documented</a></li>
                       <li><a href="#tab-3" data-toggle="tab">Responsive</a></li>
                       <li><a href="#tab-4" data-toggle="tab">Clean & Fresh</a></li>
                   </ul>
                   <div class="tab-content">
                       <div class="tab-pane row fade in active" id="tab-1">
                           <div class="col-md-3">
                               <a href="${baseUrl}/js/homes/corporate/img/photos/img7.jpg" class="fancybox-button" title="Image Title" data-rel="fancybox-button">
                                   <img class="img-responsive" src="${baseUrl}/js/homes/corporate/img/photos/img7.jpg" alt="" />
                               </a>
                           </div>
                           <div class="col-md-9">
                               <p class="margin-bottom-10">Raw denim you probably haven't heard of them jean shorts Austin. Nesciunt tofu stumptown aliqua, retro synth master cleanse. Mustache cliche tempor, williamsburg carles vegan helvetica. Cosby sweater eu banh mi, qui irure terry richardson ex squid Aliquip placeat salvia cillum iphone.</p>
                               <p><a class="more" href="#">Read more <i class="icon-angle-right"></i></a></p>
                           </div>
                       </div>
                       <div class="tab-pane row fade" id="tab-2">
                           <div class="col-md-9">
                               <p>Food truck fixie locavore, accusamus mcsweeney's marfa nulla single-origin coffee squid. Exercitation +1 labore velit, blog sartorial PBR leggings next level wes anderson artisan four loko farm-to-table craft beer twee. Qui photo booth letterpress, commodo enim craft beer mlkshk aliquip jean shorts ullamco ad vinyl cillum PBR. Homo nostrud organic, assumenda labore aesthetic magna delectus mollit. Keytar helvetica VHS salvia..</p>
                           </div>
                           <div class="col-md-3">
                               <a href="${baseUrl}/js/homes/corporate/img/photos/img10.jpg" class="fancybox-button" title="Image Title" data-rel="fancybox-button">
                                   <img class="img-responsive" src="${baseUrl}/js/homes/corporate/img/photos/img10.jpg" alt="" />
                               </a>
                           </div>
                       </div>
                       <div class="tab-pane fade" id="tab-3">
                           <p>Etsy mixtape wayfarers, ethical wes anderson tofu before they sold out mcsweeney's organic lomo retro fanny pack lo-fi farm-to-table readymade. Messenger bag gentrify pitchfork tattooed craft beer, iphone skateboard locavore carles etsy salvia banksy hoodie helvetica. DIY synth PBR banksy irony. Leggings gentrify squid 8-bit cred pitchfork. Williamsburg banh mi whatever gluten-free, carles pitchfork biodiesel fixie etsy retro mlkshk vice blog. Scenester cred you probably haven't heard of them, vinyl craft beer blog stumptown. Pitchfork sustainable tofu synth chambray yr.</p>
                       </div>
                       <div class="tab-pane fade" id="tab-4">
                           <p>Trust fund seitan letterpress, keytar raw denim keffiyeh etsy art party before they sold out master cleanse gluten-free squid scenester freegan cosby sweater. Fanny pack portland seitan DIY, art party locavore wolf cliche high life echo park Austin. Cred vinyl keffiyeh DIY salvia PBR, banh mi before they sold out farm-to-table VHS viral locavore cosby sweater. Lomo wolf viral, mustache readymade thundercats keffiyeh craft beer marfa ethical. Wolf salvia freegan, sartorial keffiyeh echo park vegan.</p>
                       </div>
                   </div>
               </div>
               <!-- END TABS -->
       
               <!-- TESTIMONIALS -->
               <div class="col-md-5 testimonials-v1">
                   <div id="myCarousel" class="carousel slide">
                       <!-- Carousel items -->
                       <div class="carousel-inner">
                           <div class="active item">
                               <span class="testimonials-slide">Denim you probably haven't heard of. Lorem ipsum dolor met consectetur adipisicing sit amet, consectetur adipisicing elit, of them jean shorts sed magna aliqua. Lorem ipsum dolor met consectetur adipisicing sit amet do eiusmod dolore.</span>
                               <div class="carousel-info">
                                   <img class="pull-left" src="${baseUrl}/js/homes/corporate/img/people/img1-small.jpg" alt="" />
                                   <div class="pull-left">
                                       <span class="testimonials-name">Lina Mars</span>
                                       <span class="testimonials-post">Commercial Director</span>
                                   </div>
                               </div>
                           </div>
                           <div class="item">
                               <span class="testimonials-slide">Raw denim you Mustache cliche tempor, williamsburg carles vegan helvetica probably haven't heard of them jean shorts austin. Nesciunt tofu stumptown aliqua, retro synth master cleanse. Mustache cliche tempor, williamsburg carles vegan helvetica.</span>
                               <div class="carousel-info">
                                   <img class="pull-left" src="${baseUrl}/js/homes/corporate/img/people/img5-small.jpg" alt="" />
                                   <div class="pull-left">
                                       <span class="testimonials-name">Kate Ford</span>
                                       <span class="testimonials-post">Commercial Director</span>
                                   </div>
                               </div>
                           </div>
                           <div class="item">
                               <span class="testimonials-slide">Reprehenderit butcher stache cliche tempor, williamsburg carles vegan helvetica.retro keffiyeh dreamcatcher synth. Cosby sweater eu banh mi, qui irure terry richardson ex squid Aliquip placeat salvia cillum iphone.</span>
                               <div class="carousel-info">
                                   <img class="pull-left" src="${baseUrl}/js/homes/corporate/img/people/img2-small.jpg" alt="" />
                                   <div class="pull-left">
                                       <span class="testimonials-name">Jake Witson</span>
                                       <span class="testimonials-post">Commercial Director</span>
                                   </div>
                               </div>
                           </div>
                       </div>

                       <!-- Carousel nav -->
                       <a class="left-btn" href="#myCarousel" data-slide="prev"></a>
                       <a class="right-btn" href="#myCarousel" data-slide="next"></a>
                   </div>
               </div>
               <!-- END TESTIMONIALS -->
           </div>                
           <!-- END TABS AND TESTIMONIALS -->

           <!-- BEGIN STEPS -->
           <div class="row no-space-steps margin-bottom-40">
               <div class="col-md-4 col-sm-4">
                   <div class="front-steps front-step-one">
                       <h2>Goal definition</h2>
                       <p>Lorem ipsum dolor sit amet sit consectetur adipisicing eiusmod tempor.</p>
                   </div>
               </div>
               <div class="col-md-4 col-sm-4">
                   <div class="front-steps front-step-two">
                       <h2>Analyse</h2>
                       <p>Lorem ipsum dolor sit amet sit consectetur adipisicing eiusmod tempor.</p>
                   </div>
               </div>
               <div class="col-md-4 col-sm-4">
                   <div class="front-steps front-step-three">
                       <h2>Implementation</h2>
                       <p>Lorem ipsum dolor sit amet sit consectetur adipisicing eiusmod tempor.</p>
                   </div>
               </div>
           </div>
           <!-- END STEPS -->

           <!-- BEGIN CLIENTS -->
           <div class="row margin-bottom-40 our-clients">
               <div class="col-md-3">
                   <h2><a href="#">Our Clients</a></h2>
                   <p>Lorem dipsum folor margade sitede lametep eiusmod psumquis dolore.</p>
               </div>
               <div class="col-md-9">
                   <ul class="bxslider1 clients-list">
                       <li>
                           <a href="#">
                               <img src="${baseUrl}/js/homes/corporate/img/clients/client_1_gray.png" alt="" /> 
                               <img src="${baseUrl}/js/homes/corporate/img/clients/client_1.png" class="color-img" alt="" />
                           </a>
                       </li>
                       <li>
                           <a href="#">
                               <img src="${baseUrl}/js/homes/corporate/img/clients/client_2_gray.png" alt="" /> 
                               <img src="${baseUrl}/js/homes/corporate/img/clients/client_2.png" class="color-img" alt="" />
                           </a>
                       </li>
                       <li>
                           <a href="#">
                               <img src="${baseUrl}/js/homes/corporate/img/clients/client_3_gray.png" alt="" /> 
                               <img src="${baseUrl}/js/homes/corporate/img/clients/client_3.png" class="color-img" alt="" />
                           </a>
                       </li>
                       <li>
                           <a href="#">
                               <img src="${baseUrl}/js/homes/corporate/img/clients/client_4_gray.png" alt="" /> 
                               <img src="${baseUrl}/js/homes/corporate/img/clients/client_4.png" class="color-img" alt="" />
                           </a>
                       </li>
                       <li>
                           <a href="#">
                               <img src="${baseUrl}/js/homes/corporate/img/clients/client_5_gray.png" alt="" /> 
                               <img src="${baseUrl}/js/homes/corporate/img/clients/client_5.png" class="color-img" alt="" />
                           </a>
                       </li>
                       <li>
                           <a href="#">                        
                               <img src="${baseUrl}/js/homes/corporate/img/clients/client_6_gray.png" alt="" /> 
                               <img src="${baseUrl}/js/homes/corporate/img/clients/client_6.png" class="color-img" alt="" />
                           </a>
                       </li>
                       <li>
                           <a href="#">
                               <img src="${baseUrl}/js/homes/corporate/img/clients/client_7_gray.png" alt="" /> 
                               <img src="${baseUrl}/js/homes/corporate/img/clients/client_7.png" class="color-img" alt="" />
                           </a>
                       </li>
                       <li>
                           <a href="#">                        
                               <img src="${baseUrl}/js/homes/corporate/img/clients/client_8_gray.png" alt="" /> 
                               <img src="${baseUrl}/js/homes/corporate/img/clients/client_8.png" class="color-img" alt="" />
                           </a>
                       </li>
                   </ul>                        
               </div>
           </div>
           <!-- END CLIENTS -->
       </div>
       
   </div>
   <!-- END PAGE CONTAINER -->

<!-- BEGIN FOOTER -->

<%@ include file="/WEB-INF/views/includes/promotionFooterBar.jsp" %>    
<!-- BEGIN PAGE LEVEL JAVASCRIPTS(REQUIRED ONLY FOR CURRENT PAGE) -->
<script src="${baseUrl}/js/homes/corporate/plugins/fancybox/source/jquery.fancybox.pack.js" type="text/javascript"></script>  
<script src="${baseUrl}/js/homes/corporate/plugins/revolution_slider/rs-plugin/js/jquery.themepunch.plugins.min.js" type="text/javascript" ></script>
<script src="${baseUrl}/js/homes/corporate/plugins/revolution_slider/rs-plugin/js/jquery.themepunch.revolution.min.js" type="text/javascript"></script> 
<script src="${baseUrl}/js/homes/corporate/plugins/bxslider/jquery.bxslider.min.js" type="text/javascript"></script>
<script src="${baseUrl}/js/homes/corporate/scripts/index.js"></script>    

<script type="text/javascript">
    jQuery(document).ready(function() {
        App.initBxSlider();
        Index.initRevolutionSlider();                    

    		var offset = new Date(); 
    		setCookie("TimeOffset", offset.getTimezoneOffset(), 365);
    });

    function setCookie(cookieName, cookieValue, nDays) {
    	var today = new Date();
    	var expire = new Date();
    	if (nDays == null || nDays == 0) nDays = 1;
    	expire.setTime(today.getTime() + 3600000 * 24 * nDays);
    	document.cookie = cookieName + "=" + escape(cookieValue) + ";expires=" + expire.toGMTString() + "; path=${baseUrl}/";
    }
</script>
<!-- END PAGE LEVEL JAVASCRIPTS -->
<!-- END BODY -->
</html>