class UsersController < ApplicationController
  def new
    @countries = Country.all();
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
    @messages = Message.all.where(:from_user => current_user.id, :message_type => 'web')
    if params[:id].nil?
      @user = current_user
    else
      @user = User.find(params[:id])
    end
  end

  def settings
    @countries = Country.all();
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
    if current_user.radius.nil? || current_user.radius == ''
      returnItem[:radius] = 500;
    else
      returnItem[:radius] = current_user.radius
    end

    if current_user.latitude.nil? || current_user.latitude == ''
      returnItem[:latitude] = 52;
    else
      returnItem[:latitude] = current_user.latitude
    end

    if current_user.longitude.nil? || current_user.longitude == ''
      returnItem[:longitude] = 6;
    else
      returnItem[:longitude] = current_user.longitude
    end

    render json: returnItem
  end

  private
  def user_params
    params.require(:user).permit(:firstname, :lastname, :password, :password_confirmation, :email,:adres,:zipcode,:place,:date_of_birth,:phone,:mobile_phone,:radius,:country_id) if params[:user]
  end

end