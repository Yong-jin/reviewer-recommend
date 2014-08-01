var TableAjax = function (url) {

    var handleRecords = function(url) {
        var grid = new Datatable(url);
        
            grid.init({
                src: $("#accountsTable"),
                onSuccess: function(grid) {
                    // execute some code after table records loaded
                },
                onError: function(grid) {
                    // execute some code on network or other general error  
                },
                dataTable: {  // here you can define a typical datatable settings from http://datatables.net/usage/options 
                   	"sDom": "<'row'<'col-md-6 col-sm-12'lp><'col-md-6 col-sm-12'f>>rt",
                   	"sPaginationType": "bootstrap_extended",
                 	"oSearch": {
        				"sSearch": "",
        				"bSmart" : true,
        				"bCaseInsensitive" : true
        			},
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
	                                 { "bSortable": false, "bSearchable": false, "sWidth": "40px" },
	                                 { "bSortable": true, "bSearchable": true, "sWidth": "200px" },
	                                 { "bSortable": true, "bSearchable": true},
	                                 { "bSortable": true, "bSearchable": true},
	                                 { "bSortable": true, "bSearchable": true},
	                                 { "bSortable": false, "bSearchable": true},
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
        init: function (url) {
            handleRecords(url);
        }

    };

}();