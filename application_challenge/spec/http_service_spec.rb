require 'spec_helper'
require_relative '../test_app/services/http_service'

describe HttpService do

  before :each do
    @sample_response = HttpService.new.fetch_sample_response
  end

  context "HttpService # fetch_sample_response" do
    it "Fetch Sample Response" do
      expect(@sample_response).to be_present 
    end
  end
end
