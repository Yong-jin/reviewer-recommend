<%@ taglib prefix="customTagFile" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<!--[if lt IE 7]>      <html class="no-js lt-ie9 lt-ie8 lt-ie7"> <![endif]-->
<!--[if IE 7]>         <html class="no-js lt-ie9 lt-ie8"> <![endif]-->
<!--[if IE 8]>         <html class="no-js lt-ie9"> <![endif]-->
<!--[if gt IE 8]><!--> <html class="no-js"> <!--<![endif]-->
<head>
<title>Superuser Dashboard</title>
<%@ include file="/WEB-INF/views/includes/header.jsp" %>
<link href="${baseUrl}/css/custom.css" rel="stylesheet" type="text/css"/>
<link href="${baseUrl}/assets/plugins/select2/select2.css" rel="stylesheet" type="text/css" />
<link href="${baseUrl}/assets/plugins/select2/select2-metronic.css" rel="stylesheet" type="text/css"/>
<link href="${baseUrl}/assets/plugins/data-tables/DT_bootstrap.css" rel="stylesheet" />
<link href="${baseUrl}/assets/plugins/bootstrap-datepicker/css/datepicker.css" rel="stylesheet" type="text/css" />
<link href="${baseUrl}/js/tabletools_media/css/TableTools.css" rel="stylesheet" type="text/css" />
<link href="${baseUrl}/js/tabletools_media/css/TableTools_JUI.css" rel="stylesheet" type="text/css" />

<link href="${baseUrl}/assets/css/style-metronic.css" rel="stylesheet" type="text/css"/>
<link href="${baseUrl}/assets/css/plugins.css" rel="stylesheet" type="text/css"/>
<link href="${baseUrl}/assets/css/custom.css" rel="stylesheet" type="text/css"/>
<!-- END THEME STYLES -->
</head>


<body class="content">
<%@ include file="/WEB-INF/views/includes/headerBar.jsp" %>
<br/>

<div class="container">
		<div class="caption">
				<h3><i class="fa fa-users"></i>&nbsp;Account Management</h3>
		</div> 
				
				<div class="table-container">					
					<table class="table table-striped table-bordered table-hover fixedWidthSize" id="accountList_ajax">
					<thead>
						<tr role="row" class="heading">
						<!--  
						 <th class="text-center text-middle" rowspan="2">
							<spring:message code="system.groupAction"/><br/>
							<select class="table-group-action-input form-control input-sm col-md-2">
									<option value="">-</option>
									<option value="Delete">Delete</option>
							</select>
							<button class="btn btn-xs btn-default table-group-action-submit pull-right"><i class="fa fa-check"></i> Submit</button>
							<input type="checkbox" class="group-checkable">
						</th> -->
						<th>No.</th>			
						<th class="cellCenter text-middle" id="username_header"><spring:message code="user.username"/></th>
						<th class="cellCenter text-middle"><spring:message code="user.firstname"/></th>
						<th class="cellCenter text-middle"><spring:message code="user.lastname"/></th>
						<th class="cellCenter text-middle"><spring:message code="user.institution"/></th>
						<th class="cellCenter text-middle"><spring:message code="user.country"/></th>
						<th class="cellCenter text-middle"><spring:message code="user.degree"/></th>
						<th class="cellCenter text-middle"><spring:message code="user.signupdate"/></th>
						<th class="cellCenter text-middle"><spring:message code="user.enabled"/></th>
						<th class="cellCenter text-middle"><spring:message code="system.action"/></th>
					</tr>
					<tr role="row" class="filter">
						<td></td>
						<td class="cellCenter">
							<input type="text" class="form-control form-filter input-sm" id="filter_username">
						</td>
						<td class="cellCenter">
							<input type="text" class="form-control form-filter input-sm" id="filter_firstname">
						</td>
						<td class="cellCenter">
							<input type="text" class="form-control form-filter input-sm" id="filter_lasttname">
						</td>
						<td class="cellCenter">
							<input type="text" class="form-control form-filter input-sm" id="filter_institution">
						</td>
						<td class="cellCenter">
							<div>
								<select id="select2_country2" class="select2 form-control form-filter">
									<option value=""></option>
									<%@ include file="/WEB-INF/views/includes/country.jsp" %>
								</select>
							</div>
						</td>
						<td class="cellCenter">
							<select class="form-control form-filter input-sm">
								<option value="Any">Any</option>
								<c:forEach var="degreeDesignation" items="${degreeDesignations}">
									<option value="${degreeDesignation.id}"><spring:message code="signin.degreeDesignation.${degreeDesignation.id}"/></option>
								</c:forEach>		
							</select>
						</td>
						<td class="cellCenter">
							<!--
							<div class="input-group date date-picker margin-bottom-5" data-date-format="yyyy-mm-dd">
								<input type="text" class="form-control form-filter input-sm" readonly name="order_date_from" placeholder="From">
								<span class="input-group-btn">
									<button class="btn btn-sm default" type="button"><i class="fa fa-calendar"></i></button>
								</span>
							</div>
							<div class="input-group date date-picker" data-date-format="yyyy-mm-dd">
								<input type="text" class="form-control form-filter input-sm" readonly name="order_date_to" placeholder="To">
								<span class="input-group-btn">
									<button class="btn btn-sm default" type="button"><i class="fa fa-calendar"></i></button>
								</span>
							</div>
							-->
						</td>
						<td class="cellCenter">
							<select name="order_status" class="form-control form-filter input-sm">
								<option value="Any">Any</option>
								<option value="Enabled">Enabled</option>
								<option value="Disabled">Disabled</option>
							</select>
						</td>
						<td class="cellCenter">
							<!--  
							<div class="margin-bottom-5">
								<button class="btn btn-xs btn-default filter-submit margin-bottom"><i class="fa fa-search"></i> Search</button>
							</div>
							-->
							<button class="btn btn-xs btn-default filter-cancel"><i class="fa fa-times"></i> Reset</button>
						</td>
					</tr>
					</thead>
					<tbody>
					</tbody>
					</table>
				</div>
			</div>

	
