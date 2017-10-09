window.FoundationDatepicker =
  init: () ->
    FoundationDatepicker.disable_form_fields()

  disable_form_fields: () ->
    # implementation of disabled form fields
    nowTemp = new Date
    now = new Date(nowTemp.getFullYear(), nowTemp.getMonth(), nowTemp.getDate(), 0, 0, 0, 0)

    checkin = $('#event_start').fdatepicker(
      format: 'dd-mm-yyyy hh:ii'
      disableDblClickSelection: true
      language: 'vi'
      pickTime: true

      onRender: (date) ->
        if date.valueOf() < now.valueOf() then 'disabled' else ''
    ).on('changeDate', (ev) ->
      if ev.date.valueOf() > checkout.date.valueOf()
        newDate = new Date(ev.date)
        newDate.setDate newDate.getDate() + 1
        checkout.update newDate

      checkin.hide()

      $('#event_finish')[0].focus()
      return
    ).data('datepicker')

    checkout = $('#event_finish').fdatepicker(
      format: 'dd-mm-yyyy'
      disableDblClickSelection: true

      onRender: (date) ->
        if date.valueOf() <= checkin.date.valueOf() then 'disabled' else ''
    ).on('changeDate', (ev) ->
      checkout.hide()
      return
    ).data('datepicker')
