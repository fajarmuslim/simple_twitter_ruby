require_relative '../models/comment'

class CommentController
  def self.create(params)
    begin
      raise 'user_id field required' if params['user_id'] == '' || params['user_id'].nil?
      raise 'post_id field required' if params['post_id'] == '' || params['post_id'].nil?
      raise 'text field required' if params['text'] == '' || params['text'].nil?
      raise 'text cannot exceed 1000 char' if params['text'].length > 1000

      params['user_id'] = params['user_id'].to_i
      params['post_id'] = params['post_id'].to_i

      attachment_path = save_attachment_file(params['attachment']) unless params['attachment'].nil?
      params['attachment_path'] = attachment_path

      comment = Comment.new(params)
      id = comment.save
      if id
        status = CREATED
        message = 'success created comment'
        comment = Comment.find_by_id(id)
        data = comment.to_hash
      else
        raise 'bad_request'
      end
    rescue StandardError => e
      status = BAD_REQUEST
      message = e.message
    end

    [status, message, data]
  end

  def self.find_all
    users = Comment.find_all
    status = OK
    message = 'success'
    data = Comment.array_comments_to_hash(users)

    [status, message, data]
  end

  def self.find_by_id(id)
    comment = Comment.find_by_id(id)
    if comment
      status = OK
      message = 'success'
      data = comment.to_hash
    else
      status = NOT_FOUND
      message = 'cannot find your comment id'
    end

    [status, message, data]
  end

  def self.find_contain_hashtag(string_hashtag)
    posts = Comment.find_comments_contain_hashtag(string_hashtag)
    status = OK
    message = 'success'
    data = Comment.array_comments_to_hash(posts)

    [status, message, data]
  end
end