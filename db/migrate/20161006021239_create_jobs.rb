class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.string :title
      t.text :description
      t.string :location
      t.integer :user_id
      t.integer :salary

      t.timestamps null: false
    end
  end
end
