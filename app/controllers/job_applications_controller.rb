class JobApplicationsController < ApplicationController

  before_action :find_job_application, only: [:show, :destroy, :update]
 	def new 
 		@job_application = JobApplication.new
 	end 

	def index
		@job_application = JobApplication.where(job_id: params[:job_id])
	end

	def show
	end

	def create
		@job_application = JobApplication.new(job_application_params)
			if @job_application.save
				# job_id = @job_application.job_id
				# @job = Job.find(job_id)
				flash[:success] = "Thanks for your interest in this job! You will hear if you were successful soon."
				# JobApplicationMailer.delay_for(2.seconds).confirmation_email(current_user, @job, @job_application)
	      redirect_to @job_application.job
	  	else
	    	redirect_to job_path(params[:job_application][:job_id])
	  	end
	end

	def update 	
		@job_application.update(confirmed: true)
		flash[:success] = "You have confirmed this applicant for your job!"
		redirect_to @job_application.job
	end

	def destroy
		@job_application.destroy
    redirect_to root_path
	end

	def find_job_application
		@job_application = JobApplication.find(params[:id])
	end
	
	private

  def job_application_params
    params.require(:job_application).permit(:user_id, :job_id, :job_application_id)
  end
end
