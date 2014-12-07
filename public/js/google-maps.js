;(function(document, window) { function initialize() {
  var styles = [{"featureType":"water","elementType":"all","stylers":[{"hue":"#27b1e4"},{"saturation":60},{"lightness":-31},{"visibility":"on"}]},{"featureType":"landscape","elementType":"all","stylers":[{"hue":"#c0e6f4"},{"saturation":59},{"lightness":-4},{"visibility":"on"}]},{"featureType":"road","elementType":"all","stylers":[{"hue":"#7ed0ee"},{"saturation":-23},{"lightness":20},{"visibility":"on"}]},{"featureType":"administrative","elementType":"all","stylers":[{"hue":"#6fafc7"},{"saturation":44},{"lightness":20},{"visibility":"on"}]},{"featureType":"poi","elementType":"all","stylers":[{"hue":"#aedbec"},{"saturation":33},{"lightness":11},{"visibility":"on"}]},{"featureType":"transit","elementType":"all","stylers":[{"hue":"#aedbec"},{"saturation":62},{"lightness":22},{"visibility":"off"}]},{"featureType":"road.local","elementType":"all","stylers":[{"hue":"#dceff6"},{"saturation":-41},{"lightness":-9},{"visibility":"off"}]},{"featureType":"landscape.man_made","elementType":"all","stylers":[{"hue":"#dceff6"},{"saturation":44},{"lightness":22},{"visibility":"on"}]}];

  var myLatlng = new google.maps.LatLng(0,0);
  var mapOptions = {
    zoom: 2,
    mapTypeId: 'terrain',
    center: myLatlng,
    styles: styles
  };
  var map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions);
  var markers = [];
  var coords = JSON.parse($('div.coords').html());
  for (var i = coords.length - 1; i >= 0; i--) {
    var markerImage = coords[i][2];
    var markerLatlng = new google.maps.LatLng(coords[i][0],coords[i][1]);
    var marker = new google.maps.Marker({
        position: markerLatlng,
        map: map,
        icon: markerImage,
        title: 'Hello World!'
    });
    markers.push(marker);
  }
  function AutoCenter() {
    // Create a new viewpoint bound
    var bounds = new google.maps.LatLngBounds();
    // Go through each...
    $.each(markers, function (index, marker) {
    bounds.extend(marker.position);
    });
    // Fit these bounds to the map
    map.fitBounds(bounds);
  }
  AutoCenter();
  // var markerOpts = {
  //   url: "/images/Twitter_logo_blue.png",
  //   height: 50,
  //   width: 50
  // };
  var markerCluster = new MarkerClusterer(map, markers);
  // var markerCluster = new MarkerClusterer(map, markers, {styles:[markerOpts]});
}
google.maps.event.addDomListener(window, 'load', initialize);
})(document, window);