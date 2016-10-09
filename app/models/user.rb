class User < ActiveRecord::Base
  include Clearance::User

  has_many :jobs, :dependent => :destroy
  has_many :job_applications, :dependent => :destroy
  has_many :reviews, :dependent => :destroy

  # ratyrate_rateable 'score'
  # ratyrate_rater

	def applied?(job)
		JobApplication.find_by(user_id: self.id, job_id: job.id)
	end

  has_many :authentications, :dependent => :destroy

  def self.create_with_auth_and_hash(authentication,auth_hash)
    
    create! do |u|

      u.first_name = auth_hash["info"]["first_name"]
      u.last_name = auth_hash["info"]["last_name"]
      u.gender = auth_hash["extra"]["raw_info"]["gender"]
      u.dob = auth_hash["extra"]["raw_info"]["birthday"]
      u.email = auth_hash["extra"]["raw_info"]["email"]
      u.password = SecureRandom.hex(6)
      u.authentications<<(authentication)
    end
  end

  def fb_token
    x = self.authentications.where(:provider => :facebook).first
    return x.token unless x.nil?
  end

  def password_optional?
    true
  end


  def self.by_reviews #(page)
    joins(:reviews).group('users.id').order('SUM(points.value) DESC')
  end

  def review_score
    sum = Review.where(reviewee_id: self.id).sum(:score)
    count = Review.where(reviewee_id: self.id).count.to_f
    (sum / count).to_f.round(1)
    # self.reviews.sum(:score)
  end

  def review
    Review.where(reviewee_id: self.id)
  end

  def check_if_reviewed?(user)
    Review.where(reviewer_id: user.id, reviewee_id: self.id).any?
  end

  def taken_job?
    JobApplication.where(user_id: self.id, confirmed: true).any?
  end

  def posted_job?(user)
    Job.where(user_id: user.id).any?
  end

  def full_name
    "#{first_name} #{last_name}"
  end

end
