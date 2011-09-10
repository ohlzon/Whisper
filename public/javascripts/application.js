$(document).ready(function(){
  // On switching on or off, get paths for on or off
  $("a.on").click(function(event){  
    event.preventDefault();
    $.ajax({
      url: '/devices/' + $(this).attr('id') + '/on'
    });    
    $('p.' + $(this).attr('id') + 'state').replaceWith('<p class="' + $(this).attr('id') + 'state">on</p>');
  });
  
  $("a.off").click(function(event){  
    event.preventDefault();
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
      $(title).find('.deviceslideout').animate({
        height: '0'
      }, 200, function(){
        $(title).find('.deviceheader').css("border-bottom","0px");
        title.removeClass( "expanded ");
      });
    } else {
      $(title).find('.deviceheader').css("border-bottom","1px solid #9f9f9f");
      $(title).find('.deviceslideout').animate({
        height: '100'
      }, 200, function(){
        title.addClass( "expanded ");        
      });
    }
  });
});