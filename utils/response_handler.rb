def generate_response(status, message=nil, data = nil)
  response = {
    status: status
  }

  response[:message] = message unless message.nil?
  response[:data] = data unless data.nil?

  response.to_json
end