
$(function() {
	$( "#slider-range" ).slider({
	  range: true,
	  min: 0,
	  max: 500,
	  values: [ 0, 300 ],
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
		$.ajax({
			type: 'POST',
			url: $(this).attr('action'),
			data: $(this).serialize(),
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
	});
	$( "#amount" ).val( "RM" + $( "#slider-range" ).slider( "values", 0 ) +
	  " - RM" + $( "#slider-range" ).slider( "values", 1 ) );
});
