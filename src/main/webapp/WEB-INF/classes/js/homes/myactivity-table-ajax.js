var TableAjax1 = function () {
    var handleRecords = function() {
        var grid = new Datatable();
            grid.init({
                src: $("#myActivity_journalList_ajax"),
                onSuccess: function(grid) {
                    // execute some code after table records loaded
                },
                onError: function(grid) {
                },
                dataTable: {
                   	"sDom": "<'row'<'col-md-7 col-sm-12'pli><'col-md-5 col-sm-12'f>>rt",
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
                    "sAjaxSource": "activity/journalListAjax", 
                    "aaSorting": [[ 4, "asc" ]], 
                    "aoColumnDefs": [
                                     { "sClass": "text-center text-middle", "aTargets": [ 0 ] },
                                     { "sClass": "text-middle dataTableID", "aTargets": [ 1 ] },
                                     { "sClass": "text-center text-middle", "aTargets": [ 2 ] },
                                     { "sClass": "text-center text-middle", "aTargets": [ 3 ] },
                                     { "sClass": "text-center text-middle", "aTargets": [ 4 ] },
                                     { "sClass": "text-center text-middle", "aTargets": [ 5 ] },
                                     { "sClass": "text-center text-middle", "aTargets": [ 6 ] },
                                     ],
                    "aoColumns": [
	                                 { "bSortable": false, "bSearchable": false, "sWidth": "40px" },
	                                 { "bSortable": true, "bSearchable": false },
	                                 { "bSortable": true, "bSearchable": false, "sWidth": "150px" },
	                                 { "bSortable": true, "bSearchable": false, "sWidth": "90px" },
	                                 { "bSortable": true, "bSearchable": false, "sWidth": "130px" },
	                                 { "bSortable": true, "bSearchable": false, "sWidth": "120px" },
	                                 { "bSortable": false, "bSearchable": false },
	                              ],
                    "fnServerParams": function (aoData) {
                        aoData.push({name: "username", value: $('#username_var').val()});
                        aoData.push({name: "numberOfjournalsInMember", value: $('#numberOfjournalsInMember').val()});
                    },
                }
            });
    };

    return {
        //main function to initiate the module
        init: function () {
            handleRecords();
        }
    };
}();

var TableAjax2 = function () {
    var handleRecords2 = function() {
        var grid = new Datatable();
            grid.init({
                src: $("#myActivity_manuscriptList_ajax"),
                onSuccess: function(grid) {
                    // execute some code after table records loaded
                },
                onError: function(grid) {
                	
                },
                dataTable: {
                	"oLanguage": {
        				"sSearch": "<small>Search:</small>"
        			},
                   	"sDom": "<'row'<'col-md-7 col-sm-12'pli><'col-md-5 col-sm-12'f>>rt",
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
                    "sAjaxSource": "activity/manuscriptListAjax", 
                    "aaSorting": [[ 7, "desc" ]], 
                    "aoColumnDefs": [
                                     { "sClass": "text-center text-middle", "aTargets": [ 0 ] },
                                     { "sClass": "text-center text-middle dataTableID", "aTargets": [ 1 ] },
                                     { "sClass": "text-center text-middle", "aTargets": [ 2 ] },
                                     { "sClass": "text-center text-middle", "aTargets": [ 3 ] },
                                     { "sClass": "text-center text-middle", "aTargets": [ 4 ] },
                                     { "sClass": "text-center text-middle", "aTargets": [ 5 ] },
                                     { "sClass": "text-center text-middle", "aTargets": [ 6 ] },
                                     { "sClass": "text-center text-middle", "aTargets": [ 7 ] },
                                     { "sClass": "text-center text-middle", "aTargets": [ 8 ] },
                                     { "sClass": "text-center text-middle", "aTargets": [ 9 ] },
                                     ],
                    "aoColumns": [
	                                 { "bSortable": false, "bSearchable": false, "sWidth": "35px" },
	                                 { "bSortable": true,  "bSearchable": false },
	                                 { "bSortable": true,  "bSearchable": false, "sWidth": "125px" },
	                                 { "bSortable": true,  "bSearchable": false, "sWidth": "75px" },
	                                 { "bSortable": true,  "bSearchable": false, "sWidth": "95px" },
	                                 { "bSortable": true,  "bSearchable": false, "sWidth": "95px" },
	                                 { "bSortable": true,  "bSearchable": false, "sWidth": "135px" },
	                                 { "bSortable": true,  "bSearchable": false, "sWidth": "100px" },
	                                 { "bSortable": true,  "bSearchable": false, "sWidth": "115px" },
	                                 { "bSortable": true,  "bSearchable": false, "sWidth": "145px" },
	                              ],
                    "fnServerParams": function (aoData) {
                        aoData.push({name: "username", value: $('#username_var').val()});
                        aoData.push({name: "numberOfCoWrittenManuscriptsInMember", value: $('#numberOfCoWrittenManuscriptsInMember').val()});
                    },
                }
            });
    };

    return {
        //main function to initiate the module
        init: function () {
            handleRecords2();
        }
    };
}();

