require 'sinatra'

require_relative 'routes/user_route'
require_relative 'routes/post_route'
require_relative 'routes/comment_route'
require_relative 'routes/hashtag_route'

before do
  content_type :json
end