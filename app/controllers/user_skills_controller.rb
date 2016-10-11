class UserSkillsController < ApplicationController

	before_action :find_user_skill, only: [:show, :destroy]

	def index
		@user_skill = User_skill.all
	end

	def show
	end

	def new
		@user_skill = User_skill.new
	end

	def create
		@user_skill = current_user.user_skill.new(user_skill_params)
			if @user_skill.save
       redirect_to root_url
    	else
      	render :new
    	end
	end

	def destroy
		@user_skill.destroy
    redirect_to root_path
	end

	def find_user_skill
		@user_skill = User_skill.find(params[:id])
	end

	private
  def user_skill_params
    params.require(:user_skill).permit(:user_id, :skill_id)
  end


end
