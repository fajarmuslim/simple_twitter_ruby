require_relative '../models/post'

class PostController
  def self.create(params)
    post = Post.new(params)
    post.save
  end
end