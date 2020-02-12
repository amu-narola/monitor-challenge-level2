require 'spec_helper'
require_relative '../test_app/services/business_service'

describe BusinessService do

  context "BusinessService # execute logic" do
    it "Create records" do
      visit_count = Visit.count
      page_view_count = PageView.count 
      BusinessService.new.logic
      expect(Visit.count).to  eq(visit_count + 1)
      expect(PageView.count).to  eq(page_view_count + 9)
    end
  end
end
