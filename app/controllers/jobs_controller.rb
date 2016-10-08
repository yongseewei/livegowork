class JobsController < ApplicationController
  before_action :find_job, only: [:show, :edit, :destroy, :update]

  def index
  	@search = params[:query].presence || "Kuala Lumpur"
    if @search
      location = Geocoder.search(@search)
      coord = location[0].data["geometry"]["location"]
      @jobs = Job.near([coord["lat"],coord["lng"]],2.33)
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
        marker.infowindow render_to_string(:partial => '/welcome/map', :locals => { :object => job})
      end
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
  end

  def show
    @job_application = JobApplication.new
  end

  def new
    @job = Job.new
  end	

  def create
    
    @job = current_user.jobs.new(job_params)
    
    if @job.save
       redirect_to root_url
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @job.update(job_params)
      flash[:success] = 'You have updated your job successfully!'
       redirect_to job_path(@job)
    else
      render :edit
    end
  end

  def destroy
    @job.destroy
    redirect_to root_path
	end

  def find_job
  	@job = Job.find(params[:id])
  end

  private
  def job_params
    params.require(:job).permit(:title, :description, :location, :salary, {avatars:[]}, {:tag_ids=>[]}, :user_id )
  end

end

