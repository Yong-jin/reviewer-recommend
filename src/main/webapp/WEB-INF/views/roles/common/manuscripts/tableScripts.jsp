<c:set var="ajaxRequestUrl" value="${baseUrl}/journals/${jnid}/${currentPageRole }/manuscripts/getPapers/"/>
<script src="${baseUrl}/assets/plugins/jquery-validation/dist/jquery.validate.js" type="text/javascript" ></script>
<script src="${baseUrl}/assets/plugins/jquery-validation/dist/additional-methods.min.js" type="text/javascript"></script>
<script src="${baseUrl}/js/roles/jquery.fileupload.js"></script>
<script src="${baseUrl}/js/roles/datatable.js"></script>
<script src="${baseUrl}/js/roles/manuscriptTable_jquery.dataTables.js" type="text/javascript"></script>
<script src="${baseUrl}/js/roles/manuscriptTable_DT_bootstrap.js" type="text/javascript"></script>
<c:if test="${currentPageRole != 'chiefEditor' }">
<script src="${baseUrl}/js/roles/${currentPageRole }/manuscriptTable-ajax.js"></script>
</c:if>
<script src="${baseUrl}/js/roles/hashChange.js"></script>
<script>
Map = function(){
	this.map = new Object();
};  
Map.prototype = {
    put : function(key, value){  
        this.map[key] = value;
    },  
    get : function(key){  
        return this.map[key];
    },
    containsKey : function(key){   
     return key in this.map;
    },
    containsValue : function(value){   
     for(var prop in this.map){
      if(this.map[prop] == value) return true;
     }
     return false;
    },
    isEmpty : function(key){   
     return (this.size() == 0);
    },
    clear : function(){  
     for(var prop in this.map){
      delete this.map[prop];
     }
    },
    remove : function(key){   
     delete this.map[key];
    },
    keys : function(){  
        var keys = new Array();  
        for(var prop in this.map){  
            keys.push(prop);
        }  
        return keys;
    },
    values : function(){  
     var values = new Array();  
        for(var prop in this.map){  
         values.push(this.map[prop]);
        }  
        return values;
    },
    size : function(){
      var count = 0;
      for (var prop in this.map) {
        count++;
      }
      return count;
    }
};
var currentPageRole = "${currentPageRole}";
var tabStatusMap = new Map();
if(currentPageRole == 'chiefEditor') {
	<c:choose>
		<c:when test="${journal.type == 'A' or journal.type == 'B'}">
			tabStatusMap.put("submitted", true);
			<c:if test="${journal.type == 'A'}">
			tabStatusMap.put("aeSelection", false);
			tabStatusMap.put("revisionSubmitted", false);
			</c:if>
			tabStatusMap.put("underReview", false);
			tabStatusMap.put("finalDecisionRequired", false);
			tabStatusMap.put("other", false);
		</c:when>
		<c:otherwise>
			tabStatusMap.put("submitted", false);
			<c:if test="${journal.type == 'C'}">
			tabStatusMap.put("reSubmitted", false);
			</c:if>
			tabStatusMap.put("other", false);
		</c:otherwise>
	</c:choose>
} else if(currentPageRole == 'associateEditor') {
	tabStatusMap.put("assigned", true);
	tabStatusMap.put("submitted", false);
	tabStatusMap.put("reSubmitted", false);
	tabStatusMap.put("other", false);
} else if(currentPageRole == 'manager') {
	tabStatusMap.put("beingSubmitted", true);
	tabStatusMap.put("submitted", true);
	<c:if test="${journal.type == 'A' or journal.type == 'C'}">
	tabStatusMap.put("revisionRequested", false);
	tabStatusMap.put("revisionSubmitted", false);
	</c:if>
	tabStatusMap.put("underReview", false);
	tabStatusMap.put("accepted", false);
	tabStatusMap.put("published", false);
	tabStatusMap.put("withdrawn", false);
} else if(currentPageRole == 'author') {
	tabStatusMap.put("beingSubmitted", true);
	tabStatusMap.put("submitted", true);
	<c:if test="${journal.type == 'A' or journal.type == 'C'}">
	tabStatusMap.put("revisionRequested", false);
	</c:if>
	tabStatusMap.put("accepted", false);
	tabStatusMap.put("published", false);
	tabStatusMap.put("withdrawn", false);
} else if(currentPageRole == 'reviewer') {
	tabStatusMap.put("assigned", true);
	tabStatusMap.put("completed", false);
	tabStatusMap.put("dismissed", false);
} else if(currentPageRole == 'boardMember') {
	tabStatusMap.put("accepted", true);
	tabStatusMap.put("rejected", false);
} else if(currentPageRole == 'guestEditor') {
	tabStatusMap.put("submitted", true);
	tabStatusMap.put("reSubmitted", false);
	tabStatusMap.put("other", false);
}

