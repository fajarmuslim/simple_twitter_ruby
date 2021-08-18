class Hashtag
  attr_accessor :id, :text

  def initialize(params)
    @id= params[:id]
    @text= params[:text]
  end
end