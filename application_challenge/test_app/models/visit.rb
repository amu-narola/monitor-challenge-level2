require 'active_record'
require_relative './connection.rb'

class Visit < ActiveRecord::Base

  # Associations
  has_many :page_views

  # Validations
  validates :vendor_site_id, :vendor_visit_id, :visit_ip, :vendor_visitor_id, presence: true
  validates :evid, presence: true, format: { with: /\A[A-z0-9]{8}-[A-z0-9]{4}-[A-z0-9]{4}-[A-z0-9]{4}-[A-z0-9]{12}\z/, allow_blank: true }
end

Connection.new.call
