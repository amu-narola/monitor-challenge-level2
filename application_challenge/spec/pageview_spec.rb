require 'spec_helper'
require_relative '../test_app/models/pageview'

RSpec.describe PageView, type: :model do
  it 'validates presence' do
    record = PageView.new
    record.valid? # run validations
    expect(record.errors.messages).to include({ :position => ["can't be blank"],
                                                :time_spent => ["can't be blank"],
                                                :timestamp => ["can't be blank"],
                                                :title => ["can't be blank"],
                                                :url => ["can't be blank"],
                                                :visit_id => ["can't be blank"] }) # check for presence of error
  end

  it "should have many page views" do
     expect(PageView.reflect_on_association(:visit).macro).to eq :belongs_to
  end
end
