class Comment
  attr_reader :id, :post_id, :user_id, :text, :attachment_path, :created_at, :updated_at

  def initialize(params)
    @id = params[:id]
    @post_id = params[:post_id]
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
    return false unless @id.is_a? Integer
    return false if @user_id.negative? || @user_id.zero?

    true
  end
end