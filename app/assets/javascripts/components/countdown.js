// Contadores
var openRegistration = '';

// Data final dos contadores
openRegistration = 'December 07 2015 22:49:59 GMT-02:00';

// Inicialização dos contadores
initializeClock( '.countdown-clock', openRegistration );


function initializeClock( clockClass, deadline ) {

  var
    daysSelector = '',
    hoursSelector = '',
    minutesSelector = '',
    secondsSelector = '',
    timeinterval = 0;

  // Define seletores do contador
  daysSelector = $( clockClass + ' > .countdown-clock__days > span' );
  hoursSelector = $( clockClass + ' > .countdown-clock__hours > span' );
  minutesSelector = $( clockClass + ' > .countdown-clock__minutes > span' );
  secondsSelector = $( clockClass + ' > .countdown-clock__seconds > span' );

  // Define intervalo de atualização do contador em milisegundos
  timeinterval = setInterval( updateClock, 1000 );

  // Mostra contador
  $( '.countdown-clock' ).show();

  // Atualiza o contador
  updateClock();


  function updateClock() {

    var t = getRemainingTime();

    daysSelector.text( t.days );
    hoursSelector.text( ( '0' + t.hours ).slice(-2) );
    minutesSelector.text( ( '0' + t.minutes ).slice(-2) );
    secondsSelector.text( ( '0' + t.seconds ).slice(-2) );

    if( t.total <= 0 ) {
      clearInterval( timeinterval );
      $( '.countdown-clock' ).hide();
      $( '.subscription' ).show();
    }

  }

  function getRemainingTime() {

    var
  		currentTime = Date.parse( new Date() ),
  		endTime = Date.parse( deadline ),
  		remainingTime = endTime - currentTime,
    	seconds = Math.floor( ( remainingTime / 1000 ) % 60 ),
    	minutes = Math.floor( ( remainingTime / 1000 / 60 ) % 60 ),
    	hours = Math.floor( ( remainingTime / ( 1000 * 60 * 60 ) ) % 24 ),
    	days = Math.floor( remainingTime / ( 1000 * 60 * 60 * 24 ) );

    return {
      'total': remainingTime,
      'days': days,
      'hours': hours,
      'minutes': minutes,
      'seconds': seconds
    };

  }

}
