class AddMessageToJobApplication < ActiveRecord::Migration
  def change
  	add_column :job_applications, :message, :text
  end
end
