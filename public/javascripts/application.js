document.observe( 'click', function( event )
{
  event.preventDefault();
  var elem = event.element();
  if ( elem.match( '.switch' ) )
  {
    $.ajax({
      url: '/whisper/off/' + $(this).attr('id'),
    });
  }
});