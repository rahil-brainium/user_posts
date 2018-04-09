class RemoveIsLikedFromPosts < ActiveRecord::Migration
  def change
    remove_column :posts, :is_liked, :boolean
  end
end
