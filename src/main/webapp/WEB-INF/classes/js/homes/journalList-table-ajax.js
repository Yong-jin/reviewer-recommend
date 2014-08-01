var TableAjax = function () {

    var initPickers = function () {
        //init date pickers
        $('.date-picker').datepicker({
            rtl: App.isRTL(),
            autoclose: true
        });
    };

    var handleRecords = function() {
        var grid = new Datatable();
            grid.init({
                src: $("#journalList_ajax"),
                onSuccess: function(grid) {
                    // execute some code after table records loaded
                },
                onError: function(grid) {
                    // execute some code on network or other general error  
                },
                dataTable: {  // here you can define a typical datatable settings from http://datatables.net/usage/options 
                	"oLanguage": {
        				"sSearch": "<small>Search:</small>"
        			},
                    /* 
                        By default the ajax datatable's layout is horizontally scrollable and this can cause an issue of dropdown menu
                        is used in the table rows which.
                        Use below "sDom" value for the datatable layout if you want to have a dropdown menu for each row 
                        in the datatable. But this disables the horizontal scroll. 
                    */
        			//"sDom" : "<'pull-right'T><'clearfix'><'row'<'col-md-8 col-sm-12'pli><'col-md-4 col-sm-12'f>r>t<'row'<'col-md-8 col-sm-12'pli><'col-md-4 col-sm-12'>r>>",
                    //"sDom" : "<'pull-right'T><'clearfix'><'row'<'col-md-7 col-sm-12'pli><'col-md-5 col-sm-12'f>><'clearfix'><'pull-right'r>t<'row'<'col-md-8'pli><'col-md-4'>r>",
        			"sDom": "<'pull-right'T><'clearfix'><'row'<'col-md-7 col-sm-12'pli><'col-md-5 col-sm-12'f>>rtpli",
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
            					"sFileName": "journal_list.pdf",
            					"sPdfOrientation": "landscape",
            					"sPdfMessage": "Journal List of ManusciprtLink",
            				},
            				{
	            				"sExtends": "print",
	            				"sMessage": "Journal List of ManusciprtLink"
            			    },
            			],
            			"sSwfPath": "js/tabletools_media/swf/copy_csv_xls_pdf.swf",
            		},
                    "bDeferRender": true,
                    "iDisplayStart": 0,
                    "iDisplayLength": 5, 
                    "bProcessing": true,
                    "bPaginate": true,
                    "bServerSide": true, 
                    "sAjaxSource": "superManager/journalListAjax", 
                    "aaSorting": [[ 9, "desc" ],[ 10, "desc" ]], 
                    "aoColumnDefs": [
                                     { "sClass": "text-center text-middle", "aTargets": [ 0 ] },
                                     { "sClass": "text-middle dataTableID", "aTargets": [ 1 ] },
                                     { "sClass": "text-middle", "aTargets": [ 2 ] },
                                     { "sClass": "text-middle", "aTargets": [ 3 ] },
                                     { "sClass": "text-middle", "aTargets": [ 4 ] },
                                     { "sClass": "text-middle", "aTargets": [ 5 ] },
                                     { "sClass": "text-middle", "aTargets": [ 6 ] },
                                     { "sClass": "text-center text-middle", "aTargets": [ 7 ] },
                                     { "sClass": "text-center text-middle", "aTargets": [ 8 ] },
                                     { "sClass": "text-center text-middle", "aTargets": [ 9 ] },
                                     { "sClass": "text-middle", "aTargets": [ 10 ] },
                                     { "sClass": "text-middle", "aTargets": [ 11 ] },
                                     { "sClass": "text-middle", "aTargets": [ 12 ] },
                                     { "sClass": "text-middle", "aTargets": [ 13 ] },
                                     ],
                    "aoColumns": [
	                                 { "bSortable": false, "bSearchable": false, "sWidth": "40px" },
	                                 { "sWidth": "75px"},
	                                 { "sWidth": "110px"},
	                                 { "sWidth": "100px"},
	                                 { "sWidth": "80px"},
	                                 { "sWidth": "115px"},
	                                 { "sWidth": "115px"},
	                                 { "sWidth": "85px" },
	                                 { "sWidth": "85px"},
	                                 { "sWidth": "65px"},
	                                 { "sWidth": "65px"},
	                                 { "bSortable": false, "bSearchable": false, "sWidth": "96px"},
	                                 { "sWidth": "80px"},
	                                 { "bSortable": false, "bSearchable": false, "sWidth": "75px"},
                                 ],
                    "fnServerParams": function (aoData) {
                        aoData.push({name: "myOption", value: "11111"});
                    },
                }
            });
            
            /*
            // handle group actionsubmit button click
            grid.getTableWrapper().on('click', '.table-group-action-submit', function(e){
                e.preventDefault();
                var action = $(".table-group-action-input", grid.getTableWrapper());
                if (action.val() != "" && grid.getSelectedRowsCount() > 0) {
                	alertObjectReflection(grid);
                    grid.addAjaxParam("sAction", "group_action");
                    grid.addAjaxParam("sGroupActionName", action.val());
                    var records = grid.getSelectedRows();
                    for (var i in records) {
                        grid.addAjaxParam(records[i]["name"], records[i]["value"]);    
                    }
                    grid.getDataTable().fnDraw();
                    grid.clearAjaxParams();
                } else if (action.val() == "") {
                    App.alert({type: 'danger', icon: 'warning', message: 'Please select an action', container: grid.getTableWrapper(), place: 'prepend'});
                } else if (grid.getSelectedRowsCount() === 0) {
                    App.alert({type: 'danger', icon: 'warning', message: 'No record selected', container: grid.getTableWrapper(), place: 'prepend'});
                }
            });
            */
    };

    return {

        //main function to initiate the module
        init: function () {
            initPickers();
            handleRecords();
        }

    };

}();