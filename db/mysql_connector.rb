require 'mysql2'

def create_db_client
  Mysql2::Client.new(
    host: ENV['HOST'] || 'localhost',
    username: ENV['USERNAME'] || 'gbe01058',
    password: ENV['PASSWORD'] || 'gbe01058',
    database: ENV['DB_NAME'] || 'simple_twitter_ruby'
  )
end