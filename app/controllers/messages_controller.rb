class MessagesController < ApplicationController
  def index
    index_messages
    @current_user = current_user
    @messages = Message.getwebmessages
  end

  def indexer
    index_messages
    @current_user = current_user
    messages = @current_user.unread_messages.reverse!
    render json: messages
  end

  def create
    @message = Message.new(message_params)
    @message.from_user= @current_user.id
    @message.read=false
    sender = @current_user
    if @message.save
      flash[:notice] = 'U hebt om hulp gevraagd!'
      redirect_to message_url
    else
      flash[:notice] = 'Uw aanvraag is niet gelukt!'
      redirect_to message_url

    end
  end

  def indexerid
    index_messages
    @current_user = current_user
    messages = Message.received_messages(@current_user, params[:id])
    dataArray = Array.new()

    messages.each do |message|
      tmp = {}
      tmp[:message] = message
      tmp[:userName] = message.sender.firstname

      dataArray.push tmp
    end

    render json: dataArray
  end

  def sender
    @current_user = current_user
    message = Message.find(params[:message_id])
    receiver = message.sender
    sender = @current_user

    message.read = true
    message.save

    send_message(sender, params[:message], receiver)

    render json: receiver
  end

  private

  def message_params
    params.permit(:from_user, :to_user, :body, :message_type ,:read)
  end
  def send_message (user, message, receiver)
    require 'net/http'
    uri = 'https://rest.nexmo.com/sms/json?api_key=f1bb3c1l3&api_secret=ff232359&from=' + user.firstname + '&to=' + receiver.mobile_phone + '&text=' + message
    Net::HTTP.get(URI.parse(URI.encode(uri)))
  end
end
