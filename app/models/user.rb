class User < ActiveRecord::Base
  include Clearance::User

  has_many :jobs, :dependent => :destroy
  has_many :job_applications, :dependent => :destroy
  has_many :reviews, :dependent => :destroy

	def applied?(job)
		JobApplication.find_by(user_id: self.id, job_id: job.id)
	end

  has_many :authentications, :dependent => :destroy

  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" ,small_thumb: "50x50>"}, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/

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

  def full_name
    "#{first_name} #{last_name}"
  end

end
