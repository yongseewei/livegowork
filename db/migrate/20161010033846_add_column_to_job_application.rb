class AddColumnToJobApplication < ActiveRecord::Migration
  def change
  	add_column :job_applications, :start_date, :date
  	add_column :job_applications, :end_date, :date
  end
end
