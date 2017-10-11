window.EventsCalendar =
  init: (path) ->
    $('#calendar').fullCalendar
      firstDay: 1
      header: {
        left:   'today',
        center: 'prev, title, next',
        right:  'month,listWeek'
      }
      timeFormat: 'H:mm'
      events: "/#{path}.json"

      eventClick: (calEvent) ->
        $.ajax
          url: "/#{path}/#{calEvent.id}.js"
        return
