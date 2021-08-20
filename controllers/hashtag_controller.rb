require_relative '../models/hashtag'

class HashtagController
  def self.create(params)
    hashtag = Hashtag.new(params)
    hashtag.save
  end

  def self.find_all
    Hashtag.find_all
  end

  def self.find_by_id(id)
    Hashtag.find_by_id(id)
  end
end