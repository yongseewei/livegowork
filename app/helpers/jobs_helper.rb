module JobsHelper
	def set_marker
		@hash = Gmaps4rails.build_markers(@jobs) do |job, marker|
      marker.lat job.latitude
      marker.lng job.longitude
      marker.picture({
        "url": "http://icons.iconarchive.com/icons/paomedia/small-n-flat/32/map-marker-icon.png",
        "width":  50,
        "height": 50
      })
      marker.infowindow render_to_string(:partial => '/welcome/map', :locals => { :object => job})
    end
	end

	def set_position
    coord = Geocoder.coordinates(@search)
    @hash = Gmaps4rails.build_markers(@search) do |search, marker|
      marker.lat coord[0]
      marker.lng coord[1]
      marker.picture({
      "url": "http://icons.iconarchive.com/icons/paomedia/small-n-flat/32/map-marker-icon.png (1KB) ",
      "width":  0,
      "height": 0
       })
   end
	end
end
