class ChatsController < ApplicationController
  def index
  end
  def show
    render :layout => false
    if(params[:id] == current_user.id)
      redirect_to root
    end
    @to_user = User.find(params[:id]);
    if !@to_user
        redirect_to root
    end
    @messages = Message.chatfeed(@to_user.id,current_user.id);
  end
  def new
    @message = Message.new(from_user: current_user.id,to_user: params['to_user'],body:params['body'],message_type:'chat');
    if @message.save
      render :json => {sender: current_user,message:@message} # send back any data if necessary
    else
      render :json => { }, :status => 500
    end
  end
end
