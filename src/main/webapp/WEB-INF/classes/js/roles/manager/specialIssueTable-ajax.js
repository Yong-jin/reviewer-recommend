var TableAjax = function () {
    var handleRecords = function(url) {
        var grid = new Datatable(url);

            grid.init({
                src: $("#specialIssueTable"),
                
                onSuccess: function(grid) {
                    
                },
                onError: function(grid) {
                      
                },
                dataTable: { 
                   	"sDom": "<'row'<'col-md-6 col-sm-12'lp><'col-md-6 col-sm-12'f>>rt",
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
                    "sAjaxSource": url, 
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
	                                 { "bSortable": true},
	                                 { "bSortable": false},
	                                 { "bSortable": true, "sWidth": "100px"},
	                                 { "bSortable": true, "sWidth": "100px"},
	                                 { "bSortable": true, "sWidth": "100px"},
	                                 { "bSortable": false, "sWidth": "100px"},
	                                 
                                 ],
                    "fnServerParams": function (aoData) {
                    },
                }
            });
            $('#specialIssueTable_wrapper .dataTables_length select').select2({
                showSearchInput : false
            });
            $('#specialIssueTable_wrapper .dataTables_length select').addClass("form-control input-small marginRight30"); // modify table per page dropdown

    };

    return {
        init: function (url, pageType) {
        	handleRecords(url);
        }
    };
}();