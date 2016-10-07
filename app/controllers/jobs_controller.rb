class JobsController < ApplicationController

  before_action :find_job, only: [:show, :edit, :destroy, :update]

  def index
  	@jobs = Job.all # index function
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