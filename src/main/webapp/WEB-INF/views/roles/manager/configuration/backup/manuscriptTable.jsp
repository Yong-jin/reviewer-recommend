<%@ page import="link.thinkonweb.configuration.SystemConstants" %>
<%@ taglib prefix="customTagFile" tagdir="/WEB-INF/tags" %>
<%@ include file="/WEB-INF/views/includes/headerForAjax.jsp" %>

<div id="manuscriptsList-t">
	
	<table class="table table-bordered" id="manuscriptsListTable">
		<thead>
		<tr role="row" class="filter">
			<c:if test="${num == 1 }">
				<td></td>
			</c:if>
			<c:if test="${temporaryId == 1}">
				<td class="cellCenter temporaryId">
					<input type="text" class="form-control form-filter form-filterTemporaryId input-sm">
				</td>
			</c:if>
			<c:if test="${submitId == 1}">
				<td class="cellCenter">
					<input type="text" class="form-control form-filter form-filterSubmitId input-sm">
				</td>
			</c:if>
			<c:if test="${submitter == 1}">
				<td class="cellCenter">
					<input type="text" class="form-control form-filter form-filterSubmitter input-sm">
				</td>
			</c:if>
			<c:if test="${institution == 1}">
				<td class="cellCenter">
					<input type="text" class="form-control form-filter form-filterInstitution input-sm">
				</td>
			</c:if>
			<c:if test="${revision == 1}">
				<td class="cellCenter">
				</td>
			</c:if>
			<c:if test="${title == 1}">
				<td class="cellCenter">
					<input type="text" class="form-control form-filter form-filterTitle input-sm">
				</td>
			</c:if>
			<c:if test="${submitDate == 1}">
				<td class="cellCenter">
					<div class="input-group date date-picker margin-bottom-5" data-date-format="yyyy-mm-dd">
						<input type="text" class="form-control form-filterSubmissionDateFrom input-sm" value="${today }" placeholder="From">
						<span class="input-group-btn">
							<button class="btn btn-sm default" type="button"><i class="fa fa-calendar"></i></button>
						</span>
					</div>
					<div class="input-group date date-picker" data-date-format="yyyy-mm-dd">
						<input type="text" class="form-control form-filterSubmissionDateTo input-sm" value="${today }" placeholder="To">
						<span class="input-group-btn">
							<button class="btn btn-sm default" type="button"><i class="fa fa-calendar"></i></button>
						</span>
					</div>
				</td>
			</c:if>
			<c:if test="${acceptDate == 1}">
				<td class="cellCenter">
					<div class="input-group date date-picker margin-bottom-5" data-date-format="yyyy-mm-dd">
						<input type="text" class="form-control form-filterAcceptanceDateFrom input-sm" value="${today }" placeholder="From">
						<span class="input-group-btn">
							<button class="btn btn-sm default" type="button"><i class="fa fa-calendar"></i></button>
						</span>
					</div>
					<div class="input-group date date-picker" data-date-format="yyyy-mm-dd">
						<input type="text" class="form-control form-filterAcceptanceDateTo input-sm" value="${today }" placeholder="To">
						<span class="input-group-btn">
							<button class="btn btn-sm default" type="button"><i class="fa fa-calendar"></i></button>
						</span>
					</div>
				</td>
			</c:if>
			<c:if test="${reviewResult == 1}">
				<td></td>
			</c:if>
			<c:if test="${reviewers == 1}">
				<td></td>
			</c:if>
			<c:if test="${chiefEditor == 1}">
				<td></td>
			</c:if>
			<c:if test="${manager == 1}">
				<td></td>
			</c:if>
			<c:if test="${associateEditor == 1}">
				<td></td>
			</c:if>
			<c:if test="${guestEditor == 1}">
				<td></td>
			</c:if>
			<c:if test="${status == 1}">
				<td></td>
			</c:if>
		</tr>
		<tr>
			<c:if test="${num == 1 }">
				<th class="cellCenter">
					<spring:message code='manager.backup.column.0'/>
				</th>
			</c:if>
			<c:if test="${temporaryId == 1}">
				<th class="cellCenter temporaryId">
					<spring:message code='manager.backup.column.1'/>
				</th>
			</c:if>
			<c:if test="${submitId == 1}">
				<th class="cellCenter">
					<spring:message code='manager.backup.column.2'/>
				</th>
			</c:if>
			<c:if test="${submitter == 1}">
				<th class="cellCenter">
					<spring:message code='manager.backup.column.3'/>
				</th>
			</c:if>
			<c:if test="${institution == 1}">
				<th class="cellCenter">
					<spring:message code='manager.backup.column.4'/>
				</th>
			</c:if>
			<c:if test="${revision == 1}">
				<th class="cellCenter">
					<spring:message code='manager.backup.column.5'/>
				</th>
			</c:if>
			<c:if test="${title == 1}">
				<th class="cellCenter">
					<spring:message code='manager.backup.column.6'/>
				</th>
			</c:if>
			<c:if test="${submitDate == 1}">
				<th class="cellCenter">
					<spring:message code='manager.backup.column.7'/>
				</th>
			</c:if>
			<c:if test="${acceptDate == 1}">
				<th class="cellCenter">
					<spring:message code='manager.backup.column.8'/>
				</th>
			</c:if>
			<c:if test="${reviewResult == 1}">
				<th class="cellCenter">
					<spring:message code='manager.backup.column.9'/>
				</th>
			</c:if>
			<c:if test="${reviewers == 1}">
				<th class="cellCenter">
					<spring:message code='manager.backup.column.10'/>
				</th>
			</c:if>
			<c:if test="${chiefEditor == 1}">
				<th class="cellCenter">
					<spring:message code='manager.backup.column.11'/>
				</th>
			</c:if>
			<c:if test="${manager == 1}">
				<th class="cellCenter">
					<spring:message code='manager.backup.column.12'/>
				</th>
			</c:if>
			<c:if test="${associateEditor == 1}">
				<th class="cellCenter">
					<spring:message code='manager.backup.column.13'/>
				</th>
			</c:if>
			<c:if test="${guestEditor == 1}">
				<th class="cellCenter">
					<spring:message code='manager.backup.column.14'/>
				</th>
			</c:if>
			<c:if test="${status == 1}">
				<th class="cellCenter">
					<spring:message code='manager.backup.column.15'/>
				</th>
			</c:if>
		</tr>
		</thead>
		<tbody>
		</tbody>
	</table>
