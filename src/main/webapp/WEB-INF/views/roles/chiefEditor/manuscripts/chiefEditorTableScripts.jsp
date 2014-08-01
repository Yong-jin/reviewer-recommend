<script>
	var TableAjax = function () {
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
                        <c:if test="${journal.type == 'A' or journal.type == 'B'}">
	                    "aoColumnDefs": [
	                                     { "sClass": "cellCenter", "aTargets": [ 0 ] },
	                                     { "sClass": "cellCenter", "aTargets": [ 1 ] },
	                                     { "sClass": "cellCenter", "aTargets": [ 2 ] },
	                                     { "sClass": "cellCenter", "aTargets": [ 3 ] },
	                                     { "sClass": "cellCenter", "aTargets": [ 4 ] },
	                                     ],
	                    "aoColumns": [
		                                 { "bSortable": false, "sWidth": "50px"},
		                                 { "bSortable": true,"sWidth": "110px"},
		                                 { "bSortable": true},
		                                 { "bSortable": true, "sWidth": "100px"},
		                                 { "bSortable": false, "sWidth": "130px"},
	                                 ],
                         </c:if>
                        <c:if test="${journal.type == 'C' or journal.type == 'D'}">
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
                                          { "bSortable": false, "sWidth": "60px"},
                                          { "bSortable": true,  "sWidth": "100px"},
                                          { "bSortable": true},
                                          { "bSortable": true, "sWidth": "100px"},
                                          { "bSortable": false, "sWidth": "70px"},
                                          { "bSortable": false, "sWidth": "120px"},
                                          { "bSortable": false, "sWidth": "125px"},
                                          { "bSortable": false, "sWidth": "100px"},
                                      ],
                         </c:if>
	                    "fnServerParams": function (aoData) {
	                        //aoData.push({name: "jnid", value: $("#jnid").val()});
	                    },
	                }
	            });
	            $('#submittedTable_wrapper .dataTables_length select').select2({
	                showSearchInput : false
	            });
	    };
		
	    var handleRecordsAESelection = function(url, pageType) {
	        var grid = new Datatable(url, pageType);

	            grid.init({
	                src: $("#aeSelectionTable"),
	                
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
		                                 { "bSortable": false, "sWidth": "50px"},
		                                 { "bSortable": true, "sWidth": "110px"},
		                                 { "bSortable": true},
		                                 { "bSortable": true, "sWidth": "100px"},
		                                 { "bSortable": false, "sWidth": "100px"},
		                                 { "bSortable": false, "sWidth": "100px"},
	                                 ],
	                    "fnServerParams": function (aoData) {
	                        //aoData.push({name: "jnid", value: $("#jnid").val()});
	                    },
	                }
	            });
	            $('#aeSelectionTable_wrapper .dataTables_length select').select2({
	                showSearchInput : false
	            });
	    };
		
	    var handleRecordsRevisionSubmitted = function(url, pageType) {
	        var grid = new Datatable(url, pageType);

	            grid.init({
	                src: $("#revisionSubmittedTable"),
	                
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
	                                     ],
	                    "aoColumns": [
		                                 { "bSortable": false, "sWidth": "50px"},
		                                 { "bSortable": true,"sWidth": "110px"},
		                                 { "bSortable": true},
		                                 { "bSortable": true, "sWidth": "100px"},
		                                 { "bSortable": true, "sWidth": "100px"},
		                                 { "bSortable": false, "sWidth": "110px"},
		                                 { "bSortable": false, "sWidth": "100px"},
		                                 { "bSortable": false, "sWidth": "130px"},
	                                 ],
	                    "fnServerParams": function (aoData) {
	                        //aoData.push({name: "jnid", value: $("#jnid").val()});
	                    },
	                }
	            });
	            $('#revisionSubmittedTable_wrapper .dataTables_length select').select2({
	                showSearchInput : false
	            });
	    };
		
	    var handleRecordsInReview = function(url, pageType) {
	        var grid = new Datatable(url, pageType);

	            grid.init({
	                src: $("#underReviewTable"),
	                
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
	                                     ],
	                    "aoColumns": [
		                                 { "bSortable": false, "sWidth": "50px"},
		                                 { "bSortable": true, "sWidth": "110px"},
		                                 { "bSortable": true},
		                                 { "bSortable": true, "sWidth": "100px"},
		                                 { "bSortable": true, "sWidth": "100px"},
		                                 { "bSortable": false, "sWidth": "110px"},
		                                 { "bSortable": false, "sWidth": "100px"},
										 								 { "bSortable": false, "sWidth": "100px"},

	                                 ],
	                    "fnServerParams": function (aoData) {
	                        //aoData.push({name: "jnid", value: $("#jnid").val()});
	                    },
	                }
	            });
	            $('#underReviewTable_wrapper .dataTables_length select').select2({
	                showSearchInput : false
	            });
	    };
	    
	    var handleRecordsFinalDecisionRequired = function(url, pageType) {
	        var grid = new Datatable(url, pageType);

	            grid.init({
	                src: $("#finalDecisionRequiredTable"),
	                
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
	                                     { "sClass": "cellCenter", "aTargets": [ 9 ] },
	                                     ],
	                    "aoColumns": [
		                                 { "bSortable": false, "sWidth": "50px"},
		                                 { "bSortable": true, "sWidth": "90px"},
		                                 { "bSortable": true},
		                                 { "bSortable": true, "sWidth": "100px"},
		                                 { "bSortable": true, "sWidth": "90px"},
		                                 { "bSortable": false, "sWidth": "130px"},
		                                 { "bSortable": false, "sWidth": "100px"},
		                                 { "bSortable": false, "sWidth": "100px"},
		                                 { "bSortable": false, "sWidth": "80px"},
										 								 { "bSortable": false, "sWidth": "130px"},
	                                 ],
	                    "fnServerParams": function (aoData) {
	                        //aoData.push({name: "jnid", value: $("#jnid").val()});
	                    },
	                }
	            });
	            $('#finalDecisionRequiredTable_wrapper .dataTables_length select').select2({
	                showSearchInput : false
	            });
	    };
	    
	    var handleRecordsReSubmitted = function(url, pageType) {
	        var grid = new Datatable(url, pageType);
	        	
	            grid.init({
	                src: $("#reSubmittedTable"),
	                
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
	                    "bDeferRender": false,
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
	                                     { "bSortable": false, "sWidth": "60px"},
	                                     { "bSortable": true,"sWidth": "100px"},
	                                     { "bSortable": true},
	                                     { "bSortable": true, "sWidth": "100px"},
	                                     { "bSortable": false, "sWidth": "70px"},
	                                     { "bSortable": false, "sWidth": "120px"},
	                                     { "bSortable": false, "sWidth": "125px"},
	                                     { "bSortable": false, "sWidth": "100px"},
	                                 ],
	                    "fnServerParams": function (aoData) {
	                        //aoData.push({name: "jnid", value: $("#jnid").val()});
	                    },
	                }
	            });
	            $('#reSubmittedTable_wrapper .dataTables_length select').addClass("form-control input-small marginRight30"); // modify table per page dropdown
	            $('#reSubmittedTable_wrapper .dataTables_length select').select2({
	                showSearchInput : false //hide search box with special css class
	            }); // initialize select2 dropdown
	    };
	    
	    var handleRecordsOther = function(url, pageType) {
	        var grid = new Datatable(url, pageType);

	            grid.init({
	                src: $("#otherTable"),
	                
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
		                                 { "bSortable": true, "sWidth": "110px"},
		                                 { "bSortable": true},
		                                 { "bSortable": true, "sWidth": "100px"},
		                                 { "bSortable": false, "sWidth": "100px"},
		                                 { "bSortable": false, "sWidth": "80px"},
		                                 { "bSortable": true, "sWidth": "150px"},
	                                 ],
	                    "fnServerParams": function (aoData) {
	                        //aoData.push({name: "jnid", value: $("#jnid").val()});
	                    },
	                }
	            });
	            $('#otherTable_wrapper .dataTables_length select').select2({
	                showSearchInput : false
	            });
	    };


	    return {

	        //main function to initiate the module
	        init: function (url, pageType) {
	        	if(pageType == 'submitted')
	        		handleRecordsSubmitted(url, pageType);
	        	else if(pageType == 'reSubmitted')
	        		handleRecordsReSubmitted(url, pageType);
	        	else if(pageType == 'revisionSubmitted')
	        		handleRecordsRevisionSubmitted(url, pageType);
	        	else if(pageType == 'underReview')
	        		handleRecordsInReview(url, pageType);
	        	else if(pageType == 'aeSelection')
	        		handleRecordsAESelection(url, pageType);
	        	else if(pageType == 'finalDecisionRequired')
	        		handleRecordsFinalDecisionRequired(url, pageType);
	        	else if(pageType == 'other')
	        		handleRecordsOther(url, pageType);
	        }
	    };
	}();
</script>