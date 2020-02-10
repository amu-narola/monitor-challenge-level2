class Visit < ActiveRecord::Base

has_many :page_views

validates :vendor_site_id, :vendor_visit_id, :visit_ip, :vendor_visitor_id, presence: true
validates :evid, presence: true, format: { with: /\A[A-z0-9]{8}-[A-z0-9]{4}-[A-z0-9]{4}-[A-z0-9]{4}-[A-z0-9]{12}\z/, allow_blank: true }
end


ActiveRecord::Base.establish_connection(
  adapter: 'mysql2',
  host: '127.0.0.1',
  username: 'root',
  password: 'mynewpassword',
  database: 'poro_dev'
)