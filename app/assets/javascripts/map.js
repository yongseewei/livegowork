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
  		type: 'POST',
  		url: '/jobs/filter',
  		data:  {filter_map: { lat: handler.map.serviceObject.center.lat(), 
  						 lng: handler.map.serviceObject.center.lng(), 
  						 zoom: zoom_to_radius(),
  						 min: $("#slider-range").slider("values", 0),
  						 max: max_price() }},
  		dataType: "script",
  		success: function(msg) {
  			redraw_marker()
  		}
  	});
	}

	function redraw_marker(){
		for (var i = 0; i < markers.length; i++) {
      markers[i].setMap(null);
      handler.removeMarkers(markers);
    }
    markers = [];
    markers = handler.addMarkers(markerabc);
    handler.bounds.extendWith(markers);
	}

	function zoom_to_radius(){
		return Math.exp((14.24 - handler.map.serviceObject.zoom)*Math.log(2))
	}

	function max_price(){
		var max = $("#slider-range").slider("values", 1) 
		if (max == "500"){
			return "9999"
		}else{
			return max
		}
	}
});