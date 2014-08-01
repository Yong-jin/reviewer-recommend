var TableEditable = function () {

    return {
    	
        //main function to initiate the module
        init: function () {

        	   var oTable = $('#coAuthorCandidates').dataTable({
        		   //"sDom": "<'row'<'col-md-2 col-sm-12'l><'col-md-4 col-sm-12'p>>rt",
        		   "sDom": "<'row'<'col-md-6 col-sm-12'lp>>rt",
        	       "aLengthMenu": [
        	           [5, 15, 20],
        	           [5, 15, 20] // change per page values here
        	       ],
        	       // set the initial value
        	       "iDisplayLength": 5,
        	       
        	       "sPaginationType": "bootstrap_extended",

        	       "sInfo": "",
        	       "aoColumnDefs": [
        	                        { "sClass": "cellCenter", "aTargets": [ 0 ] },
        	                        { "sClass": "cellCenter", "aTargets": [ 1 ] },
        	                        { "sClass": "cellCenter", "aTargets": [ 2 ] },
        	                        { "sClass": "cellCenter", "aTargets": [ 3 ] },
        	                        { "sClass": "cellCenter", "aTargets": [ 4 ] },
        	                        ],
        	       "aoColumns": [
        	                        { "bSortable": true},
        	                        { "bSortable": true},
        	                        { "bSortable": true},
        	                        { "bSortable": true},
        	                        { "bSortable": false},
        	                    ],
        	   });
        		//oTable.fnFilter( 'abb' );

        	   //jQuery('#coAuthorCandidates_wrapper .dataTables_filter input').addClass("form-control input-medium input-inline"); // modify table search input
        	   //alert(jQuery('#coAuthorCandidates_wrapper .dataTables_filter input').val());
        		//jQuery('#coAuthorCandidates_wrapper .dataTables_filter input').attr("placeholder", "Search in results");

        	   jQuery('#coAuthorCandidates_wrapper .dataTables_length select').addClass("form-control input-small marginRight30"); // modify table per page dropdown
        	   jQuery('#coAuthorCandidates_wrapper .dataTables_length select').select2({
        	       showSearchInput : false //hide search box with special css class
        	   }); // initialize select2 dropdown
        }

    };

}();