require_relative '../controllers/comment_controller'
require_relative '../utils/response_handler'

get '/comment' do
  status, message, data = CommentController.find_all
  status status
  generate_response(status, message, data)
end

get '/comment/:id' do
  status, message, data = CommentController.find_by_id(params['id'])
  status status
  generate_response(status, message, data)
end

get '/comment/hashtag/:hashtag' do
  status, message, data = CommentController.find_contain_hashtag(params['hashtag'])
  status status
  generate_response(status, message, data)
end

post '/comment/create' do
  status, message, data = CommentController.create(params)
  status status
  generate_response(status, message, data)
end