module SimpleMDM

  @BASE_URL = 'a.simplemdm.com/api/v1/'

  def self.api_key=(value)
    @API_KEY = value
  end

  def self.api_key
    @API_KEY
  end

  def self.base_url=(value)
    @BASE_URL = value
  end

  def self.base_url
    @BASE_URL
  end

  def self.api_url
    "https://#{@API_KEY}:@#{@BASE_URL}"
  end

end