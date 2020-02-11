class Connection

  def call
    ActiveRecord::Base.establish_connection(
      adapter: 'mysql2',
      host: '127.0.0.1',
      username: 'root',
      password: 'mynewpassword',
      database: 'poro_dev'
    )
  end
end
