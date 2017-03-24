$(document).ready(function() {

  $('.navbar_select_impersonate').select2();

  $('.popup_select_impersonate').select2();

  $('.navbar_select_impersonate#impersonate_id').change(function() {
    $('.navbar_select_impersonate#impersonate_id').closest('form').submit();
  });

  $('.popup_select_impersonate#impersonate_id').change(function() {
    $('.popup_select_impersonate#impersonate_id').closest('form').submit();
  });

});

