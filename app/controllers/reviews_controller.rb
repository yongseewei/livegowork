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
    @review = current_user.reviews.new(review_params)
    
    if @review.save
       redirect_to root_url
    else
      render :new
	end

	def find_review
		@review = Review.find(params[:id])
	end

private

  def review_params
    params.require(:review).permit(:reviewer_id, :reviewee_id, :score)
  end

end
