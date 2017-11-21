require 'sinatra'
require_relative 'encrypted_message'

get "/encrypt/:message" do
  message = params['message']
  EncryptedMessage.new.encrypt(message).to_json
end

get "/decrypt/:message/:key" do
  message = params['message']
  key     = params['key']
  EncryptedMessage.new.decrypt(message, key).to_json
end
