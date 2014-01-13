class PagesController < ApplicationController
  before_filter :check_login
  def index
    @user = current_user;
    @cookie = cookies[:remember_token];
    @count_user = User.all.size;

    # require 'rubygems'
    # require 'bing_translator'
    # translator = BingTranslator.new('dmec-grp4', 'jqoPbCnQliqVj0dTqiLc3V7hoYA138EDKqWftkt6GFo=')
  end

  def getUsers
    postcode = params[:postcode];

    users = User.find_all_by_zipcode(postcode);
    render json: users
  end

  private
  def check_login
    if signed_in?
      redirect_to dashboard_url
    end
  end
end
