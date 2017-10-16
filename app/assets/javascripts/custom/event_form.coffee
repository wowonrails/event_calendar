window.EventForm =
  init: () ->
    EventForm.toggle_fields()

  toggle_fields: () ->
    $(document).on 'change', '#event_periodicity', ->
      if $(this).val() == "once"
        $('.js-event-finish-field').addClass('hide')
      else
        $('.js-event-finish-field').removeClass('hide')

      return

    $(document).on 'change', '#event_start', ->
      if $('#event_periodicity').val() == "once"
        $('#event_finish').val('')

      return

    $(document).on 'click', '#update_future_events', ->
      if $(this).prop('checked')
        $('.js-event-periodicity-field, .js-event-finish-field').removeClass('hide')
      else
        $('.js-event-periodicity-field, .js-event-finish-field').addClass('hide')

      return
