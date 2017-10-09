$(document).ready ->

  $('#calendar').fullCalendar
    firstDay: 1
    header: {
      left:   'prev,next, today',
      center: 'title',
      right:  'month,agendaWeek,agendaDay,listWeek'
    }
    timeFormat: 'H:mm'
    events: '/events.json'

    eventClick: (calEvent) ->
      $.ajax
        url: "/events/#{calEvent.id}.js"
      return
