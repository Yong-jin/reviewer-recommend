var TableEditable = function () {

    return {
    	
        //main function to initiate the module
        init: function () {

            var oTable = $('#dTable').dataTable({
                "aLengthMenu": [
                    [5, 15, 20],
                    [5, 15, 20] // change per page values here
                ],
                // set the initial value
                "iDisplayLength": 10,
                "sDom": "<'row'<'col-md-6 col-sm-12'l><'col-md-6 col-sm-12'f>r><'.table-scrollable-dropdown't><'row'<'col-md-5 col-sm-12'i><'col-md-7 col-sm-12'p>>", // horizobtal scrollable datatable
                "sSearch:" : "Search: ",
                "sPaginationType": "bootstrap",
                "oLanguage": {
                    "sLengthMenu": "_MENU_ records",
                    "oPaginate": {
                        "sPrevious": "Prev",
                        "sNext": "Next"
                    }
                }
                //,"aoColumnDefs": [{
                //        'bSortable': true,
                //        'aTargets': [0]
                //    }
                //]
            });

            jQuery('#dTable_wrapper .dataTables_filter input').addClass("form-control input-medium input-inline"); // modify table search input
            jQuery('#dTable_wrapper .dataTables_length select').addClass("form-control input-small"); // modify table per page dropdown
            jQuery('#dTable_wrapper .dataTables_length select').select2({
                showSearchInput : false //hide search box with special css class
            }); // initialize select2 dropdown



        }

    };

}();