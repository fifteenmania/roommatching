class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  # You should configure your model like this:
  # devise :omniauthable, omniauth_providers: [:twitter]

  # You should also create an action method in this controller like this:
  # def twitter
  # end

  # More info at:
  # https://github.com/plataformatec/devise#omniauth

  # GET|POST /resource/auth/twitter
  # def passthru
  #   super
  # end

  # GET|POST /users/auth/twitter/callback
  # def failure
  #   super
  # end

  # protected

  # The path used when OmniAuth fails
  # def after_omniauth_failure_path_for(scope)
  #   super(scope)
  # end
  def facebook
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    if request.env["omniauth.auth"].extra.raw_info.gender.nil?
      result = {code: 600,msg: "Not Found",result: {}}
      render :json => result.to_json
    else  
      @user = User.from_omniauth(request.env["omniauth.auth"])
        if @user.persisted?
          sign_in @user, :event => :authentication #this will throw if @user is not activated
          set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
          if @user.stage==0
            redirect_to "/profile/new"
          else
            redirect_to "/"
          end
        else
          session["devise.facebook_data"] = request.env["omniauth.auth"]
          # if @user.stage==0
          redirect_to "/profile/new"
          # else
            # redirect_to "/profile/new"
            # redirect_to new_user_registration_url
          # end
        end
    end
  end

  def failure
    redirect_to root_path
  end
end
