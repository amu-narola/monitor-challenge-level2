class PageView < ActiveRecord::Base
  belongs_to :visit
  validates :visit_id, :title, :url, :time_spent, :timestamp, presence: true
end


ActiveRecord::Base.establish_connection(
  adapter: 'mysql2',
  host: '127.0.0.1',
  username: 'root',
  password: 'mynewpassword',
  database: 'poro_dev'
)
