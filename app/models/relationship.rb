class Relationship < ActiveRecord::Base
	belongs_to :follower, class_name: "User"
	belongs_to :followed, class_name: "User" #gives opinion if one is following the other or both are following each other.
	validates :follower_id, presence: true
	validates :followed_id, presence: true #to make sure follower_id and followed_id exist.
end
