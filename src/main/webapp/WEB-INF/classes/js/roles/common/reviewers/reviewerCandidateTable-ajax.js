var ReviewerTableAjax = function () {
    var handleRecordsBoardMember = function(ajaxRequestUrl, pageType, member) {
        var grid = new Datatable(ajaxRequestUrl, pageType, member);

            grid.init({
                src: $("#" + pageType + "reviewerTable1"),
                onSuccess: function(grid) {
                    // execute some code after table records loaded
                },
                onError: function(grid) {
                    // execute some code on network or other general error  
                },
                dataTable: {  // here you can define a typical datatable settings from http://datatables.net/usage/options 
                   	"sDom": "<'row form-section_noborder_table'<'col-md-6 col-sm-12'lp><'col-md-6 col-sm-12'f>>rt",
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
                        [10, 20, 50, 100],	  
                        [10, 20, 50, 100] 
                    ],
                    "bDeferRender": true,
                    "iDisplayStart": 0,
                    "iDisplayLength": 10, 
                    "bProcessing": true,
                    "bPaginate": true,
                    "bServerSide": true, 
                    "sAjaxSource": ajaxRequestUrl, 
                    "aaSorting": [[ 1, "asc" ]], 
                    "aoColumnDefs": [
                                     { "sClass": "cellCenter", "aTargets": [ 0 ] },
                                     { "sClass": "cellCenter", "aTargets": [ 1 ] },
                                     { "sClass": "cellCenter", "aTargets": [ 2 ] },
                                     { "sClass": "cellCenter", "aTargets": [ 3 ] },
                                     { "sClass": "cellCenter", "aTargets": [ 4 ] },
                                     { "sClass": "cellCenter", "aTargets": [ 5 ] },
                                     { "sClass": "cellCenter", "aTargets": [ 6 ] },
                                     { "sClass": "cellCenter", "aTargets": [ 7 ] },
                                     ],
                    "aoColumns": [
	                                 { "bSortable": false, "bSearchable": false, "sWidth": "40px" },
	                                 { "bSortable": true, "bSearchable": true, "sWidth": "150px" },
	                                 { "bSortable": true, "bSearchable": true},
	                                 { "bSortable": true, "bSearchable": true, "sWidth": "110px" },
	                                 { "bSortable": false, "bSearchable": true},
	                                 { "bSortable": false, "bSearchable": false},
	                                 { "bSortable": false, "bSearchable": false},
	                                 { "bSortable": false, "bSearchable": false, "sWidth": "80px" },
                                 ],
                    "fnServerParams": function (aoData) {
                        //aoData.push({name: "firstDivision", value: $('#firstDivision').val()});
                    },
                }
            });
            $('.select2-container').addClass("marginRight30"); // modify table per page dropdown
    };
    
    var handleRecordsMember = function(ajaxRequestUrl, pageType, member) {
        var grid = new Datatable(ajaxRequestUrl, pageType, member);

            grid.init({
                src: $("#" + pageType + "reviewerTable2"),
                onSuccess: function(grid) {
                    // execute some code after table records loaded
                },
                onError: function(grid) {
                    // execute some code on network or other general error  
                },
                dataTable: {  // here you can define a typical datatable settings from http://datatables.net/usage/options 
                   	"sDom": "<'row form-section_noborder_table'<'col-md-6 col-sm-12'lp><'col-md-6 col-sm-12'f>>rt",
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
                        [10, 20, 50, 100],	  
                        [10, 20, 50, 100] 
                    ],
                    "bDeferRender": true,
                    "iDisplayStart": 0,
                    "iDisplayLength": 10, 
                    "bProcessing": true,
                    "bPaginate": true,
                    "bServerSide": true, 
                    "sAjaxSource": ajaxRequestUrl, 
                    "aaSorting": [[ 1, "asc" ]], 
                    "aoColumnDefs": [
                                     { "sClass": "cellCenter", "aTargets": [ 0 ] },
                                     { "sClass": "cellCenter", "aTargets": [ 1 ] },
                                     { "sClass": "cellCenter", "aTargets": [ 2 ] },
                                     { "sClass": "cellCenter", "aTargets": [ 3 ] },
                                     { "sClass": "cellCenter", "aTargets": [ 4 ] },
                                     { "sClass": "cellCenter", "aTargets": [ 5 ] },
                                     { "sClass": "cellCenter", "aTargets": [ 6 ] },
                                     ],
                    "aoColumns": [
	                                 { "bSortable": false, "bSearchable": false, "sWidth": "40px" },
	                                 { "bSortable": true, "bSearchable": true, "sWidth": "150px" },
	                                 { "bSortable": true, "bSearchable": true},
	                                 { "bSortable": true, "bSearchable": true},
	                                 { "bSortable": false, "bSearchable": false},
	                                 { "bSortable": false, "bSearchable": false},
	                                 { "bSortable": false, "bSearchable": false, "sWidth": "80px" },
                                 ],
                    "fnServerParams": function (aoData) {
                        aoData.push({name: "jnid", value: $(".jnid").val()});
                    },
                }
            });
            $('.select2-container').addClass("marginRight30"); // modify table per page dropdown
    };
    
    var handleRecordsNonMember = function(ajaxRequestUrl, pageType, member) {
        var grid = new Datatable(ajaxRequestUrl, pageType, member);

            grid.init({
            	src: $("#" + pageType + "reviewerTable3"),
                onSuccess: function(grid) {
                    // execute some code after table records loaded
                },
                onError: function(grid) {
                    // execute some code on network or other general error  
                },
                dataTable: {  // here you can define a typical datatable settings from http://datatables.net/usage/options 
                	"sDom": "<'row form-section_noborder_table'<'col-md-6 col-sm-12'lp><'col-md-6 col-sm-12'f>>rt",
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
                        [10, 20, 50, 100],	  
                        [10, 20, 50, 100] 
                    ],
                    "bDeferRender": true,
                    "iDisplayStart": 0,
                    "iDisplayLength": 10, 
                    "bProcessing": true,
                    "bPaginate": true,
                    "bServerSide": true, 
                    "sAjaxSource": ajaxRequestUrl, 
                    "aaSorting": [[ 1, "asc" ]], 
                    "aoColumnDefs": [
                                     { "sClass": "cellCenter", "aTargets": [ 0 ] },
                                     { "sClass": "cellCenter", "aTargets": [ 1 ] },
                                     { "sClass": "cellCenter", "aTargets": [ 2 ] },
                                     { "sClass": "cellCenter", "aTargets": [ 3 ] },
                                     { "sClass": "cellCenter", "aTargets": [ 4 ] },
                                     { "sClass": "cellCenter", "aTargets": [ 5 ] },
                                     { "sClass": "cellCenter", "aTargets": [ 6 ] },
                                     ],
                    "aoColumns": [
	                                 { "bSortable": false, "bSearchable": false, "sWidth": "40px" },
	                                 { "bSortable": true, "bSearchable": true, "sWidth": "150px" },
	                                 { "bSortable": true, "bSearchable": true},
	                                 { "bSortable": true, "bSearchable": true},
	                                 { "bSortable": false, "bSearchable": false},
	                                 { "bSortable": false, "bSearchable": false},
	                                 { "bSortable": false, "bSearchable": false, "sWidth": "80px" },
                                 ],
                    "fnServerParams": function (aoData) {
                        aoData.push({name: "jnid", value: $("#jnid").val()});
                    },
                }
            });
            $('.select2-container').addClass("marginRight30"); // modify table per page dropdown
    };
    
    var handleRecordsRp = function(ajaxRequestUrl, pageType, member) {
        var grid = new Datatable(ajaxRequestUrl, pageType, member);

            grid.init({
            	src: $("#" + pageType + "reviewerTable4"),
                onSuccess: function(grid) {
                    // execute some code after table records loaded
                },
                onError: function(grid) {
                    // execute some code on network or other general error  
                },
                dataTable: {  // here you can define a typical datatable settings from http://datatables.net/usage/options 
                	"sDom": "<'row form-section_noborder_table'<'col-md-6 col-sm-12'lp><'col-md-6 col-sm-12'f>>rt",
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
                        [10, 20, 50, 100],	  
                        [10, 20, 50, 100] 
                    ],
                    "bDeferRender": true,
                    "iDisplayStart": 0,
                    "iDisplayLength": 10, 
                    "bProcessing": true,
                    "bPaginate": true,
                    "bServerSide": true, 
                    "sAjaxSource": ajaxRequestUrl, 
                    "aaSorting": [[ 1, "asc" ]], 
                    "aoColumnDefs": [
                                     { "sClass": "cellCenter", "aTargets": [ 0 ] },
                                     { "sClass": "cellCenter", "aTargets": [ 1 ] },
                                     { "sClass": "cellCenter", "aTargets": [ 2 ] },
                                     { "sClass": "cellCenter", "aTargets": [ 3 ] },
                                     { "sClass": "cellCenter", "aTargets": [ 4 ] },
                                     { "sClass": "cellCenter", "aTargets": [ 5 ] },
                                     { "sClass": "cellCenter", "aTargets": [ 6 ] },
                                     ],
                    "aoColumns": [
	                                 { "bSortable": false, "bSearchable": false, "sWidth": "40px" },
	                                 { "bSortable": false, "bSearchable": true, "sWidth": "150px" },
	                                 { "bSortable": false, "bSearchable": true},
	                                 { "bSortable": false, "bSearchable": true},
	                                 { "bSortable": false, "bSearchable": false},
	                                 { "bSortable": false, "bSearchable": false},
	                                 { "bSortable": false, "bSearchable": false, "sWidth": "80px" },
                                 ],
                    "fnServerParams": function (aoData) {
                        aoData.push({name: "jnid", value: $("#jnid").val()});
                    },
                }
            });
            $('.select2-container').addClass("marginRight30"); // modify table per page dropdown
    };

    return {

        //main function to initiate the module
        init: function (ajaxRequestUrl, pageType, member) {
        	if(member == 1)
        		handleRecordsBoardMember(ajaxRequestUrl, pageType, member);
        	else if(member == 2)
        		handleRecordsMember(ajaxRequestUrl, pageType, member);
        	else if(member == 3)
        		handleRecordsNonMember(ajaxRequestUrl, pageType, member);
        	else if(member == 4)
        		handleRecordsRp(ajaxRequestUrl, pageType, member);
        	
        }

    };

}();