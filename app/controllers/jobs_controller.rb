class JobsController < ApplicationController
  include JobsHelper
  before_action :find_job, only: [:show, :edit, :destroy, :update]
  def index
  	@search = params[:query].presence || "Kuala Lumpur"
    if params[:lat].presence
      zoom =  Math.exp((14.24 - params[:zoom].to_f)*Math.log(2))
      @jobs = Job.near([params[:lat].to_f,params[:lng].to_f],zoom)
    elsif filter_params != {}
      # byebug
      @jobs = Job.where(id: params[:jobs].split(" "))
      @jobs = @jobs.filter_by_range(filter_params)
    elsif @search
      location = Geocoder.search(@search)
      @coord = location[0].data["geometry"]["location"]
      @jobs = Job.near([@coord["lat"],@coord["lng"]],2.33)
    end
    if @jobs.length != 0
      set_marker
    else
      set_position
    end
    respond_to do |format|
      format.js # index.js.erb
      format.html # index.html.erb
    end
  end

  def filter
    byebug
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

  def filter_params
    params.permit(:min, :max).reject { |x, y| y.empty? }  
  end

end

