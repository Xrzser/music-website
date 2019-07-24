$(document).ready(function(){
  
  $(document).on($.jPlayer.event.pause, myPlaylist.cssSelector.jPlayer, function () {
    $('.musicbar').removeClass('animate');
    $('.jp-play-me').removeClass('active');
    $('.jp-play-me').parent('li').removeClass('active');
  });

  $(document).on($.jPlayer.event.play, myPlaylist.cssSelector.jPlayer, function () {
    $('.musicbar').addClass('animate');
  });
});