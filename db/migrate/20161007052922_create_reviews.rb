class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.integer :reviewer_id
      t.integer :reviewee_id
      t.integer :score
      t.text :comments

      t.timestamps null: false
    end
  end
end
