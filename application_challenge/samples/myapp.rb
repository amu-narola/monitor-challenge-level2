require 'sinatra'

get '/fetch_response' do
  file = File.open("api_response.json")
  data = JSON.load file
  data.to_json
end
