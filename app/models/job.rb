class Job < ActiveRecord::Base
	belongs_to :user
	has_many :job_applications

	# validates :avatars, presence: true
	
	# has_many :skills, through: :job_skills
	# has_many :reservations, :dependent => :destroy

	# mount_uploaders :avatars, AvatarUploader

end
