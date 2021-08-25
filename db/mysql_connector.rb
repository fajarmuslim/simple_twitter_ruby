require 'mysql2'

def create_db_client
  Mysql2::Client.new(
    host: ENV['HOST'],
    username: ENV['USERNAME'],
    password: ENV['PASSWORD'],
    database: ENV['DB_NAME']
  )
end