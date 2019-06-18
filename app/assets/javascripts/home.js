// open-close modal window
var userName = document.querySelector("#user_name"),
    sessionEmail = document.querySelector("#session_email"),
    userEmail = document.querySelector("#user_email"),
    regExpEmail = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/,
    switchbutton = document.querySelector("#switchbutton"),
    redAlert = function() {
      $( "#goodnote" ).addClass( "d-none" );
      $( "#hintalert" ).addClass( "d-none" );
      $( "#badnote" ).removeClass( "d-none" );
      $( "#user_email" ).removeClass( "greenalert hintalert onblur");
      $( "#user_email" ).addClass( "redalert");
      switchbutton.setAttribute("disabled", true);
      $( "#switchbutton" ).addClass( "notallowed");
    },
    greenAlert = function() {
      $( "#badnote" ).addClass( "d-none" );
      $( "#hintalert" ).addClass( "d-none" );
      $( "#goodnote" ).removeClass( "d-none" );
      $( "#user_email" ).removeClass( "redalert hintalert onblur");
      $( "#user_email" ).addClass( "greenalert" );
      switchbutton.removeAttribute("disabled", true);
      $( "#switchbutton" ).addClass( "pointer");
    },
    hintAlert = function() {
      $( "#badnote" ).addClass( "d-none" );
      $( "#goodnote" ).addClass( "d-none" );
      $( "#hintalert" ).removeClass( "d-none" );
      $( "#user_email" ).removeClass( "redalert greenalert onblur");
      $( "#user_email" ).addClass( "hintalert" );
      switchbutton.setAttribute("disabled", true);
      $( "#switchbutton" ).addClass( "notallowed");
    };

$( "#getstarted" ).click( function() {
  $( "#loginlay" ).removeClass( "d-none" );
  $( "#loginlayunder" ).removeClass( "d-none" );
});

$( "#loginlay" ).click( function() {
  $( this ).addClass( "d-none" );
  $( "#loginlayunder" ).addClass( "d-none" );
});

$( "#register" ).click( function() {
  $( "#loginlay" ).addClass( "d-none" );
  $( "#loginlayunder" ).addClass( "d-none" );
  $( "#registerlay" ).removeClass( "d-none" );
  $( "#registerlayunder" ).removeClass( "d-none" );
  userName.focus();
});

$( "#registerlay" ).click( function() {
  $( this ).addClass( "d-none" );
  $( "#registerlayunder" ).addClass( "d-none" );
});

$( "#loginback" ).click( function() {
  $( "#registerlay" ).addClass( "d-none" );
  $( "#registerlayunder" ).addClass( "d-none" );
  $( "#loginlay" ).removeClass( "d-none" );
  $( "#loginlayunder" ).removeClass( "d-none" );
  sessionEmail.focus();
});

userEmail.onblur = function() {
  $( "#badnote" ).addClass( "d-none" );
  $( "#goodnote" ).addClass( "d-none" );
  $( "#hintalert" ).addClass( "d-none" );
  $( "#user_email" ).removeClass( "redalert greenalert hintalert");
  $( "#user_email" ).addClass( "onblur");
};

userEmail.addEventListener( "keyup", function() {
  if ( regExpEmail.test( userEmail.value )) {
    var xmlhttp = new XMLHttpRequest();

    xmlhttp.onreadystatechange = function() {
     if (xmlhttp.readyState == 4 && xmlhttp.status == 204) {
        redAlert();
      } else if (xmlhttp.readyState == 4 && xmlhttp.status == 404) {
        greenAlert();
      }
    }
    xmlhttp.open("GET", "/user/existence/" + userEmail.value, true);
    xmlhttp.send();
  } else {
    hintAlert();
  }
});
