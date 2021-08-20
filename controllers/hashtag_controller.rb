require_relative '../models/hashtag'

class HashtagController
  def self.create(params)
    hashtag = Hashtag.new(params)
    hashtag.save
  end

  def self.find_all
    Hashtag.find_all
  end
end