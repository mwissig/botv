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
//= require rails-ujs
//= require jquery-ui/widgets/sortable
//= require rails_sortable
//= require activestorage
//= require bootstrap-datepicker
//= require chartkick
//= require Chart.bundle
// = require turbolinks
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

function toggleEditComment(id) {
  var i;
  for (i = 0; i < saved_ids.length; i++) {
      document.getElementById('commentEditor' + saved_ids[i]).classList.remove("expanded");
  }
  saved_ids = [];
  document.getElementById('commentEditor' + id).classList.toggle("expanded");
  saved_ids.push(id);
}

function bulbFaker(div, color, num) {
  num += 1;
  var otherColor;
  if (color == "red") {
    otherColor = "green";
  }
  else {
    otherColor = "red";
  }
  var span = document.getElementById(div + color);
  var button = document.getElementById(div + color + "button");
  var otherbutton = document.getElementById(div + otherColor + "button");
  span.innerHTML = num;

  button.classList.add('disabledButton');
  otherbutton.classList.add('disabledButton');
  setTimeout(function(){
    button.disabled = true;
    otherbutton.disabled = true;
   }, 1);
}

function showLink() {
  document.getElementById("linkModalContainer").classList.remove("invisible");
}

function dismissLink() {
  document.getElementById("linkModalContainer").classList.add("invisible");
}
function showNsfw() {
  document.getElementById("nsfwModalContainer").classList.remove("invisible");
}
function dismissNsfw() {
    document.getElementById("nsfwModalContainer").classList.add("invisible")
}
function openPlaylistModal() {
  document.getElementById("playlistModalContainer").classList.remove("invisible");
}
function closePlaylistModal() {
    document.getElementById("playlistModalContainer").classList.add("invisible")
}
$(function() {
  $('.sortable').railsSortable();
});

function toggleSearch() {
  document.getElementById("usernameSearch").classList.toggle("invisible");

}

function uncheck(checkbox1, checkbox2) {
  document.getElementById(checkbox1).checked = false;
  document.getElementById(checkbox2).checked = false;
  if (checkbox1 == "search_comments" || checkbox2 == "search_comments") {
    document.getElementById("searchoptions").classList.remove("invisible");
      document.getElementById("use_title").checked = true;
  };
}

function chooseComments() {
  uncheck('search_playlists', 'search_videos');
  document.getElementById("searchoptions").classList.add("invisible");
  document.getElementById("use_title").checked = false;
  document.getElementById("use_tags").checked = false;
    document.getElementById("use_description").checked = false;
}

function toggleshow(id) {
    document.getElementById(id).classList.toggle("invisible");
}

function toggleMenu() {
  var menuSpan = document.getElementById("mobilemenubars");
  var menubar = document.getElementById("leftbar");
  var donate = document.getElementById("donate");
  var checkform = document.getElementById("checkform");
  var search = document.getElementById("search");
  var leftbarlinks = document.getElementById("leftbarlinks");
  var topvids = document.getElementById("topvids");
  if (menuSpan.innerHTML == "<i class=\"fas fa-bars\"></i>") {
    menuSpan.innerHTML = "<i class=\"fas fa-times\"></i>";
    menubar.classList.add("mobilenavexpand");
    donate.classList.add("submobilenavexpand");
    checkform.classList.add("submobilenavexpand");
    search.classList.add("submobilenavexpand");
    leftbarlinks.classList.add("submobilenavexpand");
    topvids.classList.add("submobilenavexpand");
  }
    else {
      menuSpan.innerHTML = "<i class=\"fas fa-bars\"></i>";
      menubar.classList.remove("mobilenavexpand");
      donate.classList.remove("submobilenavexpand");
      checkform.classList.remove("submobilenavexpand");
      search.classList.remove("submobilenavexpand");
      leftbarlinks.classList.remove("submobilenavexpand");
      topvids.classList.remove("submobilenavexpand");
    };
}
