class YelpService
  def initialize(lat, long, cuisine, time)
    @lat = lat
    @long = long
    @cuisine = cuisine
    @time = time
  end

  def business_from_term
    get_json('businesses/search')
  end

  private

  attr_reader :lat,
              :long,
              :cuisine,
              :time

  def get_json(url)
    response = conn.get(url) do |req|
      req.params['latitude'] = lat
      req.params['longitude'] = long
      req.params['term'] = cuisine
      req.params['open_at'] = time
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
