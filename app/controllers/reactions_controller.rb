class ReactionsController < ApplicationController



  def create
    @user = current_user
    @reactions = Reaction.all
    if @user.present?
      @reaction = Reaction.new(reaction_params)
      @reaction.userId = current_user.id
      @reaction.save

      flash[:notice] = 'Reactie is geplaatst!'
      redirect_to cookies[:lastpage]
      end

  end

  def new
    @reaction = Reaction.new
  end

  def reaction_params
    params.permit(:react_type, :message, :react_to, :userId)
  end
end
