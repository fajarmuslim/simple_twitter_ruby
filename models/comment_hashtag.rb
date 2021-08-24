class Comment_Hashtag
  attr_reader :id, :comment_id, :hashtag_id

  def initialize(params)
    @id = params[:id]
    @comment_id = params[:comment_id]
    @hashtag_id = params[:hashtag_id]
  end

  def valid_save?
    return false if comment_id.nil? || hashtag_id.nil?
    return false if comment_id.negative? || hashtag_id.negative?

    true
  end

  def save
    return false unless valid_save?

    client = create_db_client
    client.query("INSERT INTO comments_hashtags(comment_id, hashtag_id) VALUES(#{comment_id}, #{hashtag_id})")
    client.last_id
  end

  def self.insert_hashtags_to_db(comment_id, string_hashtags)
    string_hashtags.each do |string_hashtag|
      hashtag_id = Hashtag.find_hashtag_id_from_string_hashtag(string_hashtag)
      params = {
        comment_id: comment_id,
        hashtag_id: hashtag_id
      }

      comment_hashtag = Comment_Hashtag.new(params)
      comment_hashtag.save
    end
  end

  def self.convert_sql_result_to_array(sql_result)
    comments_hashtags = []
    return comments_hashtags if sql_result.nil?

    sql_result.each do |row|
      comment_hashtag = Comment_Hashtag.new(
        id: row['id'],
        comment_id: row['comment_id'],
        hashtag_id: row['hashtag_id']
      )
      comments_hashtags << comment_hashtag
    end
    comments_hashtags
  end

  def self.find_comment_ids(hashtag_id)
    client = create_db_client
    sql_result = client.query("SELECT * FROM comments_hashtags WHERE hashtag_id = #{hashtag_id}")

    comments_hashtags = convert_sql_result_to_array(sql_result)
    comment_ids = []
    comments_hashtags.each do |comment_hashtag|
      comment_ids << comment_hashtag.comment_id
    end

    comment_ids
  end
end