require_relative '../models/hashtag'

class HashtagController
  def self.create(params)
    hashtag = Hashtag.new(params)
    hashtag.save
  end
end