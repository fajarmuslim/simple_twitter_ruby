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
end