class User < ActiveRecord::Base
  include Clearance::User
  #following/followers
  has_many :jobs, dependent: :destroy #remove a user post if the account is deleted
  has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy #if either one user is deleted, the post is deleted as well
  has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy #active relationship is when you are following someone. Passive relationship is when someone is following you.

  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  #notifications
  has_many :notifications, foreign_key: :recipient_id

  has_many :job_applications, :dependent => :destroy

  has_many :reviews, :dependent => :destroy
  has_many :reviews, foreign_key: "reviewer_id", dependent: :destroy
  has_many :reviews, foreign_key: "reviewee_id", dependent: :destroy

  has_many :skills, through: :user_skills
  has_many :user_skills

  has_many :authentications, :dependent => :destroy


  has_attached_file :avatar, styles: { medium: "140x140#", thumb: "100x100#" ,small_thumb: "60x60#"}, default_url: "missing.png"
  
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/


  #helper method
  def show
    @user = User.find(params[:id])
  end

  #follow another user
  def follow(other)
  	active_relationships.create(followed_id: other.id)
  end

  #unfollow a user
  def unfollow(other)
  	active_relationships.find_by(followed_id: other.id).destroy
  end

  #is following a user?
  def following?(other)
  	following.include?(other)
  end

	def applied?(job)
		JobApplication.find_by(user_id: self.id, job_id: job.id)
	end


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

  def taken_job?(user)

    JobApplication.where(user_id: user.id, confirmed: true).any?
  end

  def posted_job?(user)
    Job.where(user_id: user.id).any?
  end

  def full_name
    "#{first_name} #{last_name}"
  end
end
