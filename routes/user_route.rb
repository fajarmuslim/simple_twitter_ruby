require_relative '../controllers/user_controller'
require_relative '../utils/response_handler'

get '/user' do
  status, message, data = UserController.find_all
  status status
  generate_response(status, message, data)
end

get '/user/:id' do
  status, message, data = UserController.find_by_id(params['id'])
  status status
  generate_response(status, message, data)
end

post '/user/create' do
  status, message, data = UserController.create(params)
  status status
  generate_response(status, message, data)
end