class AuthenticationsController < ApplicationController
  def index
    @authentications = current_user.authentications if current_user
  end

  def create
    auth = request.env["omniauth.auth"];

    authentication = Authentication.find_by_provider_and_uid(auth['provider'], auth['uid'])
    if authentication
      # Logged in
      session[:user_id] = authentication.user_id;
    else
      # Register auth
      @auth = auth;
      if current_user
        #Add provider to logged user
        current_user.add_provider(auth);
      else
        #Find user, add provider
        if(@user = User.find_by_email(auth['info']['email']))
          @user.add_provider(auth);
          session[:user_id] = @user.id;
        else
          #Create User, add provider
          require 'securerandom'
          pass = SecureRandom.hex();
          @user = User.create(:firstname => auth['info']['first_name'],:lastname => auth['info']['last_name'],:email => auth['info']['email'],:password => pass, :password_confirmation => pass);
          if @user.save
            Emailer.registration_from_oauth(@user,pass).deliver!;
            @user.add_provider(auth);
            session[:user_id] = @user.id;
          end
        end
      end
    end
    redirect_to dashboard_url
  end
end
