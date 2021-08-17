require 'mysql2'

def create_db_client
  Mysql2::Client.new(
    host: ENV['HOST'] || 'localhost',
    username: ENV['USERNAME'] || 'fajar',
    password: ENV['PASSWORD'] || 'GenerasiGIGIH100%',
    database: ENV['DB_NAME'] || 'simple_twitter_ruby'
  )
end