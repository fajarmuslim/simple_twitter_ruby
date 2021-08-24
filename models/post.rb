require_relative '../db/mysql_connector'
require_relative '../models/hashtag'

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

  def valid_save?
    valid_user_id? and valid_text?
  end

  def self.convert_sql_result_to_array(sql_result)
    posts = []
    return posts if sql_result.nil?

    sql_result.each do |row|
      post = Post.new(
        id: row['id'],
        user_id: row['user_id'],
        text: row['text'],
        attachment_path: row['attachment_path'],
        created_at: row['created_at'],
        updated_at: row['updated_at']
      )
      posts << post
    end
    posts
  end

  def save
    return false unless valid_save?

    client = create_db_client
    client.query("INSERT INTO posts(user_id, text, attachment_path) VALUES (#{@user_id}, '#{@text}', '#{@attachment_path}')")
    post_id = client.last_id

    string_hashtags = Hashtag.find_hashtags_in_string(@text)

    Post_Hashtag.insert_hashtags_to_db(post_id, string_hashtags)

    post_id
  end

  def self.find_all
    client = create_db_client
    sql_result = client.query('SELECT * FROM posts')
    convert_sql_result_to_array(sql_result)
  end

  def self.find_by_id(id)
    client = create_db_client
    sql_result = client.query("SELECT * FROM posts WHERE id = #{id}")
    convert_sql_result_to_array(sql_result)[0]
  end

  def self.find_posts_contain_hashtag(string_hashtag)
    result = Hashtag.find_by_text(string_hashtag)
    hashtag_id = result.id unless result.nil?

    post_ids = Post_Hashtag.find_post_ids(hashtag_id)
    find_post_from_post_ids(post_ids)
  end

  def self.find_post_from_post_ids(post_ids)
    posts = []
    post_ids.each do |post_id|
      puts "post_id: #{post_id}"
      posts << Post.find_by_id(post_id)
    end
    posts
  end

  def to_hash
    {
      user_id: @user_id,
      text: @text,
      attachment_path: @attachment_path,
      created_at: @created_at,
      updated_at: @updated_at
    }
  end

  def self.array_posts_to_hash(posts)
    result = []
    posts.each do |post|
      result << post.to_hash
    end
    { 'post': result }
  end
end