</div>
<div id="manuscriptsList-v"></div>
<c:set var="ajaxRequestUrl" value="${baseUrl}/journals/${jnid}/manager/configuration/backup/getPapers"/>
<c:set var="parameters" value=""/>
<c:if test="${num == 1 }">
	<c:set var="parameters" value="${parameters}&num=1"/>
</c:if>
<c:if test="${temporaryId == 1 }">
	<c:set var="parameters" value="${parameters}&temporaryId=1"/>
</c:if>
<c:if test="${submitId == 1 }">
	<c:set var="parameters" value="${parameters}&submitId=1"/>
</c:if>
<c:if test="${submitter == 1 }">
	<c:set var="parameters" value="${parameters}&submitter=1"/>
</c:if>
<c:if test="${institution == 1 }">
	<c:set var="parameters" value="${parameters}&institution=1"/>
</c:if>
<c:if test="${revision == 1 }">
	<c:set var="parameters" value="${parameters}&revision=1"/>
</c:if>
<c:if test="${title == 1 }">
	<c:set var="parameters" value="${parameters}&title=1"/>
</c:if>
<c:if test="${submitDate == 1 }">
	<c:set var="parameters" value="${parameters}&submitDate=1"/>
</c:if>
<c:if test="${acceptDate == 1 }">
	<c:set var="parameters" value="${parameters}&acceptDate=1"/>
</c:if>
<c:if test="${reviewResult == 1 }">
	<c:set var="parameters" value="${parameters}&reviewResult=1"/>
</c:if>
<c:if test="${reviewers == 1 }">
	<c:set var="parameters" value="${parameters}&reviewers=1"/>
