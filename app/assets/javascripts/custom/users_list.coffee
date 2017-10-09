window.UsersList =
  init: () ->
    UsersList.toggle_buttons()

  toggle_buttons: () ->
    $(document).on 'click', '.js-profile-buttons .button', ->
      $('.js-profile-buttons .button').removeClass('disabled')
      $(this).addClass('disabled')

      return
