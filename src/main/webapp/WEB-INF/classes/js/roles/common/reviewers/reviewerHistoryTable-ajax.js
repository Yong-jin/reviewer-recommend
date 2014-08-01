var ReviwerHistoryTableAjax = function () {
    var handleRecords = function(url) {
        var grid = new Datatable(url);

            grid.init({
                src: $("#reviewerHistoryTable"),
                
                onSuccess: function(grid) {},
                onError: function(grid) {},
                dataTable: {
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
                    "sAjaxSource": url,
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
                                     { "bSortable": true,"sWidth": "130px"},
                                     { "bSortable": true,"sWidth": "100px"},
                                     { "bSortable": true},
                                     { "bSortable": true, "sWidth": "100px"},
                                     { "bSortable": true, "sWidth": "100px"},
                                 ],
                    "fnServerParams": function (aoData) {
                    },
                }
            });
            $('.select2-container').addClass("marginRight30"); // modify table per page dropdown
    };
    return {
        init: function (url) {
        	handleRecords(url);
        }

    };

}();