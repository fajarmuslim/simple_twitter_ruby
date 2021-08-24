require_relative '../models/hashtag'
require_relative '../constant/status_code'

class HashtagController
  def self.create(params)
    begin
      raise 'text field required' if params['text'] == '' || params['text'].nil?

      hashtag = Hashtag.new(params)
      id = hashtag.save
      if id
        status = CREATED
        message = 'success created hashtag'
        data = hashtag.to_hash
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
    hashtags = Hashtag.find_all
    status = OK
    message = 'success'
    data = Hashtag.array_hashtags_to_hash(hashtags)
    [status, message, data]
  end

  def self.find_by_id(id)
    hashtag = Hashtag.find_by_id(id)
    if hashtag
      status = OK
      message = 'success'
      data = hashtag.to_hash
    else
      status = NOT_FOUND
      message = 'cannot find your hashtag id'
    end
    [status, message, data]
  end

  def self.find_trending_hashtag
    data = Hashtag.find_trending_hashtag
    status = OK
    message = 'success'
    [status, message, data]
  end
end