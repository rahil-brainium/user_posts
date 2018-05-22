class RemoveDescriptionToPosts < ActiveRecord::Migration
  def change
    remove_column :posts, :description, :string
  end
end
