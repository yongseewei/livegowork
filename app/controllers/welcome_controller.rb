class WelcomeController < ApplicationController
	def home
		@search = params[:query].presence
		if @search
			# poi = Yelp.client.search(@search, params)
			location = Geocoder.search(@search)
			coord = location[0].data["geometry"]["location"]
			@jobs = Job.near([coord["lat"],coord["lng"]],2.33)
		else
			@jobs = Job.all
		end
		if params[:lat].presence
			zoom =  Math.exp((14.23 - params[:zoom].to_f)*Math.log(2))
			@jobs = Job.near([params[:lat].to_f,params[:lng].to_f],zoom)
		end
		if @jobs.length != 0
			@hash = Gmaps4rails.build_markers(@jobs) do |job, marker|
			  marker.lat job.latitude
			  marker.lng job.longitude
		    marker.picture({
	        "url": "http://icons.iconarchive.com/icons/paomedia/small-n-flat/32/map-marker-icon.png",
	        "width":  50,
	        "height": 50
	      })
	      marker.infowindow render_to_string(:partial => '/common/mapInfo', :locals => { :object => job})
			end
			# byebug
		else
			@hash = Gmaps4rails.build_markers(@search) do |search, marker|
			  marker.lat coord["lat"]
			  marker.lng coord["lng"]
			  marker.picture({
	        "url": "http://icons.iconarchive.com/icons/paomedia/small-n-flat/32/map-marker-icon.png",
	        "width":  0,
	        "height": 0
	      })
		  end
		end
		respond_to do |format|
      format.js # index.js.erb
      format.html # index.html.erb
    end
		# if poi
		# 	@hash2 = Gmaps4rails.build_markers(poi.businesses) do |search, marker|
		# 	  marker.lat search.location.coordinate.latitude
		# 	  marker.lng search.location.coordinate.longitude
		# 	  marker.picture({
	 #        "url": "https://cdn3.iconfinder.com/data/icons/map-markers-1/512/shopping-32.png",
	 #        "width":  50,
	 #        "height": 50
	 #      })
	 #      marker.infowindow render_to_string(:partial => '/welcome/shopping', :locals => { :object => search})
		#   end
  # 		@hash += @hash2
		# end
		# byebug

	end
end
