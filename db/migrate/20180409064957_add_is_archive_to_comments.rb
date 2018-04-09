class AddIsArchiveToComments < ActiveRecord::Migration
  def change
    add_column :comments, :is_archive, :boolean, :default => false
  end
end
