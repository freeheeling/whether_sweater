class CurrentWeather
  attr_reader :time_and_date,
              :unix_time,
              :weather_conditions,
              :wether_icon,
              :temp_F,
              :feels_like_F,
              :humidity_percent,
              :visibility_miles,
              :uv_index_number,
              :uv_exposure_level,
              :today_summary,
              :tonight_summary

  def initialize(current_weather_data)
    @time_and_date = get_time_and_date(current_weather_data)
    @unix_timestamp = get_unix_timestamp(current_weather_data)
    @weather_conditions = get_weather_conditions(current_weather_data)
    @weather_icon = get_weather_icon(current_weather_data)
    @temp_F = get_temp_F(current_weather_data)
    @feels_like_F = get_feels_like_F(current_weather_data)
    @humidity_percent = get_humidity_percent(current_weather_data)
    @visibility_miles = get_visibility_miles(current_weather_data)
    @uv_index_number = get_uv_index_number(current_weather_data)
    @uv_exposure_level = get_uv_exposure_level(current_weather_data)
    @today_summary = get_today_summary(current_weather_data)
    @tonight_summary = get_tonight_summary(current_weather_data)
  end

  private

  def get_time_and_date(current_weather_data)
    current_datetime(current_weather_data[:currently][:time])
  end

  def current_datetime(current_weather_data)
    Time.at(current_weather_data).strftime('%-I:%M %p, %-m/%-d')
  end

  def get_unix_timestamp(current_weather_data)
    current_weather_data[:currently][:time]
  end

  def get_weather_conditions(current_weather_data)
    current_weather_data[:currently][:summary]
  end

  def get_weather_icon(current_weather_data)
    current_weather_data[:currently][:icon]
  end

  def get_temp_F(current_weather_data)
    current_weather_data[:currently][:temperature].round
  end

  def get_feels_like_F(current_weather_data)
    current_weather_data[:currently][:apparentTemperature].round
  end

  def get_humidity_percent(current_weather_data)
    (current_weather_data[:currently][:humidity] * 100).to_i
  end

  def get_visibility_miles(current_weather_data)
    current_weather_data[:currently][:visibility]
  end

  def get_uv_index_number(current_weather_data)
    current_weather_data[:currently][:uvIndex]
  end

  def get_uv_exposure_level(current_weather_data)
    return 'low' if uv_index_number < 3
    return 'moderate' if uv_index_number.between?(3, 5)
    return 'high' if uv_index_number.between?(6, 7)
    return 'very high' if uv_index_number.between?(8, 10)
    return 'extreme' if uv_index_number > 10
  end

  def get_today_summary(current_weather_data)
    current_weather_data[:daily][:data].first[:summary]
  end

  def get_tonight_summary(current_weather_data)
    current_weather_data[:hourly][:data].find do |hour|
      hour[:icon].include?('night')
    end[:summary]
  end
end
