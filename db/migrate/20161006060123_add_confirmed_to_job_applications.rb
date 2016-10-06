class AddConfirmedToJobApplications < ActiveRecord::Migration
  def change
  	add_column :job_applications, :confirmed, :boolean, :default => false 
  end
end
