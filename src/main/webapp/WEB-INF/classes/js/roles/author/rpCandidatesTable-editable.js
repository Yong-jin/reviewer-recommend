var TableEditable = function () {

	return {

		//main function to initiate the module
		init: function () {
			var oTable = $('#candidateReviewers').dataTable({
				"sDom": "<'row'<'col-md-6 col-sm-12'lp>>rt",


				"aLengthMenu": [
					[5, 15, 20],
					[5, 15, 20] // change per page values here
				],
				// set the initial value
				"iDisplayLength": 5,
				"sPaginationType": "bootstrap_extended",
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
		                    ]
			});

			//jQuery('#candidateReviewers_wrapper .dataTables_filter input').addClass("form-control input-medium input-inline"); // modify table search input
			//jQuery('#candidateReviewers_wrapper .dataTables_filter input').attr("placeholder", "Search in results");
			jQuery('#candidateReviewers_wrapper .dataTables_length select').addClass("form-control input-small marginRight30"); // modify table per page dropdown
			jQuery('#candidateReviewers_wrapper .dataTables_length select').select2({
				showSearchInput : false //hide search box with special css class
			}); // initialize select2 dropdown

		}

	};

}();