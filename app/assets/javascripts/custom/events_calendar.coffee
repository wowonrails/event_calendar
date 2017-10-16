window.EventsCalendar =
  init: (path) ->
    window.calendar = $('#calendar').fullCalendar
      firstDay: 1
      header: {
        left:   'today',
        center: 'prev, title, next',
        right:  'month,listMonth,listYear'
      }
      timeFormat: 'H:mm'
      events: "/#{path}.json"

      eventClick: (calEvent) ->
        $.ajax
          url: "/#{path}/#{calEvent.id}.js"
        return

      editable: true
      droppable: true

      eventDrop: (event, delta, revertFunc) ->
        $.ajax
          url: "/events/#{event.id}.js",
          type: 'PUT',
          data: "event[start]=#{event.start.format()}&event[periodicity]=once"
          error: (request, msg, error) ->
            revertFunc()

            flashMessage = """
              <div class='callout alert' data-closable>
                #{error}
                <button class='close-button' tabindex='0' aria-label='Dismiss alert' type='button' data-close>
                  <span aria-hidden='true'>&times;</span>
                </button>
              </div>
            """

            $('#navigation_menu').after(flashMessage)

            setTimeout (->
              $('.callout').remove()
              return
            ), 3000

            return
        return
