class User < ActiveRecord::Base
  include Clearance::User

  has_many :jobs, dependent: :destroy
  has_many :relationships
end
