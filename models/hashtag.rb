class Hashtag
  attr_reader :id, :text

  def initialize(params)
    @id= params[:id]
    @text= params[:text]
  end

  def valid_id?
    return false unless @id.is_a? Integer
    return false if @id.negative? || @id.zero?

    true
  end
end