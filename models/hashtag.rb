require_relative '../db/mysql_connector'
require_relative '../models/post_hashtag'
require_relative '../models/comment_hashtag'

class Hashtag
  attr_reader :id, :text

  def initialize(params)
    @id = params['id']
    @text = params['text']
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
        'id'=> row['id'],
        'text'=> row['text']
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

  def self.find_by_id(id)
    client = create_db_client
    sql_result = client.query("SELECT * FROM hashtags WHERE id = #{id}")
    convert_sql_result_to_array(sql_result)[0]
  end

  def self.find_by_text(text)
    client = create_db_client
    sql_result = client.query("SELECT * FROM hashtags WHERE text = '#{text}'")
    convert_sql_result_to_array(sql_result)[0]
  end

  def self.find_hashtag_id_from_string_hashtag(string_hashtag)
    result = Hashtag.find_by_text(string_hashtag)

    return Hashtag.create_new_hashtag(string_hashtag) if result.nil?

    result.id
  end

  def self.create_new_hashtag(string_hashtag)
    params = {
      'text'=> string_hashtag
    }

    new_hashtag = Hashtag.new(params)
    new_hashtag.save
  end

  def self.find_hashtags_in_string(text)
    text.to_s.scan(/#(\w+)/).flatten
  end

  def self.fetch_trending_data
    client = create_db_client
    client.query('SELECT hashtag_id, count(hashtag_id) as counter
                              FROM (SELECT hashtag_id, updated_at FROM posts_hashtags
                                    UNION ALL
                                    SELECT hashtag_id, updated_at FROM comments_hashtags
                                    WHERE updated_at >= NOW() - INTERVAL 1 DAY
                                    ) as temp_table
                              GROUP BY temp_table.hashtag_id
                              ORDER BY counter DESC
                              LIMIT 5')

  end

  def self.find_trending_hashtag
    sql_result = fetch_trending_data
    hashtags = []
    sql_result.each do |row|
      hashtag = Hashtag.find_by_id(row['hashtag_id'])
      temp = { 'hashtag': hashtag.to_hash,
               'occurrence': row['counter']
      }
      hashtags << temp
    end
    { 'hashtags': hashtags }
  end

  def to_hash
    {
      text: @text
    }
  end

  def self.array_hashtags_to_hash(hashtags)
    result = []
    hashtags.each do |hashtag|
      result << hashtag.to_hash
    end
    { 'hashtag': result }
  end
end