class JobsController < ApplicationController
  include JobsHelper
  before_action :find_job, only: [:show, :edit, :destroy, :update]

  def index
  	@search = params[:query].presence || "Kuala Lumpur"
    @jobs = Job.near(@search,2.33)
    @jobs.length == 0 ? set_position : set_marker
  end

  def filter
    filtering_params(params).each do |key, value|
      @jobs = Job.public_send(key, value) if value.present?
    end
    set_marker
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
    params.require(:job).permit(:title, :description, :location, :salary, {avatars:[]}, {:tag_ids=>[]}, :user_id )
  end

  def filtering_params(params)
    params.slice(:filter_map, :filter_price)
  end
end

