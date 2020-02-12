require 'spec_helper'
require_relative '../test_app/models/visit'

RSpec.describe Visit, type: :model do
  it 'validates presence' do
      record = Visit.new
      record.valid? # run validations
      expect(record.errors.messages).to include({ :evid => ["can't be blank"],
                                                  :vendor_site_id => ["can't be blank"],
                                                  :vendor_visit_id => ["can't be blank"], 
                                                  :vendor_visitor_id => ["can't be blank"],
                                                  :visit_ip => ["can't be blank"] }) # check for presence of error
    end

    it "should have many page views" do
      v = Visit.reflect_on_association(:page_views)
      expect(v.macro).to eq(:has_many)
  end
end
