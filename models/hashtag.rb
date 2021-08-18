require_relative '../db/mysql_connector'

class Hashtag
  attr_reader :id, :text

  def initialize(params)
    @id = params[:id]
    @text = params[:text]
  end

  def valid_id?
    return false unless @id.is_a? Integer
    return false if @id.negative? || @id.zero?

    true
  end

  def valid_text?
    return false unless @text.is_a? String
    return false if @text == ''
    return false if @text.length > 999

    true
  end

  def valid_save?
    valid_text?
  end

  def self.convert_sql_result_to_array(sql_result)
    hashtags = []
    return hashtags if sql_result.nil?

    sql_result.each do |row|
      hashtag = Hashtag.new(
        id: row['id'],
        text: row['text']
      )
      hashtags << hashtag
    end
    hashtags
  end

  def save
    return false unless valid_save?

    client = create_db_client
    client.query("INSERT INTO hashtags(text) VALUES ('#{@text}')")
    client.last_id
  end

  def self.find_all
    client = create_db_client
    sql_result = client.query('SELECT * FROM hashtags')
    convert_sql_result_to_array(sql_result)
  end
end