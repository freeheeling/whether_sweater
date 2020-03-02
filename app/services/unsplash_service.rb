class UnsplashService
  def initialize(location)
    @location = location
  end

  def image_for_query
    get_json('search/photos')
  end

  private

  attr_reader :location

  def get_json(url)
    response = conn.get(url) do |req|
      req.params['query'] = location.concat(' skyline')
      req.params['per_page'] = 1
    end

    JSON.parse(response.body, symbolize_names: true)[:results]
  end

  def conn
    Faraday.new('https://api.unsplash.com') do |f|
      f.adapter Faraday.default_adapter
      f.params['client_id'] = ENV['unsplash_api_key']
    end
  end
end