<!-- END PAGE CONTENT-->
<br/>
<br/>
<br/>
<footer>
<%@ include file="/WEB-INF/views/includes/footerBar.jsp" %>
<!-- BEGIN PAGE LEVEL PLUGINS -->
<script type="text/javascript" src="${baseUrl}/js/custom_global.js"></script>
<script type="text/javascript" src="${baseUrl}/assets/plugins/select2/select2.min.js"></script>
<script type="text/javascript" src="${baseUrl}/assets/plugins/data-tables/jquery.dataTables.js"></script>
<script type="text/javascript" src="${baseUrl}/assets/plugins/data-tables/DT_bootstrap.js"></script>
<script type="text/javascript" src="${baseUrl}/assets/plugins/bootstrap-datepicker/js/bootstrap-datepicker.js"></script>
<script type="text/javascript" src="${baseUrl}/js/tabletools_media/js/TableTools.min.js"></script>
<script type="text/javascript" src="${baseUrl}/js/tabletools_media/js/ZeroClipboard.js"></script>
<!-- END PAGE LEVEL PLUGINS -->
<!-- BEGIN PAGE LEVEL SCRIPTS -->
<script src="${baseUrl}/assets/scripts/core/app.js"></script>
<script src="${baseUrl}/assets/scripts/core/datatable.js"></script>
<script src="${baseUrl}/js/homes/accountList-table-ajax.js"></script>
<!-- END PAGE LEVEL SCRIPTS -->
<script>
jQuery(document).ready(function() {    
  App.init();
  TableAjax.init();
   
	oTable = $('#accountList_ajax').dataTable(); 
		
	$(".form-filter").on("keyup change", function () {
		oTable.fnFilter( this.value, $(".form-filter").index(this) );
	} );
	
	$("#select2_country2").select2({
	  	placeholder: '<i class="fa fa-map-marker"></i>&nbsp;Select',
      allowClear: true,
      dropdownAutoWidth: true,
      formatResult: function(state) {
      	if (!state.id) return state.text;
          return "<img class='flag' src='assets/img/flags/" + state.id.toLowerCase() + ".png' />&nbsp;" + state.text;
      },
      formatSelection: function(state) {
      	if (!state.id) return state.text;
          return "<img class='flag' src='assets/img/flags/" + state.id.toLowerCase() + ".png'/>&nbsp;<small>" + state.text + "<small>";
      },
      escapeMarkup: function (m) {
          return m;
      },
      containerCssClass: "muted"
   });
	
	$(".filter-cancel").click(function() {
	    var oSettings = oTable.fnSettings();
	    var iCol;
	    for(iCol = 0; iCol < oSettings.aoPreSearchCols.length; iCol++) {
	        oSettings.aoPreSearchCols[ iCol ].sSearch = '';
	    }
	    //oTable.fnDraw();
	    //console.log(oSettings);
	 });
	
	$(".dataTables_filter input").addClass("input-sm");
	$(".dataTables_filter input").css("margin-bottom","0px");
	$(".dataTables_filter input").css("padding-bottom","0px");
	
	$("#cancel").click(function(event) {
		var url = "${baseUrl}";    
		$(location).attr('href',url);
		return false;
	});
	
	$("#username_header").removeClass("dataTableID");
});
</script>
</footer>
</body>
<!-- END BODY -->
</html>