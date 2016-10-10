class AddImagesToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :images, :json
  end
end
