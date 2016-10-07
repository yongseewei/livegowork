class User < ActiveRecord::Base
  include Clearance::User
  #following/followers
  has_many :jobs, dependent: :destroy #remove a user post if the account is deleted
  has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy #if either one user is deleted, the post is deleted as well
  has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy #active relationship is when you are following someone. Passive relationship is when someone is following you.
  
  has_many :following, through: :active_relationships, source: :followed 
  has_many :followers, through: :passive_relationships, source: :follower

  has_many :job_applications

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
end
