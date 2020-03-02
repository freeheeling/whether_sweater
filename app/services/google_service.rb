class GoogleService
  def initialize(location)
    @location = location
  end

  def geocode_data
    @geocode_data ||= get_json('geocode/json')
  end

  private

  attr_reader :location

  def get_json(url)
    response = conn.get(url) do |req|
      req.params['address'] = location
    end

    JSON.parse(response.body, symbolize_names: true)[:results].first
  end

  def conn
    Faraday.new('https://maps.googleapis.com/maps/api') do |f|
      f.adapter Faraday.default_adapter
      f.params['key'] = ENV['google_api_key']
    end
  end
end
