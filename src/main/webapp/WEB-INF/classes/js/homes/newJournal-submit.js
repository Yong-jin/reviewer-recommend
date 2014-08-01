var FormWizard = function () {
    return {
        //main function to initiate the module
        init: function () {
            if (!jQuery().bootstrapWizard) {
                return;
            }
                       
    		$("#select2_language").select2({
    		  	placeholder: '<i class="fa fa-keyboard-o"></i>&nbsp;&nbsp;&nbsp;' + errorMessages['newJournalSubmit.language.help'],
                allowClear: true,
                formatResult: function(state) {
                	return state.text;
                },
                formatSelection: function(state) {
                	return state.text;
                },
                escapeMarkup: function (m) {
                    return m;
                }
            });

    		$('#select2_language').change(function () {
                $('#submit_form').validate().element($(this));
            });

    		
    		
    		$("#select2_country").select2({
    		  	placeholder: '<i class="fa fa-map-marker"></i>&nbsp;&nbsp;&nbsp;' + errorMessages['newJournalSubmit.country.help'],
                allowClear: true,
                formatResult: function(state) {
                	if (!state.id) return state.text;
                    return "<img class='flag' src='assets/img/flags/" + state.id.toLowerCase() + ".png' />&nbsp;&nbsp;" + state.text;
                },
                formatSelection: function(state) {
                	if (!state.id) return state.text;
                    return "<img class='flag' src='assets/img/flags/" + state.id.toLowerCase() + ".png'/>&nbsp;&nbsp;" + state.text;
                },
                escapeMarkup: function (m) {
                    return m;
                }
            });

    		$('#select2_country').change(function () {
                $('#submit_form').validate().element($(this));
            });    		
            
            var form = $('#submit_form');

            var displayConfirm = function() {
                $('#tab3 .form-control-static', form).each(function(){
                    var input = $('[name="'+$(this).attr("data-display")+'"]', form);
                    
                    if (input.is(":radio")) {
                        input = $('[name="'+$(this).attr("data-display")+'"]:checked', form);
                    }
                    
                    if (input.is(":text") || input.is("textarea")) {
                        $(this).html(input.val());
                    } else if (input.is("select")) {
                    	if (input.is("#select2_country")) {
                    		$(this).html("<img class='flag' src='assets/img/flags/" + input.find('option:selected').val().toLowerCase() + ".png' />&nbsp;&nbsp;" + input.find('option:selected').text());
                    	} else {
                    		$(this).html(input.find('option:selected').text());
                    	}
                    } else if (input.is(":radio") && input.is(":checked")) {
                        $(this).html(input.attr("data-title"));
                    } else if ($(this).attr("data-display") == 'payment') {
                        var payment = [];
                        $('[name="payment[]"]').each(function(){
                            payment.push($(this).attr('data-title'));
                        });
                        $(this).html(payment.join("<br>"));
                    }
                });
            };

            var handleTitle = function(tab, navigation, index) {
                var total = navigation.find('li').length;
                var current = index + 1;
                // set wizard title
                $('.step-title', $('#form_wizard_1')).text('Step ' + (index + 1) + ' of ' + total);
                // set done steps
                jQuery('li', $('#form_wizard_1')).removeClass("done");
                var li_list = navigation.find('li');
                for (var i = 0; i < index; i++) {
                    jQuery(li_list[i]).addClass("done");
                }
                
                if (index != 1) {
                	$('div[class="imgareaselect-handle"]').hide();
                	$('div[class="imgareaselect-outer"]').hide();
                } else {
                	$('div[class="imgareaselect-outer"]').show();
                	$('div[class="imgareaselect-handle"]').show();
                }

                
                if (current == 1) {
                    $('#form_wizard_1').find('.button-previous').hide();
                } else {
                    $('#form_wizard_1').find('.button-previous').show();
                }

                if (current >= total) {
                    $('img[id="uploadImage"]').imgAreaSelect({ disable: true });

                	$('#form_wizard_1').find('.button-next').hide();
                    $('#form_wizard_1').find('.button-submit').show();
                    
                    displayConfirm();
                } else {
                    $('#form_wizard_1').find('.button-next').show();
                    $('#form_wizard_1').find('.button-submit').hide();
                    $('img[id="uploadImage"]').imgAreaSelect({ disable: false });
                }
                App.scrollTo($('.page-title'));
            };

            // default form wizard
            $('#form_wizard_1').bootstrapWizard({
                'nextSelector': '.button-next',
                'previousSelector': '.button-previous',
                onTabClick: function (tab, navigation, index, clickedIndex) {
                    if (form.valid() == false) {
                        return false;
                    }
                    handleTitle(tab, navigation, clickedIndex);
                },
                onNext: function (tab, navigation, index) {
                    if (form.valid() == false) {
                        return false;
                    }
                    handleTitle(tab, navigation, index);
                },
                onPrevious: function (tab, navigation, index) {
                    handleTitle(tab, navigation, index);
                },
                onTabShow: function (tab, navigation, index) {
                    var total = navigation.find('li').length;
                    var current = index + 1;
                    var $percent = (current / total) * 100;
                    $('#form_wizard_1').find('.progress-bar').css({
                        width: $percent + '%'
                    });
                }
            });

            $('#form_wizard_1').find('.button-previous').hide();
            $('#form_wizard_1 .button-submit').click(function () {
            	$("#file").prop("disabled", true);
            	form.submit();
            }).hide();
        }
    };
}();