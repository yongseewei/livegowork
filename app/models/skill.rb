class Skill < ActiveRecord::Base
	# has_many :users, through: :user_skills 
	has_many :user_skills, :dependent => :destroy
end
