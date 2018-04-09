class AddAvatarsToComments < ActiveRecord::Migration
  def self.up
    change_table :comments do |t|
      t.attachment :avatar
    end
  end

  def self.down
    drop_attached_file :comments, :avatar
  end
end
