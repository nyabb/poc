class ReactionsController < ApplicationController

  before_filter :secure_page

  def create
    @user = current_user
    if @user.present?
      @reaction = Reaction.new(reaction_params)
      @reaction.userId = current_user.id
      @reaction.save
      flash[:correct] = 'Reactie is geplaatst!'
      redirect_to @reaction.offer
    else
      redirect_to offer_url
    end
  end

  def new
    @reaction = Reaction.new
  end

  def reaction_params
    params.permit(:react_type, :message, :react_to, :userId)
  end
end
