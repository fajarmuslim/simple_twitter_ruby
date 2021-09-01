require_relative '../models/post'
require_relative '../utils/attachment_handler'

class PostController
  def self.create(params)
    begin
      raise 'user_id field required' if params['user_id'] == '' || params['user_id'].nil?
      raise 'text field required' if params['text'] == '' || params['text'].nil?
      raise 'text cannot exceed 1000 char' if params['text'].length > 1000

      params['user_id'] = params['user_id'].to_i
      attachment_path = save_attachment_file(params['attachment']) unless params['attachment'].nil?

      params['attachment_path'] = attachment_path

      post = Post.new(params)
      id = post.save
      if id
        status = CREATED
        message = 'success created post'
        post = Post.find_by_id(id)
        data = post.to_hash
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
    posts = Post.find_all
    status = OK
    message = 'success'
    data = Post.array_posts_to_hash(posts)

    [status, message, data]
  end

  def self.find_by_id(id)
    post = Post.find_by_id(id)
    if post
      status = OK
      message = 'success'
      data = post.to_hash
    else
      status = NOT_FOUND
      message = 'cannot find your post id'
    end

    [status, message, data]
  end
  
  def self.find_contain_hashtag(string_hashtag)
    posts = Post.find_posts_contain_hashtag(string_hashtag)
    status = OK
    message = 'success'
    data = Post.array_posts_to_hash(posts)

    [status, message, data]
  end
end