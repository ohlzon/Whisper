$(document).ready(function(){
  
  // On switching on or off, get paths for on or off
  $("a.on").click(function(event){  
    event.preventDefault();
    deviceid = $(this).parent().attr('id')
    $.ajax({
      url: '/devices/' + deviceid + '/on'
    });    
    $('p.' + $(this).attr('id') + 'state').replaceWith('<p class="' + $(this).attr('id') + 'state">on</p>');
  });
  
  $("a.off").click(function(event){  
    event.preventDefault();
    boxid = $(this).parent().attr('id')
    $.ajax({
      url: '/devices/' + $(this).attr('id') + '/off'
    });    
    $('p.' + $(this).attr('id') + 'state').replaceWith('<p class="' + $(this).attr('id') + 'state">off</p>');
  });
  
  // On device title click, slide out device pane. If expanded, slide back in.
  $("a.devicetitle").click(function(event){
    event.preventDefault();
    var title = $(this).parent().parent().parent();
    if ( title.hasClass('expanded') ) {
      $(title).find('.boxslideout').animate({
        height: '0'
      }, 200, function(){
        $(title).find('.boxheader').css("border-bottom","0px");
        title.removeClass( "expanded ");
      });
    } else {
      $(title).find('.boxheader').css("border-bottom","1px solid #9f9f9f");
      $(title).find('.boxslideout').animate({
        height: '210'
      }, 200, function(){
        title.addClass( "expanded ");        
      });
    }
  });
  
  // Device pane buttons
  $("a.button").click(function(event){
    event.preventDefault();
    deviceid = $(this).parent().parent().parent().attr('id')
    if ( $(this).hasClass('learn') ) {
      $.ajax({
        url: '/devices/' + deviceid + '/learn'
      });
    } else if ( $(this).hasClass('edit') ) {  
      $(this).load('http://localhost:3000/devices/' + deviceid + '/edit #form');
      var title = $(this).parent().parent().parent().find('.boxslideout');
      $(this).animate({height: '290px'});
      $(this).parent().parent().parent().find('.boxslideout').animate({height: '480px'});
    } else if ( $(this).hasClass('delete') ) {
      // DELETE CODE
    } else {
      // This really shouldn't be happening.
    }
  });
  
  // Notification animation
  $('.notification').animate({
    opacity: '1',
    textShadow: '#000 0 0 5px'
  }, 700, function() {
    $('.notification').animate({
      opacity: '0',
      textShadow: "#000 0 0 5px"
    }, 700, function() {
      // Animation complete.
    });
  }).delay(2000);
});