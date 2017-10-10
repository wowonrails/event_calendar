window.EventsCalendar =
  init: (path) ->
    $('#calendar').fullCalendar
      firstDay: 1
      header: {
        left:   'prev,next, today',
        center: 'title',
        right:  'month,agendaWeek,agendaDay,listWeek'
      }
      timeFormat: 'H:mm'
      events: "/#{path}.json"

      eventClick: (calEvent) ->
        $.ajax
          url: "/#{path}/#{calEvent.id}.js"
        return
