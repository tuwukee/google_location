$(document).ready ->
  $('#user_location :input').change ->
    $('#user_location').submit()


  locatePosition = (position) ->
    $('#user_longitude').val(position.coords.longitude)
    $('#user_latitude').val(position.coords.latitude)
    $('#user_location').submit()

  handleError = (err) ->
    alert err.message

  $('body').on 'click', '#locate_me', () ->
    if navigator.geolocation
      navigator.geolocation.getCurrentPosition locatePosition, handleError, {timeout:50000}
    else
      alert('Geolocation is not supported for this Browser/OS version yet.')

