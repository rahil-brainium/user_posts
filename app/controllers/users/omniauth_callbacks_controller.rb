class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController


  def google_oauth2
    email = request.env['omniauth.auth']['info']['email']
    @user = User.all.where("email =?",email).first
    if @user.present?
      if @user.sign_in_type.eql? "google"
        sign_in_and_redirect @user, event: :authentication
      else
        flash[:notice] = "You have already have an account!!!"
        redirect_to new_user_session_path
      end
    else
      @user = User.create(:email => email,:sign_in_type => "google")
      @user.save(validate: false)
      sign_in_and_redirect @user, event: :authentication
      flash[:notice] = "You have successfully signed in"
    end
  end
  def facebook
    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user.persisted?
      sign_in_and_redirect @user, :event => :authentication
      set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end


end

