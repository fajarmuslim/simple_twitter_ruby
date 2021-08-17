class User
  attr_accessor :id, :username, :email, :bio, :posts, :comments

  def initialize(params)
    @id = params[:id]
    @username = params[:username]
    @email = params[:email]
    @bio = params[:bio]
    @posts = []
    @comments = []
  end

  def valid_id?
    return false unless @id.is_a? Integer
    return false if @id.negative? || @id.zero?

    true
  end

  def valid_username?
    true
  end
end
