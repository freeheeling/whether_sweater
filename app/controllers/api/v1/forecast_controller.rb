class Api::V1::ForecastController < ApplicationController
  def index
    location = params[:location]

    conn = Faraday.new('https://maps.googleapis.com/maps/api') do |f|
      f.adapter Faraday.default_adapter
      f.params['key'] = ENV['geocode_api_key']
    end

    response = conn.get('geocode/json') do |req|
      req.params['address'] = location
    end

    location_data = JSON.parse(response.body, symbolize_names: true)

    lat = location_data[:results][0][:geometry][:location][:lat]
    lng = location_data[:results][0][:geometry][:location][:lng]

    # box 1
    city = location_data[:results][0][:address_components][0][:long_name]
    state = location_data[:results][0][:address_components][2][:short_name]
    country = location_data[:results][0][:address_components][3][:long_name]

    d_conn = Faraday.new('https://api.darksky.net') do |f|
      f.adapter Faraday.default_adapter
    end

    d_response = d_conn.get("forecast/#{ENV['darksky_api_key']}/#{lat},#{lng}")

    forecast_data = JSON.parse(d_response.body, symbolize_names: true)

    # box 1
    current_datetime = Time.at(forecast_data[:currently][:time]).strftime('%-I:%M %p, %-m/%-d')
    current_summary = forecast_data[:currently][:summary]
    current_icon = forecast_data[:currently][:icon]
    current_temp = forecast_data[:currently][:temperature].round

    high_temp = forecast_data[:daily][:data][0][:temperatureHigh].round
    low_temp = forecast_data[:daily][:data][0][:temperatureLow].round

    # box 2
    feels_like = forecast_data[:currently][:apparentTemperature].round
    humidity = (forecast_data[:currently][:humidity] * 100).to_i
    visibility = forecast_data[:currently][:visibility]
    uv_index = forecast_data[:currently][:uvIndex]
    today_summary = forecast_data[:daily][:data][0][:summary]
    tonight_summary = forecast_data[:daily][:data][1][:summary]

    # box 3 – hourly & daily
    # first 8 hours
    hour_data = forecast_data[:hourly][:data].map { |hour| hour }.take(8)

    # array of unix hours
    unix_hours = hour_data.pluck(:time)
    # convert unix hour array to hours
    hours = unix_hours.map do |hour|
      Time.at(hour).strftime('%-I %p')
    end

    hour_icons = hour_data.pluck(:icon)

    # array of temps
    hour_temps = hour_data.pluck(:temperature)
    # rounds array of temps
    temps = hour_temps.map do |temp|
      temp.round
    end

    # next 5 days
    day_data = forecast_data[:daily][:data].map { |day| day }[1..5]

    # array of unix days
    unix_days = day_data.pluck(:time)
    # convert unix days array to days
    days = unix_days.map do |day|
      Time.at(day).strftime('%A')
    end

    day_icons = day_data.pluck(:icon)
    day_precip_types = day_data.pluck(:precipType)

    # arry of precip probabilities
    day_precip_probs = day_data.pluck(:precipProbability)
    # coverts day_precip_probs to percent
    precip_probs = day_precip_probs.map do |prob|
      (prob * 100).to_i
    end

    day_high_temps = day_data.pluck(:temperatureMax).map(&:round)
    day_low_temps = day_data.pluck(:temperatureMin).map(&:round)
  end
end
