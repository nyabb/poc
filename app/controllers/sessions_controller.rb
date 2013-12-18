class SessionsController < ApplicationController
  before_action :check_login, :except => ["destroy"]
  def new
  end
  def create
    user = User.find_by_email(params[:session][:email].downcase);
    if user
      if user.authenticate(params[:session][:password])
        session[:user_id] = user.id;
        if params[:session][:remember_me] == '1'
          remember_token = User.new_remember_me_token
          cookies[:remember_token] = remember_token
          user.update_attribute(:remember_token, User.encrypt(remember_token))
        end
        redirect_to root_url
      else
        flash[:succes] = "Ongelodig wachtwoord."
        render "new"
      end
    else
       flash[:succes] = "Ongelodig email."
      render "new"
    end
  end
  def destroy
    session[:user_id] = nil;
    cookies.delete :remember_token;
    redirect_to root_url
  end
  def store_return_to
    session[:return_to] = request.url
  end
  private
  def check_login
    if signed_in?
      redirect_to dashboard_url
    end
  end

end

