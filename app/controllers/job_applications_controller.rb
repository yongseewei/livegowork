class JobApplicationsController < ApplicationController
  include JobsHelper
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

		@job_application = current_user.job_applications.new(job_application_params)
		@job = @job_application.job
		if @job_application.save
			#create a notification
			@job.users.uniq - [current_user]).each do |user|
				Notification.create(recipient:user, actor: current_user, action: "posted", notifiable: @job_application)
			end
			# job_id = @job_application.job_id
			# @job = Job.find(job_id)
			flash[:success] = "Thanks for your interest in this job! You will hear if you were successful soon."
			# JobApplicationMailer.delay_for(2.seconds).confirmation_email(current_user, @job, @job_application)
      redirect_to @job_application.job
  	else
  		gon.reservations = taken_date
  		render 'jobs/show'
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
    params.require(:job_application).permit( :job_id, :end_date, :start_date)
  end
end
