require_relative '../controllers/hashtag_controller'
require_relative '../utils/response_handler'

get '/hashtag' do
  status, message, data = HashtagController.find_all
  status status
  generate_response(status, message, data)
end

get '/hashtag/trending' do
  status, message, data = HashtagController.find_trending_hashtag
  status status
  generate_response(status, message, data)
end

get '/hashtag/:id' do
  status, message, data = HashtagController.find_by_id(params['id'])
  status status
  generate_response(status, message, data)
end

post '/hashtag/create' do
  status, message, data = HashtagController.create(params)
  status status
  generate_response(status, message, data)
end