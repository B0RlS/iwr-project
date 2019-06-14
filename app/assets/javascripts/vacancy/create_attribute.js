$('.create_attribute').bind('ajax:success', function() {
        $('.bd-create-modal-lg').modal('hide');
        window.location.reload(true);
});
