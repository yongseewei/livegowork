class Job < ActiveRecord::Base
	belongs_to :user
	has_many :job_applications

	geocoded_by :location
	after_validation :geocode

	# validates :avatars, presence: true
	
	# has_many :skills, through: :job_skills
	# has_many :reservations, :dependent => :destroy

	# mount_uploaders :avatars, AvatarUploader

	def confirmed?
		JobApplication.find_by(job_id: self.id, confirmed: true)
	end

	def confirmed_applicant
		applicant = JobApplication.find_by(job_id: self.id, confirmed: true)	
		$confirmed_applicant = User.find(applicant.user_id)
	end

end
