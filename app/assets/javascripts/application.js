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
//= require_tree .
//= require jquery
//= require jquery.turbolinks
//= require jquery_ujs
//= require alertify.min
//= require bootstrap-sprockets
//= require turbolinks
let didScroll
let lastScrollTop = 0
let delta = 5
let navbarHeight = $('header').outerHeight()

if(window.location.pathname === '/musics'){
  $(window).scroll((e) => {
    didScroll = true
  })

  setInterval(() => {
    if(didScroll) {
      hasScrolled()
      didScroll = false
    }
  }, 250)

  const hasScrolled = () => {
    let st = $(this).scrollTop()
    if(Math.abs(lastScrollTop - st) <= delta)
    return
    if(st > lastScrollTop && st > navbarHeight){
      $('header').removeClass('nav-down').addClass('nav-up')
    }else{
      if(st + $(window).height() < $(document).height()){
        $('header').removeClass('nav-up').addClass('nav-down')
      }
    }
    lastScrollTop = st
  }
}
