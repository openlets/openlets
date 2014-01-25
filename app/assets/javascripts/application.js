//= require jquery
//= require jquery_ujs
//= require geocomplete
//= require chosen-jquery
//= require vendor/modernizr
//= require foundation
//= require_tree .

$(function(){ $(document).foundation(); });

function remove_fields(link) {
  $(link).prev("input[type=hidden]").val("1");
  $(link).closest(".fields").hide();
}

function add_fields(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g")
  $(link).parent().before(content.replace(regexp, new_id));
}