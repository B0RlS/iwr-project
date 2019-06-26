$('.destroy-user').bind('ajax:success', function() {
   $(this).closest('tr').fadeOut();
});
