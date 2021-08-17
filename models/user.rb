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
    return false unless @username.is_a? String
    return false if @username == ''
    return false if @username.length > 255

    true
  end

  def valid_email?
    return false unless @email.is_a? String
    return false if @email == ''
    return false if @email.length > 255
    return false unless valid_email_pattern?

    true
  end

  def valid_email_pattern?
    @email =~ /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  end

  def valid_bio?
    return false unless @bio.is_a? String
    return false if @bio.length > 1000

    true
  end

  def valid_save?
    valid_username? and valid_email? and valid_bio?
  end
end
