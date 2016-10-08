$(document).ready(function(){

	handler = Gmaps.build('Google');

	handler.buildMap({ provider: {}, internal: {id: 'map'}}, function(){
	  markers = handler.addMarkers(markerabc);
	  handler.bounds.extendWith(markers);
	  handler.fitMapToBounds();
	  handler.getMap().setZoom(zoom);
	  google.maps.event.addListener(handler.getMap(), 'zoom_changed', function(e) {
	  	map_ajax();
	  })
	  google.maps.event.addListener(handler.getMap(), 'dragend', function() {
	  	map_ajax();
	  })
	});
	
	function map_ajax(){
		$.ajax({
  		type: 'GET',
  		url: '/jobs',
  		data:  { lat: handler.map.serviceObject.center.lat(), 
  						 lng: handler.map.serviceObject.center.lng(), 
  						 zoom: handler.map.serviceObject.zoom },
  		dataType: "script",
  		success: function(msg) {
  			for (var i = 0; i < markers.length; i++) {
          markers[i].setMap(null);
          handler.removeMarkers(markers);
        }
        markers = [];
        markers = handler.addMarkers(markerabc);
        handler.bounds.extendWith(markers);
  		}
  	});
	}
		// google.maps.event.addListener(marker, 'mouseover', function() {
	
	// 	infowindow.open(map, this);
	// });
	// function zoom(){
 //   current_zoom = handler.map.serviceObject.zoom;
	// }
});