var TableAjax3 = function () {
    var handleRecords3 = function() {
        var grid = new Datatable();
            grid.init({
                src: $("#myActivity_reviewManuscriptList_ajax"),
                onSuccess: function(grid) {
                    // execute some code after table records loaded
                },
                onError: function(grid) {
                	
                },
                dataTable: {
                	"oLanguage": {
        				"sSearch": "<small>Search:</small>"
        			},
                   	"sDom": "<'row'<'col-md-7 col-sm-12'pli><'col-md-5 col-sm-12'f>>rt",
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
                    "sAjaxSource": "activity/manuscriptReviewListAjax", 
                    //"aaSorting": [[ 5, "asc" ]], 
                    "aoColumnDefs": [
                                     { "sClass": "text-center text-middle", "aTargets": [ 0 ] },
                                     { "sClass": "text-middle dataTableID", "aTargets": [ 1 ] },
                                     { "sClass": "text-center text-middle", "aTargets": [ 2 ] },
                                     { "sClass": "text-center text-middle", "aTargets": [ 3 ] },
                                     { "sClass": "text-center text-middle", "aTargets": [ 4 ] },
                                     { "sClass": "text-center text-middle", "aTargets": [ 5 ] },
                                     { "sClass": "text-center text-middle", "aTargets": [ 6 ] },
                                     { "sClass": "text-center text-middle", "aTargets": [ 7 ] },
                                     { "sClass": "text-center text-middle", "aTargets": [ 8 ] },                                     
                                     ],
                    "aoColumns": [
	                                 { "bSortable": false, "bSearchable": false, "sWidth": "40px" },
	                                 { "bSortable": true,  "bSearchable": false },
	                                 { "bSortable": true,  "bSearchable": false, "sWidth": "150px" },
	                                 { "bSortable": true,  "bSearchable": false, "sWidth": "100px" },
	                                 { "bSortable": true,  "bSearchable": false, "sWidth": "105px" },
	                                 { "bSortable": true,  "bSearchable": false, "sWidth": "105px" },
	                                 { "bSortable": true,  "bSearchable": false, "sWidth": "105px" },	                                 
	                                 { "bSortable": true,  "bSearchable": false, "sWidth": "120px" },
	                                 { "bSortable": true,  "bSearchable": false, "sWidth": "100px" },
	                              ],
                    "fnServerParams": function (aoData) {
                        aoData.push({name: "username", value: $('#username_var').val()});
                        aoData.push({name: "numberOfReviewMenuscriptsInMember", value: $('#numberOfReviewMenuscriptsInMember').val()});
                    },
                }
            });
    };

    return {
        //main function to initiate the module
        init: function () {
            handleRecords3();
        }
    };
}();


var TableAjax4 = function () {
    var handleRecords4 = function() {
        var grid = new Datatable();
            grid.init({
                src: $("#myActivity_feedsList_ajax"),
                onSuccess: function(grid) {
                    // execute some code after table records loaded
                },
                onError: function(grid) {
                	
                },
                dataTable: {
                	"oLanguage": {
        				"sSearch": "<small>Search:</small>"
        			},
                   	"sDom": "<'row'<'col-md-7 col-sm-12'pli><'col-md-5 col-sm-12'f>>rt",
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
                    "sAjaxSource": "activity/feedsListAjax", 
                    "aaSorting": [[ 2, "desc" ],[ 3, "desc" ]], 
                    "aoColumnDefs": [
                                     { "sClass": "text-center text-middle", "aTargets": [ 0 ] },
                                     { "sClass": "text-middle", "aTargets": [ 1 ] },
                                     { "sClass": "text-center text-middle", "aTargets": [ 2 ] },
                                     { "sClass": "text-center text-middle", "aTargets": [ 3 ] },
                                     ],
                    "aoColumns": [
                                     { "bSortable": false, "sWidth": "50px"},
                                     { "bSortable": true},
                                     { "bSortable": true, "sWidth": "100px"},
                                     { "bSortable": true, "sWidth": "100px"},
                                     
                                 ],
                    "fnServerParams": function (aoData) {
                    },
                }
            });
    };

    return {
        //main function to initiate the module
        init: function () {
            handleRecords4();
        }
    };
}();