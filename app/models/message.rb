class Message < ActiveRecord::Base
  #after_find :read_message

  belongs_to :user

  belongs_to :receiver, :class_name => 'User', :foreign_key => 'to_user'
  belongs_to :sender, :class_name => 'User', :foreign_key => 'from_user'

  def self.received_messages(user, textId)
    Message.where(:to_user => user.id,).where("id > ?", textId).reverse!
  end

  def self.chatfeed(from_user, to_user)
    Message.where(from_user: [from_user, to_user], to_user: [from_user, to_user], message_type: 'chat');
  end
  def self.getwebmessages
    messages = []
    all_messages = Message.all.select("Distinct(from_user)").group(:from_user, :id,:to_user, :body, :message_type, :reactions_to)
    all_messages.each do |web_message|
       message = Message.order("created_at DESC").where(:message_type => 'web').find_by_from_user (web_message.from_user)
       messages << message
      end
    messages
  end

  def self.getwebreactions
    messages =  Message.all.where(:message_type => 'reactions', :to_user => @current_user)
    messages
  end

  private

  def read_message
    self.update(:read => true)
  end
end
