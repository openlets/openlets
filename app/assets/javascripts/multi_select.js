jQuery(document).ready(function($) {

  $('a.auto-submit').click(function(){
    $("form#search-form").submit();
  });

  $('body').off('change', '.auto-submit').on('change','.auto-submit', function(){
    $(this).closest("form").submit();
  });  
});