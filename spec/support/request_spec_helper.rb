module RequestSpecHelper
  # Parse JSON response to ruby hash
  def parsed_body
    JSON.parse(response.body)
  end
end