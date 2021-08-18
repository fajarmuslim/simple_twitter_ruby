require_relative '../db/mysql_connector'

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
    return false unless @user_id.is_a? Integer
    return false if @user_id.negative? || @user_id.zero?

    true
  end

  def valid_post_id?
    return false unless @post_id.is_a? Integer
    return false if @post_id.negative? || @post_id.zero?

    true
  end

  def valid_text?
    return false unless @text.is_a? String
    return false if @text == ''
    return false if @text.length > 1000

    true
  end

  def valid_save?
    valid_user_id? and valid_post_id? and valid_text?
  end

  def self.convert_sql_result_to_array(sql_result)
    comments = []
    return comments if sql_result.nil?

    sql_result.each do |row|
      comment = Comment.new(
        id: row['id'],
        user_id: row['user_id'],
        post_id: row['post_id'],
        text: row['text'],
        attachment_path: row['attachment_path'],
        created_at: row['created_at'],
        updated_at: row['updated_at']
      )
      comments << comment
    end
    comments
  end

  def save
    return false unless valid_save?

    client = create_db_client
    client.query("INSERT INTO comments(user_id, post_id, text, attachment_path) VALUES (#{@user_id}, #{@post_id}, '#{@text}', '#{@attachment_path}')")
    client.last_id
  end

  def self.find_all
    client = create_db_client
    sql_result = client.query('SELECT * FROM comments')
    convert_sql_result_to_array(sql_result)
  end
end