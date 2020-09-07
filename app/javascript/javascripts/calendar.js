import { Calendar } from '@fullcalendar/core';
import interactionPlugin from '@fullcalendar/interaction';
import dayGridPlugin from '@fullcalendar/daygrid';
import timeGridPlugin from '@fullcalendar/timegrid';
import listPlugin from '@fullcalendar/list';

document.addEventListener('DOMContentLoaded', function() {
  const pathname = location.pathname;

  var calendarEl = document.getElementById('calendar');

  if(document.URL.match(/reservations/)) {
    var calendar = new Calendar(calendarEl, {
      plugins: [ interactionPlugin, dayGridPlugin, timeGridPlugin, listPlugin ],
      locale: 'ja',
      navLinks: true,
      selectable: true,
      nowIndicator: true,
      slotDuration: '00:15:00',
      slotMinTime: '06:00:00',

      slotLabelFormat: {
        hour: '2-digit',
        minute: '2-digit'
      },

      eventTimeFormat: {
        hour: '2-digit',
        minute: '2-digit'
      },

      headerToolbar: {
        left: 'prev,next',
        center: 'title',
        right: 'today dayGridMonth,timeGridWeek,timeGridDay',
      },

      events: `${pathname}/get`
    });
    calendar.render();
  }

});
