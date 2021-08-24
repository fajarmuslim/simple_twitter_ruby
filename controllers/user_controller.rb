require_relative '../models/user'
require_relative '../constant/status_code'

class UserController
  def self.create(params)
    begin
      raise 'username field required' if params['username'] == '' || params['username'].nil?
      raise 'email field required' if params['email'] == '' || params['email'].nil?

      user = User.new(params)
      id = user.save
      if id
        status = CREATED
        message = 'success created user'
        data = user.to_hash
      else
        raise 'bad_request'
      end
    rescue StandardError => e
      status = BAD_REQUEST
      message = e.message
    end
    [status, message, data]
  end

  def self.find_all
    users = User.find_all
    status = OK
    message = 'success'
    data = User.array_users_to_hash(users)
    [status, message, data]
  end

  def self.find_by_id(id)
    user = User.find_by_id(id)
    if user
      status = OK
      message = 'success'
      data = user.to_hash
    else
      status = NOT_FOUND
      message = 'cannot find your user id'
    end
    [status, message, data]
  end
end