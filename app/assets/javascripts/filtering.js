
$(function() {
	$( "#slider-range" ).slider({
	  range: true,
	  min: 0,
	  max: 500,
	  values: [ 0, 500 ],
	  slide: function( event, ui ) {
	    $( "#amount" ).val( "RM" + ui.values[ 0 ] + " - RM" + ui.values[ 1 ] );
	  },
	  change: function(event, ui) {
			$("#filter_price_min").attr('value', $("#slider-range").slider("values", 0));
			$("#filter_price_max").attr('value', $("#slider-range").slider("values", 1));
			$(this).parent().submit();
		}
	});

	$("#price-filter").submit(function(event){
		event.preventDefault();
		var data = $(this).serialize();
		if ($("#filter-job").val() != ""){
			var data2 = {filter_job: {name: $("#filter-job").val()}}
			data = data + '&' + $.param(data2)
		}
		$.ajax({
			type: 'POST',
			url: $(this).attr('action'),
			data: data,
			dataType: "script",
			success: function(msg) {
				redraw_marker()
			}
		});
	});

	

	$(document).on("submit","#job-filter",function(event){
		event.preventDefault();
		var data = {filter_price2: {min: $("#slider-range").slider("values", 0),max: max_price() }}
		$.ajax({
			type: 'POST',
			url: $(this).attr('action'),
			data: $(this).serialize() + '&' + $.param(data),
			dataType: "script",
			success: function(msg) {
        redraw_marker();
      }
		});
	});

	function redraw_marker(){
		for (var i = 0; i < markers.length; i++) {
      markers[i].setMap(null);
      handler.removeMarkers(markers);
    }
    markers = [];
    markers = handler.addMarkers(markerabc);
    handler.bounds.extendWith(markers);
	}

	function max_price(){
		var max = $("#slider-range").slider("values", 1) 
		if (max == "500"){
			return "9999"
		}else{
			return max
		}
	}

	$( "#amount" ).val( "RM" + $( "#slider-range" ).slider( "values", 0 ) +
	  " - RM" + $( "#slider-range" ).slider( "values", 1 ) );
});
