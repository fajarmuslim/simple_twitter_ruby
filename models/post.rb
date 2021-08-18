class Post
  attr_reader :id, :user_id, :text, :attachment_path, :created_at, :updated_at

  def initialize(params)
    @id = params[:id]
    @user_id = params[:user_id]
    @text = params[:text]
    @attachment_path = params[:attachment_path]
    @created_at = params[:created_at]
    @updated_at = params[:updated_at]
  end

  def valid_id?
    return false unless @id.is_a? Integer
    return false if @id.negative? || @id.zero?

    true
  end

  def valid_user_id?
    return false unless @user_id.is_a? Integer
    return false if @user_id.negative? || @user_id.zero?

    true
  end

  def valid_text?
    return false unless @text.is_a? String
    return false if @text == ''
    return false if @text.length > 1000

    true
  end
end