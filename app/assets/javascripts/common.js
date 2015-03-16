$( document ).ready(function() {
  $('#terms_of_service').bind('click', function(){
    $('input[name="commit"]').attr('disabled', true);

    if($(this).is(':checked')){
      $('input[name="commit"]').attr('disabled', false);
    }
  })
});
