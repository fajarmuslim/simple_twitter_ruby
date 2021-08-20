require_relative '../models/post'

class PostController
  def self.create(params)
    post = Post.new(params)
    post.save
  end

  def self.find_all
    Post.find_all
  end

  def self.find_by_id(id)
    Post.find_by_id(id)
  end
end