class ApplicationController < ActionController::Base
  include Clearance::Controller
  before_action :create_user
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private
  def create_user
 		@user = User.new unless signed_in?
  end
end
