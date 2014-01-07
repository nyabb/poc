class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
   after_filter :save_cookie
  def current_user
    if cookies[:remember_token].present?
      @current_user ||= User.find_by_remember_token(Digest::SHA1.hexdigest(cookies[:remember_token].to_s)) if cookies[:remember_token]# Use find_by_id to get nil instead of an error if user doesn't exist
    else
      @current_user ||= session[:user_id] && User.find_by_id(session[:user_id])
    end
  end

  def signed_in?
    !!current_user
  end

  def save_location_factory(obj, radius)
    if radius
      obj.radius = params[:radius]
    end
    obj.latitude = params[:latitude]
    obj.longitude = params[:longitude]

    obj.save!
  end

  def index_messages
    require 'net/http'
    @current_user = current_user

    mId = 1.to_s;

    unless Message.all.reverse[0].nil?
      mId = Message.all.reverse[0].id.to_s
    end

    uri = 'http://www.willemvanlent.nl/dmec/index.php?action=getMessages&lastId=' + mId
    json_String = Net::HTTP.get(URI.parse(uri))
    messages = ActiveSupport::JSON.decode(json_String)
    messages.each do |message|
      user = User.where(mobile_phone: message["from"]).take
      unless user.nil?
        unless Message.exists?(id: message["id"])
          Message.create(:id => message["id"],:from_user => user.id, :to_user => @current_user.id, :body => message["message"], :message_type => 'sms', :read => 0)
        end
      end
    end

    messages
  end

  private
  def mobile?
    request.user_agent =~ /Mobile|webOS/
  end


  def save_cookie
    cookies[:lastpage] = request.original_url
  end

  private
  def secure_page
    if !signed_in?
      redirect_to root_url
    else
      if current_user.adres.blank? || current_user.zipcode.blank? || current_user.place.blank?
        gflash :success => {:title => 'Fout', :value => "U heeft nog geen adres toegevoegd.<br /><a href='"+settings_adres_url+"'>Klik hier om een adres toe te voegen.</a>", :image => '',:sticky=> true}
      end
    end
  end

  helper_method :current_user
  helper_method :mobile?
  helper_method :secure_page

  before_filter :update_last_online

  private
  def update_last_online
    if signed_in?
      current_user.update_attribute('last_online', DateTime.now);
    end
  end

end
