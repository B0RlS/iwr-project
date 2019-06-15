$('.delete_attribute').bind('ajax:success', function() {
        $(this).closest('li').fadeOut();
        $('.preview-body').load(window.location.href + " .preview-body" );
});
