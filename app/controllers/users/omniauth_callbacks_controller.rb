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
      @user = User.create(:email => email,:password => "test123",:sign_in_type => "google")
      sign_in_and_redirect @user, event: :authentication
      flash[:notice] = "Your password is test123"
    end
  end
end

