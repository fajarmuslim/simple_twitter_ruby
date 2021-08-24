require 'sinatra'

require_relative 'routes/user_route'
require_relative 'routes/post_route'
require_relative 'routes/comment_route'
require_relative 'routes/hashtag_route'

before do
  content_type :json
end

get '/' do
  { message: 'hello world!' }.to_json
end

# require_relative 'models/post'
# require_relative 'models/comment'
#
# $client = create_db_client
#
# $client.query('SET FOREIGN_KEY_CHECKS = 0')
# $client.query('TRUNCATE table users')
# $client.query('TRUNCATE table posts')
# $client.query('TRUNCATE table comments')
# $client.query('TRUNCATE table posts_hashtags')
# $client.query('TRUNCATE table comments_hashtags')
# $client.query('TRUNCATE table hashtags')
# $client.query("INSERT INTO users(username, email, bio) VALUES('aa', 'email@email.com', 'bio')")
# # $client.query("INSERT INTO posts(user_id, text) VALUES(1, 'aaa #siang #baju')")
#
# params ={
#   user_id: 1,
#   text: 'adsfasdf #siang baru #alha'
# }
# post = Post.new(params)
# post.save
#
# temp = Post.find_posts_contain_hashtag('alha')
#
# temp.each do |t|
#   puts t.id
#   puts t.text
# end
#
# params ={
#   user_id: 1,
#   post_id: 1,
#   text: 'adsfasdf #baju baru #alha'
# }
# comment = Comment.new(params)
# comment.save
#
# temp = Comment.find_comments_contain_hashtag('alha')
#
# temp.each do |t|
#   puts "ini bos"
#   puts t.id
#   puts t.text
# end
#
# Hashtag.find_trending_hashtag
#
# # params ={
# #   user_id: 1,
# #   post_id: 1,
# #   text: 'adsfasdf #baju baru #alha'
# # }
# # comment = Comment.new(params)
# # comment.save
#
# # $client.query('TRUNCATE table posts')
# # $client.query('TRUNCATE table users')
# # $client.query('SET FOREIGN_KEY_CHECKS = 1')