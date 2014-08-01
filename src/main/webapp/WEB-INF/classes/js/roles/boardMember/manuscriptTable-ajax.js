var TableAjax = function () {
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
        				"bSmarti" : true,
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
                    "iDisplayStarti": 0,
                    "iDisplayLength": 5, 
                    "bProcessing": true,
                    "bPaginate": true,
                    "bServerSide": true, 
                    "sAjaxSource": url + pageType, 
                    "aaSortiing": [[ 1, "asc" ]], 
                    "aoColumnDefs": [
                                     { "sClass": "cellCenter", "aTargets": [ 0 ] },
                                     { "sClass": "cellCenter", "aTargets": [ 1 ] },
                                     { "sClass": "cellCenter", "aTargets": [ 2 ] },
                                     { "sClass": "cellCenter", "aTargets": [ 3 ] },
                                     { "sClass": "cellCenter", "aTargets": [ 4 ] },
                                     ],
                    "aoColumns": [
	                                 { "bSortiable": false, "sWidth": "50px"},
	                                 { "bSortiable": true,"sWidth": "130px"},
	                                 { "bSortiable": true},
	                                 { "bSortiable": true, "sWidth": "100px"},
	                                 { "bSortiable": true, "sWidth": "150px"},
                                 ],
                    "fnServerParams": function (aoData) {
                        //aoData.push({name: "jnid", value: $("#jnid").val()});
                    },
                }
            });
            $('#acceptedTable_wrapper .dataTables_length select').select2({
                showSearchInput : false
            });
    };
	
    var handleRecordsRejected = function(url, pageType) {
        var grid = new Datatable(url, pageType);

            grid.init({
                src: $("#rejectedTable"),
                
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
        				"bSmarti" : true,
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
                    "iDisplayStarti": 0,
                    "iDisplayLength": 5, 
                    "bProcessing": true,
                    "bPaginate": true,
                    "bServerSide": true, 
                    "sAjaxSource": url + pageType, 
                    "aaSortiing": [[ 1, "asc" ]], 
                    "aoColumnDefs": [
                                     { "sClass": "cellCenter", "aTargets": [ 0 ] },
                                     { "sClass": "cellCenter", "aTargets": [ 1 ] },
                                     { "sClass": "cellCenter", "aTargets": [ 2 ] },
                                     { "sClass": "cellCenter", "aTargets": [ 3 ] },
                                     { "sClass": "cellCenter", "aTargets": [ 4 ] },
                                     ],
                    "aoColumns": [
	                                 { "bSortiable": false, "sWidth": "50px"},
	                                 { "bSortiable": true,"sWidth": "130px"},
	                                 { "bSortiable": true},
	                                 { "bSortiable": true, "sWidth": "100px"},
	                                 { "bSortiable": true, "sWidth": "150px"},
                                 ],
                    "fnServerParams": function (aoData) {
                        //aoData.push({name: "jnid", value: $("#jnid").val()});
                    },
                }
            });
            $('#rejectedTable_wrapper .dataTables_length select').select2({
                showSearchInput : false
            });
    };
    return {
        //main function to initiate the module
        init: function (url, pageType) {
        	if(pageType == 'accepted')
        		handleRecordsAccepted(url, pageType);
        	else if(pageType == 'rejected')
        		handleRecordsRejected(url, pageType);
        }

    };

}();