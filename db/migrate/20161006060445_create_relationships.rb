class CreateRelationships < ActiveRecord::Migration
  def change
    create_table :relationships do |t|
      t.integer :user_id
      t.integer :followed_id

      t.timestamps null: false
    end
  end
end
