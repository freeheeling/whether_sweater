class DailyForecast
  def initialize(daily_weather_data)
    @daily_data = daily_weather_data
  end

  def next_five_days
    daily_data.map do |day|
      {
        day_of_week: full_day_name(day),
        weather_icon: icon(day),
        precip_type: precip_type(day),
        precip_probability_percent: precip_prob(day),
        high_temp_F: high_temp(day),
        low_temp_F: low_temp(day)
      }
    end[1..5]
  end

  private

  attr_reader :daily_data

  def full_day_name(day)
    Time.at(day[:time]).strftime('%A')
  end

  def icon(day)
    day[:icon]
  end

  def precip_type(day)
    day[:precipType]
  end

  def precip_prob(day)
    (day[:precipProbability] * 100).to_i
  end

  def high_temp(day)
    (day[:temperatureMax]).round
  end

  def low_temp(day)
    (day[:temperatureMin]).round
  end
end
