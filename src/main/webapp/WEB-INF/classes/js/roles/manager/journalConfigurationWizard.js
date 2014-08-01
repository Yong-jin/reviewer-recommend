var SubmitFormWizard = function () {
    return {
        //main function to initiate the module
        init: function (baseUrl, currentStep) {
            if (!jQuery().bootstrapWizard) {
                return;
            }

            function format(state) {
                if (!state.id) return state.text; // optgroup
                return "<img class='flag' src='assets/img/flags/" + state.id.toLowerCase() + ".png'/>&nbsp;&nbsp;" + state.text;
            }

            $("#country_list").select2({
            	placeholder: '<i class="fa fa-map-marker"></i>&nbsp;Select',
                allowClear: true,
                formatResult: format,
                formatSelection: format,
                escapeMarkup: function (m) {
                    return m;
                }
            });
            
            $('.step').click(function(event) {
            	var num = $(this).children(":nth-child(1)").text();
            	num = Number(num);
        		var url = baseUrl + "/manager/configuration/journal/step" + num;
        		location.href = url;
            });

            var form = $('#submit_form');
            var error = $('.alert-danger', form);
            var success = $('.alert-success', form);

            form.validate({
                doNotHideMessage: true, //this option enables to show the error/success messages on tab switch.
                errorElement: 'span', //default input error message container
                errorClass: 'help-block', // default input error message class
                focusInvalid: false, // do not focus the last invalid input
                rules: {
                    //account
                    title: {
                        minlength: 5,
                        required: true
                    },
                },

                messages: { // custom messages for radio buttons and checkboxes
                	/*
                	title: {
                        minlength: jQuery.format(errorMessages['author.newPaperSubmit.minLength']),
                        required: errorMessages['author.newPaperSubmit.keywordRequired'],
                    },
                    */
                },

                errorPlacement: function (error, element) { // render error placement for each input type
                    error.insertAfter(element); // for other inputs, just perform default behavior
                },

                invalidHandler: function (event, validator) { //display error alert on form submit   
                    success.hide();
                    error.show();
                },
/*
                highlight: function (element) { // hightlight error inputs
                    $(element)
                        .closest('.form-group').removeClass('has-success').addClass('has-error'); // set error class to the control group
                },

                unhighlight: function (element) { // revert the change done by hightlight
                    $(element)
                        .closest('.form-group').removeClass('has-error'); // set error class to the control group
                },
*/
                success: function (label) {
                	/*
                    if (label.attr("for") == "gender" || label.attr("for") == "payment[]") { // for checkboxes and radio buttons, no need to show OK icon
                        label.closest('.form-group').removeClass('has-error').addClass('has-success');
                        label.remove();
                    } else {
                        label.addClass('valid')
                        .closest('.form-group').removeClass('has-error').addClass('has-success');
                    }
                    */
                },

                submitHandler: function (form) {
                    success.show();
                    error.hide();
                    form.submit();
                }

            });

            var handleTitle = function(tab, navigation, index) {
                var total = navigation.find('li').length;
				index = Number(currentStep);

                jQuery('li', $('#form_wizard_1')).removeClass("done");
                var li_list = navigation.find('li');
                for (var i = 0; i < index; i++) {
                    jQuery(li_list[i]).addClass("done");
                }
                jQuery(li_list[index]).addClass("active");
                
            };
            $('#form_wizard_1').bootstrapWizard({
                'nextSelector': '.button-next',
                'previousSelector': '.button-previous',
                
                onTabClick: function (tab, navigation, index, clickedIndex) {
                    success.hide();
                    error.hide();
                    if (form.valid() == false) {
                        return false;
                    }
                    
                    handleTitle(tab, navigation, index);
                },
                onNext: function (tab, navigation, index) {
                    success.hide();
                    error.hide();

                    if (form.valid() == false) {
                        return false;
                    }

                    handleTitle(tab, navigation, index);
                },
                onPrevious: function (tab, navigation, index) {
                    success.hide();
                    error.hide();

                    handleTitle(tab, navigation, index);
                },
                onTabShow: function (tab, navigation, index) {
                	var total = navigation.find('li').length;
                	index = currentStep;
                    handleTitle(tab, navigation, index);
                    var $percent = ((Number(currentStep)) / total) * 100;
                    $('#form_wizard_1').find('.progress-bar').css({
                        width: $percent + '%'
                    });
                }
            });

            
        }

    };

}();