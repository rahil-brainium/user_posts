class RemoveColumnNameFromPictures < ActiveRecord::Migration
  def change
  	remove_column :pictures, :name, :string
  end
end
