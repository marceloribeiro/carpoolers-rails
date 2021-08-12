// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require_tree .

$(function() {
  startAddressListeners()
  startTimePickerListeners()
})


function startAddressListeners() {
  $('.google-location').geocomplete()
}

function startTimePickerListeners() {
  $('.timepicker').timepicker({
      timeFormat: 'h:mm p',
      interval: 30,
      minTime: '6:00am',
      maxTime: '10:00pm',
      defaultTime: '6',
      startTime: '6:00',
      dynamic: false,
      dropdown: true,
      scrollbar: true
  });
}
