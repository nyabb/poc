class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id;
      if signed_in?
        redirect_to dashboard_url
      end
    end
  end

  def profile
    if params[:id].nil?
      @user = current_user
    else
      @user = User.find(params[:id])
    end
  end

  def settings
  end

  def location
  end

  def offers
  end

  def handleiding
  end

  def address
    @user = current_user;


  end
  def update
    @user = current_user
    if @user.update_attributes(user_params())
      flash[:succes] = "Gegevens succesvol aangepast."
      redirect_to dashboard_url
    else
    end
  end

  def get_offers
    render json: Offer.all
  end

  def save_location
    render json: save_location_factory(current_user, true)
  end

  def current_location
    returnItem = {}
    returnItem[:radius] = current_user.radius
    returnItem[:latitude] = current_user.latitude
    returnItem[:longitude] = current_user.longitude

    render json: returnItem
  end

  private
  def user_params
    params.require(:user).permit(:firstname, :lastname, :password, :password_confirmation, :email,:adres,:zipcode,:place,:date_of_birth,:phone,:mobile_phone,:radius) if params[:user]
  end

end