class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.boolean :is_liked,:default => false
      t.integer :user_id
      t.integer :post_id

      t.timestamps null: false
    end
  end
end
