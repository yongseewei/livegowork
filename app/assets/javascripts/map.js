$(document).ready(function(){

	handler = Gmaps.build('Google');

	handler.buildMap({ provider: {}, internal: {id: 'map'}}, function(){
	  markers = handler.addMarkers(markerabc);
	  handler.bounds.extendWith(markers);
	  handler.fitMapToBounds();
	  handler.getMap().setZoom(13);
	  google.maps.event.addListener(handler.getMap(), 'zoom_changed', function(e) {
	  	// e.preventDefault();
	  	$.ajax({
	  		type: 'GET',
	  		url: '/',
	  		data:  { lat: handler.map.serviceObject.center.lat(), 
	  						 lng: handler.map.serviceObject.center.lng(), 
	  						 zoom: handler.map.serviceObject.zoom },
	  		dataType: "script",
	  		success: function(msg) {
	  			// debugger
	  		}
	  	});
	  	// console.log(handler.map.serviceObject.zoom)
	  	// console.log(handler.map.serviceObject.center.lat())
	  })
	  google.maps.event.addListener(handler.getMap(), 'drag', function() {
	  	console.log(handler.map.serviceObject.zoom)
	  	console.log(handler.map.serviceObject.center.lat())
	  })
	});
	
	
		// google.maps.event.addListener(marker, 'mouseover', function() {
	// 	infowindow.open(map, this);
	// });
	// function zoom(){
 //   current_zoom = handler.map.serviceObject.zoom;
	// }
});