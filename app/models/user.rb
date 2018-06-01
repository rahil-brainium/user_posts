class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable,:omniauthable, omniauth_providers: [:google_oauth2]
  
  has_many :posts
  has_many :pictures, :as => :imageable
  # has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  # validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/


  def self.from_omniauth(access_token)
    data = access_token.info
    user = User.where(email: data['email']).first
    # unless user
    #   user = User.create(name: data['name'],
    #     email: data['email'],
    #     password: Devise.friendly_token[0,20]
    #   )
    # end
    user
  end
end
