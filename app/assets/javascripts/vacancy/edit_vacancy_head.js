$('.edit-vacancy-head').bind('ajax:success', function() {
        $('.bd-edit-head-modal-lg').modal('hide');
        $('.vacancy-head').load(window.location.href + " .vacancy-head" );
        $('.preview-head').load(window.location.href + " .preview-head" );
});
