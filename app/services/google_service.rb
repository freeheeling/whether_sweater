class GoogleService
  def initialize(location, destination)
    @location = location
    @destination = destination
  end

  def geocode_data
    @geocode_data ||= get_json_address('geocode/json')
  end

  def directions_data
    @directions_data ||= get_json_directions('directions/json')
  end

  private

  attr_reader :location,
              :destination

  def get_json_directions(url)
    response = conn.get(url) do |req|
      req.params['origin'] = location
      req.params['destination'] = destination
    end

    JSON.parse(response.body, symbolize_names: true)[:routes].first[:legs]
  end


  def get_json_address(url)
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
