class JobApplicationsController < ApplicationController

  before_action :find_job_application, only: [:show, :destroy, :confirm_job_application]
 	def new #
 		
 		@job_application = JobApplication.new

 	end 

	def index
		@job_applications = JobApplication.all
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

	def confirm_job_application #update method confirms the booking
		
		@job_application.update(confirmed: true)
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
    params.require(:job_application).permit(:user_id, :job_id)
  end


end
