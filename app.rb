require 'sinatra'

get "/" do
  { status: "success" }.to_json
end
