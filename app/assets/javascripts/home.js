// open-close modal window
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
})

// for logged users
var map;

function initialize() {
  var myOptions = {
    zoom: 2,
    center: new google.maps.LatLng(10, 0),
    mapTypeId: google.maps.MapTypeId.ROADMAP
  };

  map = new google.maps.Map(document.getElementById('map'),
      myOptions);

  var styles = [
      {
        stylers: [
          { hue: "#00ffe6" },
          { saturation: -20 }
        ]
      },
      {
        featureType: "landscape",
        stylers: [
          { hue: "#ffff66" },
          { saturation: 100 }
        ]
      },{
        featureType: "road",
        stylers: [
          { visibility: "off" }
        ]
      },{
        featureType: "administrative.land_parcel",
        stylers: [
          { visibility: "off" }
        ]
      },{
        featureType: "administrative.locality",
        stylers: [
          { visibility: "off" }
        ]
      },{
        featureType: "administrative.neighborhood",
        stylers: [
          { visibility: "off" }
        ]
      },{
        featureType: "administrative.province",
        stylers: [
          { visibility: "off" }
        ]
      },{
        featureType: "landscape.man_made",
        stylers: [
          { visibility: "off" }
        ]
      },{
        featureType: "landscape.natural",
        stylers: [
          { visibility: "off" }
        ]
      },{
        featureType: "poi",
        stylers: [
          { visibility: "off" }
        ]
      },{
        featureType: "transit",
        stylers: [
          { visibility: "off" }
        ]
      }
    ];

  map.setOptions({styles: styles});

  var script = document.createElement('script');
  var url = ['https://www.googleapis.com/fusiontables/v1/query?'];
  url.push('sql=');
  var query = 'SELECT name, kml_4326 FROM ' +
      '1foc3xO9DyfSIF6ofvN0kp2bxSfSeKog5FbdWdQ';
  var encodedQuery = encodeURIComponent(query);
  url.push(encodedQuery);
  url.push('&callback=drawMap');
  url.push('&key=AIzaSyAm9yWCV7JPCTHCJut8whOjARd7pwROFDQ');
  script.src = url.join('');
  var body = document.getElementsByTagName('body')[0];
  body.appendChild(script);
}

function drawMap(data) {
  var rows = data['rows'];
  for (var i in rows) {
    if (rows[i][0] != 'Antarctica') {
      var newCoordinates = [];
      var geometries = rows[i][1]['geometries'];
      if (geometries) {
        for (var j in geometries) {
          newCoordinates.push(constructNewCoordinates(geometries[j]));
        }
      } else {
        newCoordinates = constructNewCoordinates(rows[i][1]['geometry']);
      }
      var country = new google.maps.Polygon({
        paths: newCoordinates,
        strokeColor: '#ff9900',
        strokeOpacity: 1,
        strokeWeight: 0.3,
        fillColor: '#ffff66',
        fillOpacity: 0,
        name: rows[i][0]
      });
      google.maps.event.addListener(country, 'mouseover', function() {
        this.setOptions({fillOpacity: 0.4});
      });
      google.maps.event.addListener(country, 'mouseout', function() {
        this.setOptions({fillOpacity: 0});
      });
      google.maps.event.addListener(country, 'click', function() {
        if (this.name == 'Russia'){
          this.name = 'Russian%20Federation'
        }
        $.ajax({
          type: "GET",
          url: "/vacancy/country_search",
          data: { country: this.name },
          success: window.location = '/vacancy/country_search/?country=' + this.name
        });
      });

      country.setMap(map);
    }
  }
}

function constructNewCoordinates(polygon) {
  var newCoordinates = [];
  var coordinates = polygon['coordinates'][0];
  for (var i in coordinates) {
    newCoordinates.push(
        new google.maps.LatLng(coordinates[i][1], coordinates[i][0]));
  }
  return newCoordinates;
}

google.maps.event.addDomListener(window, 'load', initialize);
