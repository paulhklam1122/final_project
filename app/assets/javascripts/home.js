$(window).scroll(function() {
  if ($(".navbar").offset().top > 50) {
    $('#custom-nav').addClass('affix');
    $(".navbar-fixed-top").addClass("top-nav-collapse");
  } else {
    $('#custom-nav').removeClass('affix');
    $(".navbar-fixed-top").removeClass("top-nav-collapse");
  }
});

function parallax() {
  var scrolled = $(window).scrollTop();
  $('.home-bg').css('top', -(scrolled *0.4) + 'px');
}
$(window).scroll(function(e){
  parallax();
});
