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
                $('#loginForm div').first().append("<input name='pending_organization_id' type='hidden' value='11'>")
                return false;
            }
        });
    }
})(jQuery);

$(function() {
    $('#TIMO').TIMO();
});
