class HomeController < ApplicationController
	def index
		@jobs = Job.all
	end

  def show
    @job = Job.last(3)
  end 

end
