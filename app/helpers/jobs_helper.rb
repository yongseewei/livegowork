module JobsHelper
	def set_marker
		@hash = Gmaps4rails.build_markers(@jobs) do |job, marker|
      marker.lat job.latitude
      marker.lng job.longitude
      marker.picture({
        # "url": "http://icons.iconarchive.com/icons/icons-land/vista-map-markers/32/Map-Marker-Marker-Outside-Pink-icon.png",
        "url": "marker-red.png",
        "width":  50,
        "height": 50
      })
      marker.infowindow render_to_string(:partial => '/common/mapInfo', :locals => { :object => job})
    end
	end

	def set_position
    coord = Geocoder.coordinates(@search)
		@hash = Gmaps4rails.build_markers(@search) do |search, marker|
      marker.lat coord[0]
      marker.lng coord[1]
      marker.picture({
        "url": "marker-red.png",
        "width":  0,
        "height": 0
      })
    end
	end

  def taken_date
    date_s, date_e = [], []
    @job.job_applications.each do |val|
      date_s += [*val.start_date..val.end_date] if val.confirmed == true
    end
    date_e = [@job.start_date,@job.end_date]
    [date_s,date_e]
  end
end
