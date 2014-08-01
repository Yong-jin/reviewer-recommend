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
				<h3><i class="fa fa-users"></i>&nbsp;Journal Management</h3>
		</div> 
				
				<div class="table-container">					
					<table class="table table-striped table-bordered table-hover fixedWidthSize" id="journalList_ajax">
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
						<th class="text-middle" id="jnid_header"><spring:message code="journal.journalNameId"/></th>
						<th class="text-middle"><spring:message code="journal.creator.username.short"/></th>
						<th class="text-middle"><spring:message code="journal.creator.name"/></th>
						<th class="text-middle"><spring:message code="journal.shortTitle"/></th>
						<th class="text-middle"><spring:message code="journal.title"/></th>
						<th class="text-middle"><spring:message code="journal.organization"/></th>
						<th class="text-middle"><spring:message code="journal.language.short"/></th>
						<th class="text-middle"><spring:message code="journal.publisherCountry.short"/></th>
						<th class="text-middle"><spring:message code="journal.registeredDate.short"/></th>
						<th class="text-middle"><spring:message code="journal.registeredTime.short"/></th>
						<th class="text-middle"><spring:message code="journal.journalCoverImage.short"/></th>
						<th class="text-middle"><spring:message code="journal.enabled"/></th>
						<th class="text-middle"><spring:message code="system.action"/></th>
					</tr>
					<tr role="row" class="filter">
						<td></td>
						<td>
							<input type="text" class="form-control form-filter input-sm" id="filter_journalNameId">
						</td>
						<td>
							<input type="text" class="form-control form-filter input-sm" id="filter_username">
						</td>
						<td>
							<input type="text" class="form-control form-filter input-sm" id="filter_name">
						</td>
						<td>
							<input type="text" class="form-control form-filter input-sm" id="filter_shortTitle">
						</td>
						<td>
							<input type="text" class="form-control form-filter input-sm" id="filter_title">
						</td>						
						<td>
							<input type="text" class="form-control form-filter input-sm" id="filter_organization">
						</td>
						<td>
							<select class="form-control form-filter input-sm">
								<option value="Any">Any</option>
								<option value="en">English</option><!-- <img alt="" src="assets/img/flags/es.png"/> -->
								<option value="zh">Chinese</option>
								<option value="ja">Japanese</option>
								<option value="ko">Korean</option>
							</select>
						</td>
						<td>
							<div>
								<select id="select2_country2" class="select2 form-control form-filter">
									<option value=""></option>
									<option value="AF">Afghanistan</option><option value="AL">Albania</option><option value="DZ">Algeria</option><option value="AS">American Samoa</option><option value="AD">Andorra</option><option value="AO">Angola</option><option value="AI">Anguilla</option><option value="AQ">Antarctica</option><option value="AR">Argentina</option><option value="AM">Armenia</option><option value="AW">Aruba</option><option value="AU">Australia</option><option value="AT">Austria</option><option value="AZ">Azerbaijan</option><option value="BS">Bahamas</option><option value="BH">Bahrain</option><option value="BD">Bangladesh</option><option value="BB">Barbados</option><option value="BY">Belarus</option><option value="BE">Belgium</option><option value="BZ">Belize</option><option value="BJ">Benin</option><option value="BM">Bermuda</option><option value="BT">Bhutan</option><option value="BO">Bolivia</option><option value="BA">Bosnia and Herzegowina</option><option value="BW">Botswana</option><option value="BV">Bouvet Island</option><option value="BR">Brazil</option><option value="IO">British Indian Ocean Territory</option><option value="BN">Brunei Darussalam</option><option value="BG">Bulgaria</option><option value="BF">Burkina Faso</option><option value="BI">Burundi</option><option value="KH">Cambodia</option><option value="CM">Cameroon</option><option value="CA">Canada</option><option value="CV">Cape Verde</option><option value="KY">Cayman Islands</option><option value="CF">Central African Republic</option><option value="TD">Chad</option><option value="CL">Chile</option><option value="CN">China</option><option value="CX">Christmas Island</option><option value="CC">Cocos (Keeling) Islands</option><option value="CO">Colombia</option><option value="KM">Comoros</option><option value="CG">Congo</option><option value="CD">Congo, the Democratic Republic of the</option><option value="CK">Cook Islands</option><option value="CR">Costa Rica</option><option value="CI">Cote d'Ivoire</option><option value="HR">Croatia (Hrvatska)</option><option value="CU">Cuba</option><option value="CY">Cyprus</option><option value="CZ">Czech Republic</option><option value="DK">Denmark</option><option value="DJ">Djibouti</option><option value="DM">Dominica</option><option value="DO">Dominican Republic</option><option value="EC">Ecuador</option><option value="EG">Egypt</option><option value="SV">El Salvador</option><option value="GQ">Equatorial Guinea</option><option value="ER">Eritrea</option><option value="EE">Estonia</option><option value="ET">Ethiopia</option><option value="FK">Falkland Islands (Malvinas)</option><option value="FO">Faroe Islands</option><option value="FJ">Fiji</option><option value="FI">Finland</option><option value="FR">France</option><option value="GF">French Guiana</option><option value="PF">French Polynesia</option><option value="TF">French Southern Territories</option><option value="GA">Gabon</option><option value="GM">Gambia</option><option value="GE">Georgia</option><option value="DE">Germany</option><option value="GH">Ghana</option><option value="GI">Gibraltar</option><option value="GR">Greece</option><option value="GL">Greenland</option><option value="GD">Grenada</option><option value="GP">Guadeloupe</option><option value="GU">Guam</option><option value="GT">Guatemala</option><option value="GN">Guinea</option><option value="GW">Guinea-Bissau</option><option value="GY">Guyana</option><option value="HT">Haiti</option><option value="HM">Heard and Mc Donald Islands</option><option value="VA">Holy See (Vatican City State)</option><option value="HN">Honduras</option><option value="HK">Hong Kong</option><option value="HU">Hungary</option><option value="IS">Iceland</option><option value="IN">India</option><option value="ID">Indonesia</option><option value="IR">Iran (Islamic Republic of)</option><option value="IQ">Iraq</option><option value="IE">Ireland</option><option value="IL">Israel</option><option value="IT">Italy</option><option value="JM">Jamaica</option><option value="JP">Japan</option><option value="JO">Jordan</option><option value="KZ">Kazakhstan</option><option value="KE">Kenya</option><option value="KI">Kiribati</option><option value="KP">Korea, Democratic People's Republic of</option><option value="KR">Korea, Republic of</option><option value="KW">Kuwait</option><option value="KG">Kyrgyzstan</option><option value="LA">Lao People's Democratic Republic</option><option value="LV">Latvia</option><option value="LB">Lebanon</option><option value="LS">Lesotho</option><option value="LR">Liberia</option><option value="LY">Libyan Arab Jamahiriya</option><option value="LI">Liechtenstein</option><option value="LT">Lithuania</option><option value="LU">Luxembourg</option><option value="MO">Macau</option><option value="MK">Macedonia, The Former Yugoslav Republic of</option><option value="MG">Madagascar</option><option value="MW">Malawi</option><option value="MY">Malaysia</option><option value="MV">Maldives</option><option value="ML">Mali</option><option value="MT">Malta</option><option value="MH">Marshall Islands</option><option value="MQ">Martinique</option><option value="MR">Mauritania</option><option value="MU">Mauritius</option><option value="YT">Mayotte</option><option value="MX">Mexico</option><option value="FM">Micronesia, Federated States of</option><option value="MD">Moldova, Republic of</option><option value="MC">Monaco</option><option value="MN">Mongolia</option><option value="MS">Montserrat</option><option value="MA">Morocco</option><option value="MZ">Mozambique</option><option value="MM">Myanmar</option><option value="NA">Namibia</option><option value="NR">Nauru</option><option value="NP">Nepal</option><option value="NL">Netherlands</option><option value="AN">Netherlands Antilles</option><option value="NC">New Caledonia</option><option value="NZ">New Zealand</option><option value="NI">Nicaragua</option><option value="NE">Niger</option><option value="NG">Nigeria</option><option value="NU">Niue</option><option value="NF">Norfolk Island</option><option value="MP">Northern Mariana Islands</option><option value="NO">Norway</option><option value="OM">Oman</option><option value="PK">Pakistan</option><option value="PW">Palau</option><option value="PA">Panama</option><option value="PG">Papua New Guinea</option><option value="PY">Paraguay</option><option value="PE">Peru</option><option value="PH">Philippines</option><option value="PN">Pitcairn</option><option value="PL">Poland</option><option value="PT">Portugal</option><option value="PR">Puerto Rico</option><option value="QA">Qatar</option><option value="RE">Reunion</option><option value="RO">Romania</option><option value="RU">Russian Federation</option><option value="RW">Rwanda</option><option value="KN">Saint Kitts and Nevis</option><option value="LC">Saint LUCIA</option><option value="VC">Saint Vincent and the Grenadines</option><option value="WS">Samoa</option><option value="SM">San Marino</option><option value="ST">Sao Tome and Principe</option><option value="SA">Saudi Arabia</option><option value="SN">Senegal</option><option value="SC">Seychelles</option><option value="SL">Sierra Leone</option><option value="SG">Singapore</option><option value="SK">Slovakia (Slovak Republic)</option><option value="SI">Slovenia</option><option value="SB">Solomon Islands</option><option value="SO">Somalia</option><option value="ZA">South Africa</option><option value="GS">South Georgia and the South Sandwich Islands</option><option value="ES">Spain</option><option value="LK">Sri Lanka</option><option value="SH">St. Helena</option><option value="PM">St. Pierre and Miquelon</option><option value="SD">Sudan</option><option value="SR">Suriname</option><option value="SJ">Svalbard and Jan Mayen Islands</option><option value="SZ">Swaziland</option><option value="SE">Sweden</option><option value="CH">Switzerland</option><option value="SY">Syrian Arab Republic</option><option value="TW">Taiwan, Province of China</option><option value="TJ">Tajikistan</option><option value="TZ">Tanzania, United Republic of</option><option value="TH">Thailand</option><option value="TG">Togo</option><option value="TK">Tokelau</option><option value="TO">Tonga</option><option value="TT">Trinidad and Tobago</option><option value="TN">Tunisia</option><option value="TR">Turkey</option><option value="TM">Turkmenistan</option><option value="TC">Turks and Caicos Islands</option><option value="TV">Tuvalu</option><option value="UG">Uganda</option><option value="UA">Ukraine</option><option value="AE">United Arab Emirates</option><option value="GB">United Kingdom</option><option value="US">United States</option><option value="UM">United States Minor Outlying Islands</option><option value="UY">Uruguay</option><option value="UZ">Uzbekistan</option><option value="VU">Vanuatu</option><option value="VE">Venezuela</option><option value="VN">Viet Nam</option><option value="VG">Virgin Islands (British)</option><option value="VI">Virgin Islands (U.S.)</option><option value="WF">Wallis and Futuna Islands</option><option value="EH">Western Sahara</option><option value="YE">Yemen</option><option value="ZM">Zambia</option><option value="ZW">Zimbabwe</option>
								</select>
							</div>
						</td>
						<td colspan="2">
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
						</td>
						<td></td>
						<td>
							<select name="order_status" class="form-control form-filter input-sm">
								<option value="Any">Any</option>
								<option value="Enable">Enable</option>
								<option value="Disable">Disable</option>
							</select>
						</td>
						<td>
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
<script src="${baseUrl}/js/homes/journalList-table-ajax.js"></script>
<!-- END PAGE LEVEL SCRIPTS -->
<script>
jQuery(document).ready(function() {    
  App.init();
  TableAjax.init();
   
	oTable = $('#journalList_ajax').dataTable(); 
		
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
	
	$("#cancel").click(function(event) {
		var url = "${baseUrl}";    
		$(location).attr('href',url);
		return false;
	});
	
	$("#jnid_header").removeClass("dataTableID");
});
</script>
</footer>
</body>
<!-- END BODY -->
</html>