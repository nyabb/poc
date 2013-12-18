class PagesController < ApplicationController
  before_filter :check_login
  def index
    @user = current_user;
    @cookie = cookies[:remember_token];
    # require 'rubygems'
    # require 'bing_translator'
    # translator = BingTranslator.new('dmec-grp4', 'jqoPbCnQliqVj0dTqiLc3V7hoYA138EDKqWftkt6GFo=')
  end

  private
  def check_login
    if signed_in?
      redirect_to dashboard_url
    end
  end
end
