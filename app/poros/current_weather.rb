class CurrentWeather
  attr_reader :time_and_date,
              :weather_conditions,
              :wether_icon,
              :temp_F,
              :feels_like_F,
              :humidity_percent,
              :visibility_miles,
              :uv_index_number,
              :today_summary,
              :tonight_summary

  def initialize(current_weather_data)
    @time_and_date = current_datetime(current_weather_data[:currently][:time])
    @weather_conditions = current_weather_data[:currently][:summary]
    @weather_icon = current_weather_data[:currently][:icon]
    @temp_F = current_weather_data[:currently][:temperature].round
    @feels_like_F = current_weather_data[:currently][:apparentTemperature].round
    @humidity_percent = (current_weather_data[:currently][:humidity] * 100).to_i
    @visibility_miles = current_weather_data[:currently][:visibility]
    @uv_index_number = current_weather_data[:currently][:uvIndex]
    @today_summary = current_weather_data[:daily][:summary]
    @tonight_summary = current_weather_data[:hourly][:data].find do |hour|
                         hour[:icon].include?('night')
                       end[:summary]
  end

  def current_datetime(current_weather_data)
    Time.at(current_weather_data).strftime('%-I:%M %p, %-m/%-d')
  end
end
