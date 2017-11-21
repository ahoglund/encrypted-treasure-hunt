require 'sinatra'
require 'encrypted_message'

get "/encrypt/:message" do
  message = params['message']
  { message: EncryptedMessage.new.encrypt(message) }.to_json
end
