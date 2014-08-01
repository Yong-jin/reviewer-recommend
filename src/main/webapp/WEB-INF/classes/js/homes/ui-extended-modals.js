var UIExtendedModals = function () {
    return {
        //main function to initiate the module
        init: function () {
        
            // general settings
            $.fn.modal.defaults.spinner = $.fn.modalmanager.defaults.spinner = 
              '<div class="loading-spinner" style="width: 200px; margin-left: -100px;">' +
                '<div class="progress progress-striped active">' +
                  '<div class="progress-bar" style="width: 100%;"></div>' +
                '</div>' +
              '</div>';

            $.fn.modalmanager.defaults.resize = true;

            //ajax - typeA:
            var $modal = $('#typeA-modal');
            $('#ajax-typeA').on('click', function(){
              // create the backdrop and wait for next modal to be triggered
              $('body').modalmanager('loading');

              setTimeout(function(){
                  $modal.load('promotion/modal/typeA', '', function(){
                  $modal.modal();
                });
              }, 500);
            });
            
            //ajax - typeB:
            var $modal = $('#typeB-modal');
            $('#ajax-typeB').on('click', function(){
              // create the backdrop and wait for next modal to be triggered
              $('body').modalmanager('loading');

              setTimeout(function(){
                  $modal.load('promotion/modal/typeB', '', function(){
                  $modal.modal();
                });
              }, 500);
            });
            
            //ajax - typeC:
            var $modal = $('#typeC-modal');
            $('#ajax-typeC').on('click', function(){
              // create the backdrop and wait for next modal to be triggered
              $('body').modalmanager('loading');

              setTimeout(function(){
                  $modal.load('promotion/modal/typeC', '', function(){
                  $modal.modal();
                });
              }, 500);
            });
            
            //ajax - typeB:
            var $modal = $('#typeD-modal');
            $('#ajax-typeD').on('click', function(){
              // create the backdrop and wait for next modal to be triggered
              $('body').modalmanager('loading');

              setTimeout(function(){
                  $modal.load('promotion/modal/typeD', '', function(){
                  $modal.modal();
                });
              }, 500);
            });
        }
    };
}();