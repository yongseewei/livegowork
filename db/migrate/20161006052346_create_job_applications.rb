class CreateJobApplications < ActiveRecord::Migration
  def change
    create_table :job_applications do |t|
      t.integer :user_id
      t.integer :job_id
      
      t.timestamps null: false
    end
  end
end