</c:if>
<c:if test="${chiefEditor == 1 }">
	<c:set var="parameters" value="${parameters}&chiefEditor=1"/>
</c:if>
<c:if test="${manager == 1 }">
	<c:set var="parameters" value="${parameters}&manager=1"/>
</c:if>
<c:if test="${associateEditor == 1 }">
	<c:set var="parameters" value="${parameters}&associateEditor=1"/>
</c:if>
<c:if test="${guestEditor == 1 }">
	<c:set var="parameters" value="${parameters}&guestEditor=1"/>
</c:if>
<c:if test="${status == 1 }">
	<c:set var="parameters" value="${parameters}&status=1"/>
</c:if>

<c:set var="filterIndex" value="1"/>
<script>
var tableViewId = "";
var viewId = "";
var firstTabWidth = 0;
var manuscriptId = "${manuscriptId}";
var pageType = "${pageType}";
var v = "${v}";
var currentManuscriptId = 0;
if(v != null && v != "") {
   	var tabName = pageType;
   	$('ul.nav-tabs').children('li').removeClass('active');
   	$('.mainTab').removeClass("active");
   	var $lis = $('ul.nav-tabs').children('li');
   	var anchors = $('.tabClick');
   	for(var i=0; i<anchors.length; i++) {
   		var href = anchors[i].getAttribute("href");
   		var name = href.replace("#", "");
   		if(name == pageType) {
   			var li = anchors[i].parentNode;
   			li.className += " active";
   			$('#' + pageType).addClass("active");
   			location.hash = "#" + pageType;
   		}
   	}
	viewManuscript(Number(manuscriptId), pageType, v);
} else {
	var href = location.href;
	var hrefArray = href.split("#");
	var hs;
	if(hrefArray.length > 1) {
		var hrefArray2 = hrefArray[1].split("-");
		if(hrefArray2.length > 1)
			hs = "#" + hrefArray2[0];
		else
			hs = "#" + hrefArray[1];
	} else
		hs = "#manuscriptsList";
	location.hash = hs;
}
$(window).hashchange( function() {
    var h = location.hash;
    if(h.trim() == '')
    	location.href=document.referrer;
    
    var t = h.split("-");
    var tabName = t[0].replace("#", "");
    if(t.length == 1) {
    	$('ul.nav-tabs').children('li').removeClass('active');
    	$('.mainTab').removeClass("active");
    	var $lis = $('ul.nav-tabs').children('li');
    	var anchors = $('.tabClick');
    	for(var i=0; i<anchors.length; i++) {
    		var href = anchors[i].getAttribute("href");
    		var name = href.replace("#", "");
    		if(name == tabName) {
    			var li = anchors[i].parentNode;
    			li.className += " active";
    			$('#' + tabName).addClass("active");
    			location.hash = "#" + tabName;
    		}
    	}
    	$('#' + tabName + '-v').hide();
    	$('#' + tabName + '-t').show('normal');
    }
});
$(window).hashchange();


function viewManuscript(manuscriptId, pageType, v) {
	$('.searchOptionsField').hide('normal');
	tableViewId = '#' + pageType + '-t';
	viewId = '#' + pageType + '-v';
	document.location.hash = viewId;
	$(tableViewId).hide();
	$(viewId).html('<div class="loadingCenter"><img src="images/loading.gif"/></div>').show();	
	var url = "${baseUrl}/journals/${jnid}/${currentPageRole}/manuscripts/" + pageType + "/viewManuscript?manuscriptId=" + manuscriptId + "&v=" + v;
	jQuery.ajax({
		type:"GET",
		url: url,
		success:function(html){
			$(viewId).hide();
			$(viewId).html(html).show('normal');
		}
	}); 
}


