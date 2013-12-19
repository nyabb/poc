class DashboardController < ApplicationController
  before_filter :secure_page
  def index
    gflash :success => {:value => "The product has been created successfully!", :image => '',:sticky=> true}

    @user = current_user;
    @offers = Offer.within((current_user.radius.to_f / 1000).to_f, :origin => @user);

    if params[:radius].present?
      @users = User.within(params[:radius], :origin => @user);
      @radius = (params[:radius].to_f * 1000);
    else
       @users = nil;
       @radius = nil;
    end
  end
end