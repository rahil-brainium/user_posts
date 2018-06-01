class RemoveAvatarFromComments < ActiveRecord::Migration
  def change
  	remove_column :comments, :avatar_file_name
    remove_column :comments, :avatar_content_type
    remove_column :comments, :avatar_file_size
    remove_column :comments, :avatar_updated_at
  end
end
