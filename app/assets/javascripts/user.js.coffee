$(document).ready ->
  $('#user_location :input').change ->
    $('#user_location').submit()
    document.location.reload()