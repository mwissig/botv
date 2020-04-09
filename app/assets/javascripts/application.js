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
//= require jquery3
//= require popper
//= require bootstrap-sprockets
//= require jquery_ujs
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require_tree .

var saved_ids = [];

function expandReply(id) {
  var i;
  for (i = 0; i < saved_ids.length; i++) {
      document.getElementById('commentreply' + saved_ids[i]).classList.remove("expanded");
  }
  saved_ids = [];
  document.getElementById('commentreply' + id).classList.toggle("expanded");
  saved_ids.push(id);
}

function showBulbers(type, id) {
      var i;
    saved_ids = [];

      for (i = 0; i < saved_ids.length; i++) {
        document.getElementById('comment' + 'bulbers' + saved_ids[i]).classList.remove("expanded");
      }
    document.getElementById(type + 'bulbers' + id).classList.toggle("expanded");
  saved_ids.push(id);

}
