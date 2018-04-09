class AddIsLikedToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :is_liked, :boolean,:default => false
  end
end
