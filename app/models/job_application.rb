class JobApplication < ActiveRecord::Base

	belongs_to :user
	belongs_to :job

	validates :user_id, :presence => true
	validates :start_date, :presence => true
	validates :end_date, :presence => true
	# validate :check_date


  def check_clash?

  	if self.confirmed == true
  		return false
  	else
			confirmed_dates = self.job.confirm_range
  		confirmed_dates.each do |date_hash|
	  		if self.start_date.between?(date_hash[:start_date], date_hash[:end_date]) || self.end_date.between?(date_hash[:start_date], date_hash[:end_date])
	  			return true
		  	end
		  end
		  return false
	  end
  end


	private

	def check_date
		empty = 0
		self.job.job_applications.each do |reserve|
			empty += 1 if (reserve.start_date..reserve.end_date).overlaps?(self.start_date..self.end_date)
		end
		if empty > 0
			errors.add(:date, "is not available")
		end
  end



end
