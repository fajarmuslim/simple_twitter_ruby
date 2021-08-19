require_relative '../models/user'

class UserController
  def self.create(params)
    user = User.new(params)
    user.save
  end
end