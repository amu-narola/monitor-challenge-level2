require_relative 'connection.rb'
class PageView < ActiveRecord::Base

  # Associations
  belongs_to :visit
  validates :visit_id, :title, :url, :position, :time_spent, :timestamp, presence: true

  # Validations
  validates_uniqueness_of :timestamp, scope: :visit_id, case_sensitive: true
end

Connection.new.call