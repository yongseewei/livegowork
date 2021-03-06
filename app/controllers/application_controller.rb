class ApplicationController < ActionController::Base
  include Clearance::Controller
	before_action :find_message
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private
  def find_message
		@messages = current_user.messages.order("created_at ASC") if signed_in?
		@message  = Message.new
  end
end
