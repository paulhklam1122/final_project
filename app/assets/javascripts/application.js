// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery.infinite-pages
//= require bootstrap-sprockets
//= require underscore
//= require gmaps/google
//= require highcharts/highcharts
//= require highcharts/highcharts-more
//= require highcharts/highstock
//= require_tree .

$(window).scroll(function() {
  if ($(".navbar").offset().top > 50) {
    $('#custom-nav').addClass('affix');
    $(".navbar-fixed-top").addClass("top-nav-collapse");
  } else {
    $('#custom-nav').removeClass('affix');
    $(".navbar-fixed-top").removeClass("top-nav-collapse");
  }
});

$(document).ready(function(){
  // ===== Scroll to Top ====
  $(window).scroll(function() {
    if ($(this).scrollTop() >= 50) { // If page is scrolled more than 50px
      $('#return-to-top').fadeIn(500); // Fade in the arrow
    } else {
      $('#return-to-top').fadeOut(500); // Else fade out the arrow
    }
  });
  $(document).on('click', '#return-to-top', function() { // When arrow is clicked
    $('body,html').animate({
      scrollTop: 0 // Scroll to top of body
    }, 500);
  });
  $("span.admin").click(function(){$(this).hide()})
});

$(document).ready(function(){
  // ===== Scroll to Top ====
  $(window).scroll(function() {
    if ($(this).scrollTop() >= 50) { // If page is scrolled more than 50px
      $('#return-to-bottom').fadeIn(500); // Fade in the arrow
    } else {
      $('#return-to-bottom').fadeOut(500); // Else fade out the arrow
    }
  });
  $(document).on('click', '#return-to-bottom', function() { // When arrow is clicked
    $('body,html').animate({
      scrollTop: $(document).height() // Scroll to bottom of body
    }, 500);
  });
  $("span.admin").click(function(){$(this).hide()})
});


function parallax() {
  var scrolled = $(window).scrollTop();
  $('.home-bg').css('top', -(scrolled *0.4) + 'px');
}
$(window).scroll(function(e){
  parallax();
});
