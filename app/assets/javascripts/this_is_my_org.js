// Tips on stopPropagation(): http://fuelyourcoding.com/jquery-events-stop-misusing-return-false/

(function($) {
    'use strict';
    $.fn.TIMO = function() {
        var that = this;
        $(this).click(function() {
            var menu = $('#menuLogin');
            if (that.attr('data-signed_in') === 'false') {
                if (!jQuery.contains(document, $('.in')[0])) {
                    $('.nav-collapse').collapse('show');
                }
                if (!menu.hasClass('open')) {
                    menu.addClass('open')
                }
                if ($("#loginForm > div > input[name*='user[pending_organization_id]']").length == 0){
                  var org_id = $("#TIMO").attr('data-org_id')
                  $("#loginForm").append("<div><input type = 'hidden' name = 'user[pending_organization_id]' value = '".concat(org_id).concat("'></input></div>"));
                }

                return false;
            }
        });
    }
})(jQuery);
