require_relative '../controllers/post_controller'
require_relative '../utils/response_handler'

get '/post' do
  status, message, data = PostController.find_all
  status status
  generate_response(status, message, data)
end

get '/post/:id' do
  status, message, data = PostController.find_by_id(params['id'])
  status status
  generate_response(status, message, data)
end

get '/post/hashtag/:hashtag' do
  status, message, data = PostController.find_contain_hashtag(params['hashtag'])
  status status
  generate_response(status, message, data)
end

post '/post/create' do
  status, message, data = PostController.create(params)
  status status
  generate_response(status, message, data)
end