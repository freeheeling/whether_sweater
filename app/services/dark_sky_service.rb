class DarkSkyService
  def initialize(lat, long, future_time)
    @lat = lat
    @long = long
    @future_time = future_time
  end

  def darksky_data
    get_json("forecast/#{ENV['darksky_api_key']}/#{lat},#{long}")
  end

  def future_darksky_data
    get_json("forecast/#{ENV['darksky_api_key']}/#{lat},#{long},#{future_time}")
  end

  def current_weather
    darksky_data[:currently]
  end

  def daily_forecast
    darksky_data[:daily]
  end

  def hourly_forecast
    darksky_data[:hourly]
  end

  private

  attr_reader :lat,
              :long,
              :future_time

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
