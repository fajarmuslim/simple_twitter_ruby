require_relative '../models/user'

class UserController
  def self.create(params)
    user = User.new(params)
    user.save
  end

  def self.find_all
    User.find_all
  end
end