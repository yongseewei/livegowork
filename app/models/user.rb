class User < ActiveRecord::Base
  include Clearance::User

  has_many :jobs
  has_many :job_applications

	def applied?(job)
		JobApplication.find_by(user_id: self.id, job_id: job.id)
	end
  
end