var tableViewId = "";
var viewId = "";
var firstTabWidth = 0;
var pageType = "${pageType}";
var manuscriptId = "${manuscriptId}";
var v = "${v}";
var currentManuscriptId = 0;
var viewStatusMap = new Map();
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
		hs = "${firstTabHash}";
	location.hash = hs;
}
$(window).hashchange( function() {
    var h = location.hash;
    if(h.trim() == '')
    	location.href=document.referrer;
    	
    var t = h.split("-");
    var tabName = t[0].replace("#", "");
	
	if(!tabStatusMap.get(tabName)) {
		TableAjax.init("${ajaxRequestUrl}", tabName);
		tabStatusMap.put(tabName, true);
	}
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
	tableViewId = '#' + pageType + '-t';
	viewId = '#' + pageType + '-v';
	document.location.hash = viewId;
	viewStatusMap.put(pageType, true);
	currentManuscriptId = manuscriptId;
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

function reviewerSummaryView(manuscriptId, reviewId) {
	var reviewerSummaryViewId = '#' + manuscriptId + "_" + reviewId + 'reviewerSummaryView';
	var reviewSummaryViewId = '#' + manuscriptId + "_" + reviewId + 'reviewSummaryView';
	var reviewerSummaryViewButtonId = '#' + manuscriptId + "_" + reviewId + 'reviewSummaryButton';
	if($(reviewerSummaryViewId).css("display") != "none") {
		$(reviewerSummaryViewButtonId).html('<i class="fa fa-angle-down "></i>');
		$(reviewerSummaryViewId).hide('normal');
		$(reviewSummaryViewId).hide('normal');
	} else {
		$(reviewerSummaryViewButtonId).html('<i class="fa fa-angle-up "></i>');
		$(reviewerSummaryViewId).show('normal');
		$(reviewSummaryViewId).show('normal');
	}
}

function commentsView(manuscriptId) {
	var url = "${baseUrl}/journals/${jnid}/${currentPageRole}/manuscripts/comments";
	var data = "manuscriptId=" + manuscriptId;
	$.ajax({
		type:"GET",
		url: url,
		data: data,
		success:function(html){
			$("#commentsDisplay").html(html);
		}
	});
	$("#commentsDisplay").show('normal');
	$("#commentsDisplay").dialog("open");
}
$(document).ready(function() {
	$("#commentsDisplay").dialog({
		width: currentWidth * 0.6,
		height: currentHeight * 0.6,
		resizable: true,
		modal:true,
		autoOpen: false,
	 	show: {
			 effect: "slide",
			 duration: 500
		}
	});
	
	$('.tabClick').click(function(event) {
		var h = $(this).attr('href');
		var tabName = h.replace("#", "");
		if(viewStatusMap.get(tabName))
			location.hash = "#" + tabName + "-v";
		else {
			viewStatusMap.put(tabName, false);
			if(!tabStatusMap.get(tabName)) {
				TableAjax.init("${ajaxRequestUrl}", tabName);
				tabStatusMap.put(tabName, true);
			}
			location.hash = $(this).attr('href');
		}
	});
	
	//scrollTop
	$("#tab0, #tab1, #tab2, #tab3, #tab4, #tab5, #tab6, #tab7, #tab8, #tab9").click(function() {
		var hidden = true;
	  timer = setInterval(function(){
	      if (hidden) {
		     	if ($("#tab0").not(':hidden')) {
		     	  //alert("scroll");
		        window.scrollTo(0,0);
		        hidden = false;
		     	} else if ($("#tab0").is(':hidden')) {
		     		hidden = true;
		     	}
		    } else {
					//alert("stop");
		      clearInterval(timer);
		    }
		}, 50);
	});
	
	firstTabWidth = $('.tabClick:first').parent("li").width();
	$(".table").on("mouseenter", function () {
		$("a[rel='tooltip']").tooltip({
			'z-index': '3000',
		});	
	});
	
	$(".form-filter").on("keyup change", function () {
		oTable.fnFilter( this.value, $(".form-filter").index(this) );
	});
});
</script>