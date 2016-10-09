class ReviewsController < ApplicationController

before_action :find_review, only: [:show]

	def index
		@reviews = Review.all
	end

	def show
	end

	def new
	end

	def create
		
    @review = Review.new(review_params)
    
    if @review.save
       redirect_to user_path(current_user)
    else
      render :new
    end
	end

	def find_review
		@review = Review.find(params[:id])
	end


private

  def review_params
    params.require(:review).permit(:reviewer_id, :reviewee_id, :score, :comments)
  end

end
