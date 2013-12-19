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

  private

  def read_message
    self.update(:read => true)
  end
end
