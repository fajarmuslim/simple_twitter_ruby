require_relative 'hashtag'

class Post_Hashtag
  attr_reader :id, :post_id, :hashtag_id

  def initialize(params)
    @id = params['id']
    @post_id = params['post_id']
    @hashtag_id = params['hashtag_id']
  end

  def valid_save?
    return false if post_id.nil? || hashtag_id.nil?
    return false if post_id.negative? || hashtag_id.negative?

    true
  end

  def save
    return false unless valid_save?

    client = create_db_client
    client.query("INSERT INTO posts_hashtags(post_id, hashtag_id) VALUES(#{post_id}, #{hashtag_id})")
    client.last_id
  end

  def self.insert_hashtags_to_db(post_id, string_hashtags)
    string_hashtags.each do |string_hashtag|
      hashtag_id = Hashtag.find_hashtag_id_from_string_hashtag(string_hashtag)


      params = {
        'post_id' => post_id,
        'hashtag_id' => hashtag_id
      }

      post_hashtag = Post_Hashtag.new(params)
      post_hashtag.save
    end
  end

  def self.convert_sql_result_to_array(sql_result)
    posts_hashtags = []
    return posts_hashtags if sql_result.nil?

    sql_result.each do |row|
      post_hashtag = Post_Hashtag.new(
        'id' => row['id'],
        'post_id' => row['post_id'],
        'hashtag_id' => row['hashtag_id']
      )
      posts_hashtags << post_hashtag
    end
    posts_hashtags
  end

  def self.find_post_ids(hashtag_id)
    client = create_db_client
    sql_result = client.query("SELECT * FROM posts_hashtags WHERE hashtag_id = #{hashtag_id}")

    posts_hashtags = convert_sql_result_to_array(sql_result)
    post_ids = []
    posts_hashtags.each do |post_hashtag|
      post_ids << post_hashtag.post_id
    end

    post_ids
  end
end