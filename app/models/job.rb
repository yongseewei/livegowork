class Job < ActiveRecord::Base
	belongs_to :user
	has_many :job_applications

  scope :salary_range, ->(min, max, id) { where(salary: min..max, id: id)}
  scope :filter_map, ->(loc) { where(salary: loc[:min]..loc[:max]).near([loc[:lat],loc[:lng]],loc[:zoom])}

	geocoded_by :location
	after_validation :geocode

	mount_uploaders :images, ImageUploader

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

	def self.filter_price(params)
		id = params[:jobs].split(" ")
    min = params.fetch(:min)
    max = params.fetch(:max) == "500" ? "9999" : params.fetch(:max)
    
    return salary_range(min, max, id) if min && max 
  end
end
