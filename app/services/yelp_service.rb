class YelpService
  def initialize(lat, long, cuisine)
    @lat = lat
    @long = long
    @cuisine = cuisine
  end

  def buinsess_from_term
    get_json('business/search')
  end

  private

  attr_reader :lat,
              :long

  def get_json(url)
    response = conn.get(url) do |req|
      req.params['latitude'] = lat
      req.params['longitude'] = long
      req.params['term'] = cuisine
    end
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new('https://api.yelp.com/v3') do |f|
      f.adapter Faraday.default_adapter
      f.headers['Authorization'] = ENV['yelp_api_key']
    end
  end
end
