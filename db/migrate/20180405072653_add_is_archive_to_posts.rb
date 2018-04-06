class AddIsArchiveToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :is_archive, :boolean, default: false
  end
end
