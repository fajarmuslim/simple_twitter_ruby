class Hashtag
  attr_reader :id, :text

  def initialize(params)
    @id= params[:id]
    @text= params[:text]
  end

  def valid_id?
    true
  end
end