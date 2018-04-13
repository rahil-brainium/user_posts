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
end

