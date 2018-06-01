class Post < ActiveRecord::Base
	acts_as_commentable
	belongs_to :user
	has_many :likes
	has_many :pictures, :as => :imageable
end
