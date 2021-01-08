# frozen_string_literal: true

require 'date'

class Chat
  attr_reader :id, :sender, :receiver, :message, :created_at

  def initialize(id:, sender:, receiver:, message:, created_at:)
    @id = id
    @sender = sender
    @receiver = receiver
    @message = message
    @created_at = @created_at
  end

  def self.create(sender:, receiver:, message:)
    con = if ENV['ENVIRONMENT'] == 'test'
            PG.connect(dbname: 'makersbnb_test')
          else
            PG.connect(dbname: 'makersbnb')
          end
    created_at = Time.now
    result = con.exec("INSERT INTO chats (sender, receiver, message, created_at) VALUES ('#{sender}', '#{receiver}', '#{message}', '#{created_at}') RETURNING id, sender, receiver, message, created_at;")
    Chat.new(id: result[0]['id'], sender: result[0]['sender'], receiver: result[0]['receiver'], message: result[0]['message'], created_at: result[0]['created_at'])
  end

  def self.all
    con = if ENV['ENVIRONMENT'] == 'test'
            PG.connect(dbname: 'makersbnb_test')
          else
            PG.connect(dbname: 'makersbnb')
          end
    result = con.exec('SELECT * FROM chats')
    result.map do |chat|
      Chat.new(id: chat['id'], sender: chat['sender'], receiver: chat['receiver'], message: chat['message'], created_at: chat['created_at'])
    end
  end
end