jQuery(document).ready(function() {  
	var totalViewIndex = "${totalViewIndex}";
	var url = "${ajaxRequestUrl}";
	var parameters = "${parameters}";
	parameters = parameters.replace("&", "?");
	
	var oTable = $('#manuscriptsListTable').dataTable({ 
       	"sDom": "<'row'<'col-md-6 col-sm-12'lp><'col-md-6 col-sm-12'fT>>rti",
        "tableTools": {
        	"sSwfPath": "${baseUrl}/js/roles/manager/copy_csv_xls_pdf.swf",
            "aButtons": [
                "copy",
                /* {
                	"sButtonText": "<i class='fa fa-file-excel-o'></i>",
                    "sExtends": "ajax",
                    "sToolTip": "Download Excel File",
            		"fnClick": function( nButton, oConfig ) {
            			location.href="${baseUrl}/journals/${jnid}/download/template/copyright";
            		},
                }, */
                {
                    "sExtends": "pdf",
                    "sTitle": "${journal.title}",
                    "sPdfOrientation": "landscape",
                    "sToolTip": "Download Pdf File",
                },
                "print"
            ]
        },

       	"sPaginationType": "bootstrap_extended",
		"oSearch": {
			"sSearch": "",
			"bSmart" : true,
			"bCaseInsensitive" : true
		},
        "sFilter": true,
        "bFilter": true,
        "bInfo": true,
        "bAutoWidth": false,
        "aLengthMenu": [
            [10, 20, 50, 100, -1],	  
            [10, 20, 50, 100, "All"] 
        ],
        "bDeferRender": true,
        "iDisplayStart": 0,
        "iDisplayLength": 10, 
        "bProcessing": true,
        "bPaginate": true,
        "bServerSide": true, 
        "sAjaxSource": url + parameters,
        "aaSorting": [[ 1, "asc" ]], 
        "aoColumnDefs": [
                         <c:forEach var="index" begin="0" end="${totalViewIndex}" step="1">	
                         { "sClass": "cellCenter", "aTargets": [ Number("${index}") ] },
                         </c:forEach>
                         ],
        "aoColumns": [
						<c:if test="${num == 1}">
                        { "bSortable": false, "sWidth": "50px"},
                        </c:if>
                        <c:if test="${temporaryId == 1}">
                        { "bSortable": true,"sWidth": "80px"},
                        </c:if>
                        <c:if test="${submitId == 1}">
                        { "bSortable": true,"sWidth": "120px"},
                        </c:if>
                        <c:if test="${submitter == 1}">
                        { "bSortable": true, "sWidth": "120px"},
                        </c:if>
                        <c:if test="${institution == 1}">
                        { "bSortable": true, "sWidth": "120px"},
                        </c:if>
                        <c:if test="${revision == 1}">
                        { "bSortable": true, "sWidth": "100px"},
                        </c:if>
                        <c:if test="${title == 1}">
                        { "bSortable": true},
                        </c:if>
                        <c:if test="${submitDate == 1}">
                        { "bSortable": true, "sWidth": "100px"},
                        </c:if>
                        <c:if test="${acceptDate == 1}">
                        { "bSortable": true, "sWidth": "100px"},
                        </c:if>
                        <c:if test="${reviewResult == 1}">
                        { "bSortable": false, "sWidth": "100px"},
                        </c:if>
                        <c:if test="${reviewers == 1}">
                        { "bSortable": false, "sWidth": "120px"},
                        </c:if>
                        <c:if test="${chiefEditor == 1}">
                        { "bSortable": false, "sWidth": "100px"},
                        </c:if>
                        <c:if test="${manager == 1}">
                        { "bSortable": false, "sWidth": "100px"},
                        </c:if>
                        <c:if test="${associateEditor == 1}">
                        { "bSortable": false, "sWidth": "100px"},
                        </c:if>
                        <c:if test="${guestEditor == 1}">
                        { "bSortable": false, "sWidth": "100px"},
                        </c:if>
                        <c:if test="${status == 1}">
                        { "bSortable": false, "sWidth": "70px"},
						</c:if>
                     ],
        "fnServerParams": function (aoData) {
        },
    });
	
	$('#manuscriptsListTable_wrapper .dataTables_length select').select2({
		containerCssClass: "form-control width100 marginRight15"
	});

	var selectedValue = "";
	$(".statusSelect > option:selected").each(function() {
		selectedValue += $(this).val() + ",";
	});
	$('.statusSelect > button > .filter-option').text('<spring:message code="manager.config.selectStatus"/>');
	$('.form-filterStatus').val(selectedValue);
	oTable.fnFilter( selectedValue, 0);
	
	$('.statusSelect > button > .filter-option').text('<spring:message code="manager.config.selectStatus"/>');
    $('select.statusSelect').change(function(event) {
    	var selectedValue = "";
    	$(".statusSelect > option:selected").each(function() {
    		selectedValue += $(this).val() + ",";
    	});
    	$('.statusSelect > button > .filter-option').text('<spring:message code="manager.config.selectStatus"/>');
    	$('.form-filterStatus').val(selectedValue);
    	oTable.fnFilter( selectedValue, 0);

    });
	
	<c:if test="${temporaryId == 1 }">
	$(".form-filterTemporaryId").on("keyup change", function () {
		oTable.fnFilter( this.value, Number("${filterIndex}"));
	});
	<c:set var="filterIndex" value="${filterIndex + 1}"/>
	</c:if>
	<c:if test="${submitId == 1 }">
	$(".form-filterSubmitId").on("keyup change", function () {
		oTable.fnFilter( this.value, Number("${filterIndex}"));
	});
	<c:set var="filterIndex" value="${filterIndex + 1}"/>
	</c:if>
	<c:if test="${submitter == 1}">
	$(".form-filterSubmitter").on("keyup change", function () {
		oTable.fnFilter( this.value, Number("${filterIndex}"));
		
	});
	<c:set var="filterIndex" value="${filterIndex + 1}"/>
	</c:if>
	<c:if test="${institution == 1}">
	$(".form-filterInstitution").on("keyup change", function () {
		oTable.fnFilter( this.value, Number("${filterIndex}"));
		
	});
	<c:set var="filterIndex" value="${filterIndex + 1}"/>
	</c:if>
	<c:if test="${title == 1}">
	$(".form-filterTitle").on("keyup change", function () {
		oTable.fnFilter( this.value, Number("${filterIndex}"));
	});
	<c:set var="filterIndex" value="${filterIndex + 1}"/>
	</c:if>
	<c:if test="${submitDate == 1}">
	$(".form-filterSubmissionDateFrom").on("change", function () {
		var from = $(this).val();
		$('.form-filterSubmissionDateFrom').val(from);
		var to = $('.form-filterSubmissionDateTo').val();
		oTable.fnFilter( from + "_" + to, Number("${filterIndex}"));
	});
	
	$(".form-filterSubmissionDateTo").on("change", function () {
		var from = $('.form-filterSubmissionDateFrom').val();
		var to = $(this).val();
		$('.form-filterSubmissionDateto').val(to);
		oTable.fnFilter( from + "_" + to, Number("${filterIndex}"));
	});
	<c:set var="filterIndex" value="${filterIndex + 1}"/>
	</c:if>
	<c:if test="${acceptDate == 1}">
	$(".form-filterAcceptanceDateFrom").on("change", function () {
		var from = $(this).val();
		$('.form-filterAcceptanceDateFrom').val(from);
		var to = $('.form-filterAcceptanceDateTo').val();
		oTable.fnFilter( from + "_" + to, Number("${filterIndex}"));
	});

	$(".form-filterAcceptanceDateTo").on("change", function () {
		var from = $('.form-filterAcceptanceDateFrom').val();
		var to = $(this).val();
		$('.form-filterAcceptanceDateto').val(to);
		oTable.fnFilter( from + "_" + to, Number("${filterIndex}"));
	});
	<c:set var="filterIndex" value="${filterIndex + 1}"/>
	</c:if>
	
	$('.tabClick').click(function(event) {
		var h = $(this).attr('href');
		var tabName = h.replace("#", "");
		location.hash = $(this).attr('href');
	});
	
	$('.date-picker').datepicker({
		language: 'en',
		autoclose: true
	});
	
	firstTabWidth = $('.tabClick:first').parent("li").width();
});  
</script>
