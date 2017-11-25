require 'sinatra'
require_relative 'encrypted_message'

configure { set :server, :puma }

get "/" do
  render :html, :index
end

get "/hunt/:hunt_id" do
  filename = "hunts/treasure_hunt_#{params['hunt_id']}.txt"
  return { status: "error", message: "game not found" }.to_json unless File.exists?(filename)
  game = []
  File.readlines(filename).each_with_index do |line, index|
    game << EncryptedMessage.new.encrypt(line).merge({id: index})
  end

  game.to_json
end
get "/encrypt/:message" do
  message = params['message']
  EncryptedMessage.new.encrypt(message).to_json
end

get "/decrypt/:message/:key" do
  message = params['message']
  key     = params['key']
  EncryptedMessage.new.decrypt(message, key).to_json
end
