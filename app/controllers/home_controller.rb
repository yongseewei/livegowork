class HomeController < ApplicationController

  def show
    @job = Job.last(3)
  end 

end
