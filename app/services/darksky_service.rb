class DarkskyService
  def initialize(lat, long)
    @lat = lat
    @long = long
  end

  def darksky_data
    get_json("forecast/#{ENV['darksky_api_key']}/#{lat},#{long}")
  end

  def current_weather
    darksky_data[:currently]
  end

  def daily_weather
    darksky_data[:daily]
  end

  def hourly_weather
    darksky_data[:hourly]
  end

  private

  attr_reader :lat,
              :long

  def get_json(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new('https://api.darksky.net') do |f|
      f.adapter Faraday.default_adapter
    end
  end
end
