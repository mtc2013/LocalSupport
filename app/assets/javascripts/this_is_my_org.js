(function($) {
    'use strict';
    $.fn.TIMO = function() {
        var that = this;
        $(this).click(function() {
            var menu = $('#menuLogin');
            var login = $('#loginForm');
            var register = $('#registerForm')
            var toggle = $('#toggle_link');
            if (that.attr('data-signed_in') === 'false') {
                //login.height(0);
                //register.height("auto");
                //register.addClass("in");
                //login.addClass("collapse");

                if (!jQuery.contains(document, $('.in')[0])) {
                    $('.nav-collapse').collapse('show');
                }
                if (!menu.hasClass('open')) {
                    menu.addClass('open')
                }
                if(!register.hasClass("in")){
                    toggle.click();
                }
                this.pending_org_id = $("#user_organisation_id").val();
                $('#loginForm div').first().append("<input name='pending_organisation_id' type='hidden' value="+ this.pending_org_id+">");
                return false;
            }
        });
    }
})(jQuery);

$(function() {
    $('#TIMO').TIMO();
});
