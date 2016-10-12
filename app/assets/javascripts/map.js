$(document).on("turbolinks:load",function(){
	$("#query").geocomplete();

	handler = Gmaps.build('Google');

	handler.buildMap({ provider: {}, internal: {id: 'map'}}, function(){
	  markers = handler.addMarkers(markerabc);
	  handler.bounds.extendWith(markers);
	  handler.fitMapToBounds();
	  handler.getMap().setZoom(zoom);
	  handler.map.centerOn(center_build);
	  
	  google.maps.event.addListener(handler.getMap(), 'zoom_changed', function(e) {
		  map_ajax();
	  })
	  google.maps.event.addListener(handler.getMap(), 'dragend', function() {
	  	map_ajax();
	  })
	});

	$(document).on("mouseover","#list_job .box",function(event){
		var index = $(this).index();
		markers[index].setMap(null);
    handler.removeMarker(markers[index]);
    gr = {
      "lat": markerabc[index].lat,
      "lng": markerabc[index].lng,
      "picture": {
        "url": "marker-blue.png","width":  50,"height": 50     
      }
    }
    gr.marker = handler.addMarker(gr);
	}).on("mouseout","#list_job .box",function(event){
		var index = $(this).index()
		handler.removeMarker(gr.marker);
   	markers[index] = handler.addMarker(markerabc[index]);
	})

	$(document).on("submit","#search-submit2",function(event){
		event.preventDefault();
		var data = {filter_price2: {min: $("#slider-range").slider("values", 0),max: max_price() }}
		if ($("#filter-job").val() != ""){
			var data2 = {filter_job: {name: $("#filter-job").val()}}
			data = $.param(data) + '&' + $.param(data2)
		} else{
			data = $.param(data)
		}
		$.ajax({
			type: 'GET',
			url: $(this).attr('action'),
			data: $(this).serialize() + '&' + data,
			dataType: "script",
			success: function(msg) {
				for (var i = 0; i < markers.length; i++) {
		      markers[i].setMap(null);
		      handler.removeMarkers(markers);
		    }
				markers = [];
        handler = new Gmaps.build('Google');

				handler.buildMap({ provider: {}, internal: {id: 'map'}}, function(){

				  markers = handler.addMarkers(markerabc);
				  handler.bounds.extendWith(markers);
				  handler.fitMapToBounds();
				  handler.getMap().setZoom(zoom);
				  handler.map.centerOn(center_build);
				  
				  google.maps.event.addListener(handler.getMap(), 'zoom_changed', function(e) {
					  map_ajax();
				  })
				  google.maps.event.addListener(handler.getMap(), 'dragend', function() {
				  	map_ajax();
				  })
				});
      }
		});
	});


	function map_ajax(){
		$.ajax({
  		type: 'POST',
  		url: '/jobs/filter',
  		data:  {filter_map: { lat: handler.map.serviceObject.center.lat(), 
  						 lng: handler.map.serviceObject.center.lng(), 
  						 zoom: zoom_to_radius(),
  						 min: $("#slider-range").slider("values", 0),
  						 max: max_price() },
  						 filter_job: {name: $("#filter-job").val()}
  						},
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
		return 1.74*Math.exp((14.24 - handler.map.serviceObject.zoom)*Math.log(2))
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