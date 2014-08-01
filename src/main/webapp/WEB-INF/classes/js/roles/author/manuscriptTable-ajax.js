var TableAjax = function (url, pageType) {
    var handleRecordsBeingSubmitted = function(url, pageType) {
        var grid = new Datatable(url, pageType);

            grid.init({
                src: $("#beingSubmittedTable"),
                
                onSuccess: function(grid) {
                    // execute some code after table records loaded
                },
                onError: function(grid) {
                    // execute some code on network or other general error  
                },
                dataTable: {  // here you can define a typical datatable settings from http://datatables.net/usage/options 
                   	//"sDom": "<'row'<'col-md-7 col-sm-12'li><'col-md-5 col-sm-12'f>>rti<'row'<'col-md-5 col-sm-12'i><'col-md-7 col-sm-12'p>>",
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
                                     ],
                    "aoColumns": [
	                                 { "bSortable": false, "sWidth": "50px"},
	                                 { "bSortable": true, "sWidth": "120px"},
									 { "bSortable": false, "sWidth": "100px"},
	                                 { "bSortable": true},
	                                 { "bSortable": false, "sWidth": "130px"},
                                 ],
                    "fnServerParams": function (aoData) {
                        //aoData.push({name: "jnid", value: $("#jnid").val()});
                    },
                }
            });
    };
    
    var handleRecordsSubmitted = function(url, pageType) {
        var grid = new Datatable(url, pageType);

            grid.init({
                src: $("#submittedTable"),
                
                onSuccess: function(grid) {
                    // execute some code after table records loaded
                },
                onError: function(grid) {
                    // execute some code on network or other general error  
                },
                dataTable: {  // here you can define a typical datatable settings from http://datatables.net/usage/options 
                   	//"sDom": "<'row'<'col-md-7 col-sm-12'li><'col-md-5 col-sm-12'f>>rti<'row'<'col-md-5 col-sm-12'i><'col-md-7 col-sm-12'p>>",
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
	                                 { "bSortable": false, "sWidth": "50px"},
									 { "bSortable": true, "sWidth": "120px"},
	                                 { "bSortable": false, "sWidth": "130px"},
	                                 { "bSortable": true},
	                                 { "bSortable": true,"sWidth": "100px"},
	                                 { "bSortable": true, "sWidth": "140px"},
	                                 { "bSortable": false, "sWidth": "130px"},
                                 ],
                    "fnServerParams": function (aoData) {
                        //aoData.push({name: "jnid", value: $("#jnid").val()});
                    },
                }
            });
    };
    var handleRecordsRevisionRequested = function(url, pageType) {
        var grid = new Datatable(url, pageType);

            grid.init({
                src: $("#revisionRequestedTable"),
                
                onSuccess: function(grid) {
                    // execute some code after table records loaded
                },
                onError: function(grid) {
                    // execute some code on network or other general error  
                },
                dataTable: {  // here you can define a typical datatable settings from http://datatables.net/usage/options 
                   	//"sDom": "<'row'<'col-md-7 col-sm-12'li><'col-md-5 col-sm-12'f>>rti<'row'<'col-md-5 col-sm-12'i><'col-md-7 col-sm-12'p>>",
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
									 { "sClass": "cellCenter", "aTargets": [ 7 ] },
                                     ],
                    "aoColumns": [
	                                 { "bSortable": false, "sWidth": "50px"},
									 { "bSortable": true, "sWidth": "100px"},
	                                 { "bSortable": false, "sWidth": "100px"},
	                                 { "bSortable": true},
	                                 { "bSortable": true,"sWidth": "100px"},
	                                 { "bSortable": true,"sWidth": "100px"},
	                                 { "bSortable": false, "sWidth": "140px"},
	                                 { "bSortable": false, "sWidth": "130px"},
                                 ],
                    "fnServerParams": function (aoData) {
                        //aoData.push({name: "jnid", value: $("#jnid").val()});
                    },
                }
            });
    };
    var handleRecordsAccepted = function(url, pageType) {
        var grid = new Datatable(url, pageType);

            grid.init({
                src: $("#acceptedTable"),
                
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
									 { "sClass": "cellCenter", "aTargets": [ 7 ] },
									 { "sClass": "cellCenter", "aTargets": [ 8 ] },

                                     ],
                    "aoColumns": [
	                                 { "bSortable": false, "sWidth": "50px"},
									 { "bSortable": true, "sWidth": "100px"},
	                                 { "bSortable": false, "sWidth": "100px"},
	                                 { "bSortable": true},
	                                 { "bSortable": true,"sWidth": "100px"},
	                                 { "bSortable": true, "sWidth": "100px"},
	                                 { "bSortable": true, "sWidth": "90px"},
	                                 { "bSortable": true, "sWidth": "150px"},
	                                 { "bSortable": false, "sWidth": "130px"},

                                 ],
                    "fnServerParams": function (aoData) {
                        //aoData.push({name: "jnid", value: $("#jnid").val()});
                    },
                }
            });
    };
	
    var handleRecordsPublished = function(url, pageType) {
        var grid = new Datatable(url, pageType);

            grid.init({
                src: $("#publishedTable"),
                
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
	                                 { "bSortable": false, "sWidth": "50px"},
									 { "bSortable": true, "sWidth": "100px"},
	                                 { "bSortable": false, "sWidth": "100px"},
	                                 { "bSortable": true},
	                                 { "bSortable": true,"sWidth": "100px"},
	                                 { "bSortable": true,"sWidth": "150px"},
	                                 { "bSortable": false, "sWidth": "60px"},

                                 ],
                    "fnServerParams": function (aoData) {
                        //aoData.push({name: "jnid", value: $("#jnid").val()});
                    },
                }
            });
    };

    var handleRecordsWithdrawn = function(url, pageType) {
        var grid = new Datatable(url, pageType);

            grid.init({
                src: $("#withdrawnTable"),
                
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
	                                 { "bSortable": false, "sWidth": "50px"},
									 { "bSortable": true, "sWidth": "100px"},
	                                 { "bSortable": false, "sWidth": "100px"},
	                                 { "bSortable": true},
	                                 { "bSortable": true,"sWidth": "100px"},
	                                 { "bSortable": true,"sWidth": "150px"},
	                                 { "bSortable": true, "sWidth": "120px"},

                                 ],
                    "fnServerParams": function (aoData) {
                        //aoData.push({name: "jnid", value: $("#jnid").val()});
                    },
                }
            });
    };
    return {

        //main function to initiate the module
        init: function (url, pageType) {
        	if(pageType == 'beingSubmitted')
        		handleRecordsBeingSubmitted(url, pageType);
        	else if(pageType == 'submitted')
        		handleRecordsSubmitted(url, pageType);
        	else if(pageType == 'revisionRequested')
        		handleRecordsRevisionRequested(url, pageType);
        	else if(pageType == 'accepted')
        		handleRecordsAccepted(url, pageType);
        	else if(pageType == 'published')
        		handleRecordsPublished(url, pageType);
        	else if(pageType == 'withdrawn')
        		handleRecordsWithdrawn(url, pageType);
        }

    };

}();