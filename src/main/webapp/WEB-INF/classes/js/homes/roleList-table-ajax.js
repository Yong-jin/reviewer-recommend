var TableAjax = function () {
    var handleRecords = function() {
        var grid = new Datatable();
            grid.init({
                src: $("#roleList_ajax"),
                onSuccess: function(grid) {
                    // execute some code after table records loaded
                },
                onError: function(grid) {
                },
                dataTable: {  // here you can define a typical datatable settings from http://datatables.net/usage/options 
                	"oLanguage": {
                		"sSearch": "<small>Search Email, Name or Institution:</small>"
        			},
                    /* 
                        By default the ajax datatable's layout is horizontally scrollable and this can cause an issue of dropdown menu
                        is used in the table rows which.
                        Use below "sDom" value for the datatable layout if you want to have a dropdown menu for each row 
                        in the datatable. But this disables the horizontal scroll. 
                    */
        			//"sDom" : "<'pull-right'T><'clearfix'><'row'<'col-md-8 col-sm-12'pli><'col-md-4 col-sm-12'f>r>t<'row'<'col-md-8 col-sm-12'pli><'col-md-4 col-sm-12'>r>>",
                    //"sDom" : "<'pull-right'T><'clearfix'><'row'<'col-md-7 col-sm-12'pli><'col-md-5 col-sm-12'f>><'clearfix'><'pull-right'r>t<'row'<'col-md-8'pli><'col-md-4'>r>",
        			"sDom": "<'pull-right'T><'clearfix'><'pull-right'f><'row'<'col-md-8'pli>>r",
        			//"sDom" : "<'pull-right'T><'clearfix'>lr",
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
                        [5, 20, 50, 100, 200],	  
                        [5, 20, 50, 100, 200] 
                    ],
                    "oTableTools": {
            			"aButtons": [
            			    {
	            				"sExtends": "copy",
            			    },
            			    {
	            				"sExtends": "csv",
            			    },
            			    //{
	            			//	"sExtends": "xls",
            			    //},
            				{
            					"sExtends": "pdf",
            					"sFileName": "role_list.pdf",
            					"sPdfOrientation": "landscape",
            					"sPdfMessage": "Role List of ManusciprtLink",
            				},
            				{
	            				"sExtends": "print",
	            				"sMessage": "Role List of ManusciprtLink"
            			    },
            			],
            			"sSwfPath": "js/tabletools_media/swf/copy_csv_xls_pdf.swf",
            		},
                    "bDeferRender": true,
                    "iDisplayStart": 0,
                    "iDisplayLength": 20, 
                    "bProcessing": true,
                    "bPaginate": true,
                    "bServerSide": true, 
                    "sAjaxSource": "superManager/roleListAjax", 
                    "aaSorting": [[ 5, "desc" ]], 
                    "aoColumnDefs": [
                                     { "sClass": "text-center text-middle", "aTargets": [ 0 ] },
                                     { "sClass": "text-middle dataTableID", "aTargets": [ 1 ] },
                                     { "sClass": "text-middle", "aTargets": [ 2 ] },
                                     { "sClass": "text-middle", "aTargets": [ 3 ] },
                                     { "sClass": "text-center text-middle", "aTargets": [ 4 ] },
                                     { "sClass": "text-center text-middle", "aTargets": [ 5 ] },
                                     { "sClass": "text-right text-middle", "aTargets": [ 6 ] },
                                     { "sClass": "text-right text-middle", "aTargets": [ 7 ] },
                                     { "sClass": "text-right text-middle", "aTargets": [ 8 ] },
                                     { "sClass": "text-right text-middle", "aTargets": [ 9 ] },
                                     { "sClass": "text-right text-middle", "aTargets": [ 10 ] },
                                     { "sClass": "text-right text-middle", "aTargets": [ 11 ] },
                                     { "sClass": "text-right text-middle", "aTargets": [ 12 ] },
                                     { "sClass": "text-middle", "aTargets": [ 13 ] },
                                     ],
                    "aoColumns": [
	                                 { "bSortable": false, "bSearchable": false, "sWidth": "40px" },
	                                 { "bSortable": true, "bSearchable": false },
	                                 { "sWidth": "67px"},
	                                 { "sWidth": "67px"},
	                                 { "sWidth": "80px"},
	                                 { "bSortable": true, "bSearchable": false, "sWidth": "90px"},
	                                 { "bSortable": true, "bSearchable": false, "sWidth": "90px" },
	                                 { "bSortable": true, "bSearchable": false, "sWidth": "90px" },
	                                 { "bSortable": true, "bSearchable": false, "sWidth": "90px" },
	                                 { "bSortable": true, "bSearchable": false, "sWidth": "90px" },
	                                 { "bSortable": true, "bSearchable": false, "sWidth": "90px" },
	                                 { "bSortable": true, "bSearchable": false, "sWidth": "90px" },
	                                 { "bSortable": true, "bSearchable": false, "sWidth": "90px" },
	                                 { "bSortable": false, "bSearchable": false, "sWidth": "74px"},
                              ],
                    "fnServerParams": function (aoData) {
                        aoData.push({name: "jnid", value: $("#journalNameId").val()});
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