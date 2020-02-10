require 'pry'
require 'httpclient'

class HttpService

  def fetch_sample_response
    client = HTTPClient.new
    JSON.parse(client.get_content 'http://localhost:4567/fetch_response')
  end
end
