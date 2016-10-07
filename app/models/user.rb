class User < ActiveRecord::Base
  include Clearance::User

  #following/followers
  has_many :jobs, dependent: :destroy #remove a user post if the account is deleted
  has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy #if either one user is deleted, the post is deleted as well
  has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy #active relationship is when you are following someone. Passive relationship is when someone is following you.
  
  has_many :following, through: :active_relationships, source: :followed 
  has_many :followers, through: :passive_relationships, source: :follower


  #helper method

  #follow another user
  def follow(other)
  	active_relationships.create(followed_id: other.id)
  end

  #unfollow a user
  def unfollow(other)
  	active_relationships.find_by(followed_id: other.id).destroy
  end

  #is following a user?
  def following(other)
  	following.include(other)
  end
end