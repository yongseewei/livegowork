class JobsController < ApplicationController
  include JobsHelper
  before_action :find_job, only: [:show, :edit, :destroy, :update]

  def index
  	@search = params[:query].presence || "Kuala Lumpur"
    @jobs = Job.near(@search,8)
    filtering_params(params).each do |key, value|
      @jobs = @jobs.public_send(key, value) if value.present?
    end
    @jobs.length == 0 ? set_position : set_marker
    respond_to do |format|
      format.js
      format.html
    end
  end

  def filter
    @jobs = Job.where(id: filtering_id(params).split(" ")) if filtering_id(params).present?
    filtering_params(params).each do |key, value|
      if value.present?
        @jobs = @jobs.nil? ? Job.public_send(key, value) : @jobs.public_send(key, value)
      end
    end
    set_marker
  end

  def show
    gon.reservations = taken_date
    @images = @job.images.sample(4)
    @job_application = JobApplication.new
  end

  def new
    @job = Job.new
  end	

  def create   
    @job = current_user.jobs.new(job_params)
    if @job.save
      redirect_to @job, notice: "Successfully create new job!"
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
    params.require(:job).permit(:title, :description, :location, :salary, :start_date,:end_date, {images: []}, {:tag_ids=>[]}, :user_id )
  end

  def filtering_params(params)
    params.slice(:filter_map, :filter_price, :filter_price2, :filter_job)
  end

  def filtering_id(params)
    params.slice(:filter_id).values[0]
  end
end

