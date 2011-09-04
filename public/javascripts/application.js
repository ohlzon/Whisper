//$(document).ready(function(){
//  $("a.on").click(function(event){  
//    event.preventDefault();
//    $.ajax({
//      url: '/devices/' + $(this).attr('id') + '/on'
//    });    
//    $('p.' + $(this).attr('id') + 'state').replaceWith('<p class="' + $(this).attr('id') + 'state">on</p>');
//  });
//  
//  $("a.off").click(function(event){  
//    event.preventDefault();
//    $.ajax({
//      url: '/devices/' + $(this).attr('id') + '/off'
//    });    
//    $('p.' + $(this).attr('id') + 'state').replaceWith('<p class="' + $(this).attr('id') + 'state">off</p>');
//  });
//});