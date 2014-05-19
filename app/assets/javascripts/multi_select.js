jQuery(document).ready(function($) {
  // enable chosen.js
  $('.chzn-select').chosen({
    allow_single_deselect: true,
    no_results_text: 'No results matched'
  });

  $('a.auto-submit').click(function(){
    $("form#search-form").submit();
  });

  $('body').off('change', '.auto-submit').on('change','.auto-submit', function(){
    $(this).closest("form").submit();
  });  
});