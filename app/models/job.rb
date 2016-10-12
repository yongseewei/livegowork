class Job < ActiveRecord::Base
	belongs_to :user
	has_many :job_applications, dependent: :destroy

  scope :salary_range, ->(min, max) { where(salary: min..max)}
  scope :filter_map, ->(loc) { where(salary: loc[:min]..loc[:max]).near([loc[:lat],loc[:lng]],loc[:zoom])}
  scope :filter_price2, ->(loc) {where(salary: loc[:min]..loc[:max])}
  scope :filter_job, ->(job) {where("lower(title) LIKE ?", "#{job[:name].downcase}%")}

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
    min = params.fetch(:min)
    max = params.fetch(:max) == "500" ? "9999" : params.fetch(:max)
    
    return salary_range(min, max) if min && max 
  end

  def confirm_range
    range = []
  	confirmed = self.job_applications.where(confirmed: true)
  	confirmed.each do |application|
      range << {start_date: application.start_date, end_date: application.end_date}
    end
    range
  end

end
