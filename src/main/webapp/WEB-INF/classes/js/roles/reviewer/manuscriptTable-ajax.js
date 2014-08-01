var TableAjax = function () {
    var handleRecordsAssigned = function(url, pageType) {
        var grid = new Datatable(url, pageType);

            grid.init({
                src: $("#assignedTable"),
                
                onSuccess: function(grid) {
                    // execute some code after table records loaded
                },
                onError: function(grid) {
                    // execute some code on network or other general error  
                },
                dataTable: {  // here you can define a typical datatable settings from http://datatables.net/usage/options 
                   	"sDom": "<'row'<'col-md-6 col-sm-12'lp><'col-md-6 col-sm-12'f>>rti",
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
                        [5, 20, 50, 100],
                        [5, 20, 50, 100]
                    ],
                    "bDeferRender": true,
                    "iDisplayStart": 0,
                    "iDisplayLength": 5, 
                    "bProcessing": true,
                    "bPaginate": true,
                    "bServerSide": true, 
                    "sAjaxSource": url + pageType, 
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
                                     { "bSortable": false, "sWidth": "60px"},
                                     { "bSortable": true,"sWidth": "130px"},
                                     { "bSortable": true,"sWidth": "100px"},
                                     { "bSortable": true},
                                     { "bSortable": true, "sWidth": "100px"},
                                     { "bSortable": true, "sWidth": "100px"},
                                     { "bSortable": false, "sWidth": "100px"},
                                 ],
                    "fnServerParams": function (aoData) {
                        //aoData.push({name: "jnid", value: $("#jnid").val()});
                    },
                }
            });
            $('.select2-container').addClass("marginRight30"); // modify table per page dropdown
    };
    var handleRecordsCompleted = function(url, pageType) {
        var grid = new Datatable(url, pageType);

            grid.init({
                src: $("#completedTable"),
                
                onSuccess: function(grid) {
                    // execute some code after table records loaded
                },
                onError: function(grid) {
                    // execute some code on network or other general error  
                },
                dataTable: {  // here you can define a typical datatable settings from http://datatables.net/usage/options 
                   	"sDom": "<'row'<'col-md-6 col-sm-12'lp><'col-md-6 col-sm-12'f>>rti",
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
                        [5, 20, 50, 100],
                        [5, 20, 50, 100]
                    ],
                    "bDeferRender": true,
                    "iDisplayStart": 0,
                    "iDisplayLength": 5, 
                    "bProcessing": true,
                    "bPaginate": true,
                    "bServerSide": true, 
                    "sAjaxSource": url + pageType, 
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
									 { "bSortable": false, "sWidth": "60px"},
									 { "bSortable": true, "sWidth": "130px"},
									 { "bSortable": true, "sWidth": "130px"},
									 { "bSortable": true},
									 { "bSortable": true, "sWidth": "100px"},
									 { "bSortable": false, "sWidth": "100px"},
									 { "bSortable": true, "sWidth": "100px"},
                                 ],
                    "fnServerParams": function (aoData) {
                        //aoData.push({name: "jnid", value: $("#jnid").val()});
                    },
                }
            });
            $('.select2-container').addClass("marginRight30"); // modify table per page dropdown
    };
    
    var handleRecordsDismissed = function(url, pageType) {
        var grid = new Datatable(url, pageType);

            grid.init({
                src: $("#dismissedTable"),
                
                onSuccess: function(grid) {
                    // execute some code after table records loaded
                },
                onError: function(grid) {
                    // execute some code on network or other general error  
                },
                dataTable: {  // here you can define a typical datatable settings from http://datatables.net/usage/options 
                   	"sDom": "<'row'<'col-md-6 col-sm-12'lp><'col-md-6 col-sm-12'f>>rti",
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
                        [5, 20, 50, 100],
                        [5, 20, 50, 100]
                    ],
                    "bDeferRender": true,
                    "iDisplayStart": 0,
                    "iDisplayLength": 5, 
                    "bProcessing": true,
                    "bPaginate": true,
                    "bServerSide": true, 
                    "sAjaxSource": url + pageType, 
                    "aaSorting": [[ 1, "asc" ]], 
                    "aoColumnDefs": [
                                     { "sClass": "cellCenter", "aTargets": [ 0 ] },
                                     { "sClass": "cellCenter", "aTargets": [ 1 ] },
                                     { "sClass": "cellCenter", "aTargets": [ 2 ] },
                                     { "sClass": "cellCenter", "aTargets": [ 3 ] },
                                     { "sClass": "cellCenter", "aTargets": [ 4 ] },
                                     { "sClass": "cellCenter", "aTargets": [ 5 ] },
                                     ],
                    "aoColumns": [
									 { "bSortable": false, "sWidth": "60px"},
									 { "bSortable": true, "sWidth": "130px"},
									 { "bSortable": true, "sWidth": "130px"},
									 { "bSortable": true},
									 { "bSortable": true, "sWidth": "120px"},
									 { "bSortable": true, "sWidth": "120px"},
                                 ],
                    "fnServerParams": function (aoData) {
                        //aoData.push({name: "jnid", value: $("#jnid").val()});
                    },
                }
            });
            $('.select2-container').addClass("marginRight30"); // modify table per page dropdown
    };

    return {
        init: function (url, pageType) {
        	if(pageType == 'assigned')
        		handleRecordsAssigned(url, pageType);
        	else if(pageType == 'completed')	
        		handleRecordsCompleted(url, pageType);
        	else if(pageType == 'dismissed')	
        		handleRecordsDismissed(url, pageType);

        }

    };

}();