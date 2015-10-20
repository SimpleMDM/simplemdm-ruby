module SimpleMDM

  @API_KEY = nil
  @BASE_URL = 'd.unwiredmdm.com:3000/api/v1/'.freeze

  def self.api_key=(value)
    @API_KEY = value
  end

  def self.api_key
    @API_KEY
  end

  def self.api_url
    "https://#{@API_KEY}:@#{@BASE_URL}"
  end

end