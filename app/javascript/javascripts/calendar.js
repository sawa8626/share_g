import { Calendar } from '@fullcalendar/core';
import interactionPlugin from '@fullcalendar/interaction';
import dayGridPlugin from '@fullcalendar/daygrid';
import timeGridPlugin from '@fullcalendar/timegrid';
import listPlugin from '@fullcalendar/list';

document.addEventListener('DOMContentLoaded', function() {
  var calendarEl = document.getElementById('calendar');

  var calendar = new Calendar(calendarEl, {
    plugins: [ interactionPlugin, dayGridPlugin, timeGridPlugin, listPlugin ],
    locale: 'ja',
    navLinks: true,
    slotDuration: '00:15:00',
    slotLabelFormat: {
      hour: '2-digit',
      minute: '2-digit'
    },
    timeFormat: "HH:mm",
    selectable: true,
    nowIndicator: true,
    // slotMinTime: '00:00:00',
    // slotMaxTime: '24:00:00',

    headerToolbar: {
      left: 'prev,next',
      center: 'title',
      right: 'today dayGridMonth,timeGridWeek,timeGridDay',
    },

    views: {
      defaultDate: '2020-02-10'
    },

    events: [
      {
        title: '来客',
        start: '2020-08-10'
      },
      {
        title: '旅行',
        start: '2020-08-28T06:00:00',
        end: '2020-09-01T22:00:00'
      }
    ]
  });

  calendar.render();
});