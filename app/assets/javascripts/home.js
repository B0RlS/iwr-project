// open-close modal window
var userName = document.querySelector("#user_name"),
    sessionEmail = document.querySelector("#session_email"),
    userEmail = document.querySelector("#user_email"),
    passwordResetEmail = document.querySelector("#password_reset_email"),
    switchbuttonReset = document.querySelector("#switchbuttonreset"),
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
    },
    redAlertReset = function() {
      $( "#goodnotereset" ).addClass( "d-none" );
      $( "#hintalertreset" ).addClass( "d-none" );
      $( "#badnotereset" ).removeClass( "d-none" );
      $( "#password_reset_email" ).removeClass( "greenalert hintalert onblur");
      $( "#password_reset_email" ).addClass( "redalert");
      switchbuttonReset.setAttribute("disabled", true);
      $( "#switchbuttonreset" ).addClass( "notallowed");
    },
    greenAlertReset = function() {
      $( "#badnotereset" ).addClass( "d-none" );
      $( "#hintalertreset" ).addClass( "d-none" );
      $( "#goodnotereset" ).removeClass( "d-none" );
      $( "#password_reset_email" ).removeClass( "redalert hintalert onblur");
      $( "#password_reset_email" ).addClass( "greenalert" );
      switchbuttonReset.removeAttribute("disabled", true);
      $( "#switchbuttonreset" ).addClass( "pointer");
    },
    hintAlertReset = function() {
      $( "#badnotereset" ).addClass( "d-none" );
      $( "#goodnotereset" ).addClass( "d-none" );
      $( "#hintalertreset" ).removeClass( "d-none" );
      $( "#password_reset_email" ).removeClass( "redalert greenalert onblur");
      $( "#password_reset_email" ).addClass( "hintalert" );
      switchbuttonReset.setAttribute("disabled", true);
      $( "#switchbuttonreset" ).addClass( "notallowed");
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

$( "#fogotpass" ).click( function() {
  $( "#loginlay" ).addClass( "d-none" );
  $( "#loginlayunder" ).addClass( "d-none" );
  $( "#resetlay" ).removeClass( "d-none" );
  $( "#resetlayunder" ).removeClass( "d-none" );
  passwordResetEmail.focus();
});

$( "#resetlay" ).click( function() {
  $( this ).addClass( "d-none" );
  $( "#resetlayunder" ).addClass( "d-none" );
});

$( "#backmodal" ).click( function() {
  $( "#resetlay" ).addClass( "d-none" );
  $( "#resetlayunder" ).addClass( "d-none" );
  $( "#loginlay" ).removeClass( "d-none" );
  $( "#loginlayunder" ).removeClass( "d-none" );
  sessionEmail.focus();
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

passwordResetEmail.addEventListener( "keyup", function() {
  if ( regExpEmail.test( passwordResetEmail.value )) {
    var xmlhttp = new XMLHttpRequest();

    xmlhttp.onreadystatechange = function() {
     if (xmlhttp.readyState == 4 && xmlhttp.status == 204) {
        greenAlertReset();
      } else if (xmlhttp.readyState == 4 && xmlhttp.status == 404) {
        redAlertReset();
      }
    }
    xmlhttp.open("GET", "/user/existence/" + passwordResetEmail.value, true);
    xmlhttp.send();
  } else {
    hintAlertReset();
  }
});
