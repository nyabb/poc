class MessagesController < ApplicationController
  def index
    index_messages
    @current_user = current_user
  end

  def indexer
    index_messages
    @current_user = current_user
    messages = @current_user.unread_messages.reverse!
    render json: messages
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
  def index_messages
    require 'net/http'
    @current_user = current_user

    uri = 'http://www.willemvanlent.nl/dmec/index.php?action=getMessages&lastId=' + Message.all.reverse[0].id.to_s
    json_String = Net::HTTP.get(URI.parse(uri))
    messages = ActiveSupport::JSON.decode(json_String)
    messages.each do |message|
      user = User.where(mobile_phone: message["from"]).take
      unless user.nil?
        Message.create(:id => message["id"],:from_user => user.id, :to_user => @current_user.id, :body => message["message"], :message_type => 'sms', :read => 0)
      end
    end

    messages
  end

  def send_message (user, message, receiver)
    require 'net/http'
    uri = 'https://rest.nexmo.com/sms/json?api_key=1535ce1b&api_secret=edaf2405&from=' + user.firstname + '&to=' + receiver.mobile_phone + '&text=' + message
    Net::HTTP.get(URI.parse(URI.encode(uri)))
  end
end
