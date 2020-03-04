require 'rails_helper'

describe CurrentWeather do
  describe 'instance methods' do
    context '#uv_exposure_level' do
      it 'returns associated uv exposure level for uv index number' do
        forecast_data = {
          :currently => {
            :time => 1583356555,
            :summary => 'Clear',
            :icon => 'clear-day',
            :precipProbability => 0,
            :temperature => 66.16,
            :apparentTemperature => 66.16,
            :humidity => 0.48,
            :uvIndex => 5,
            :visibility => 10,
          },
          :hourly => {
            :data => [
              {
                  :summary => 'Partly Cloudy',
                  :icon => 'clear-night'
              },
            ]
          },
          :daily => {
            :data => [
                {
                  :summary => 'Clear throughout the day.',
                },
            ]
          }
        }

        current_weather = CurrentWeather.new(forecast_data)
        expect(forecast_data[:currently][:uvIndex]).to eq(5)
        expect(current_weather.uv_exposure_level).to eq('moderate')

        forecast_data[:currently][:uvIndex] = 1
        current_weather = CurrentWeather.new(forecast_data)
        expect(current_weather.uv_exposure_level).to eq('low')

        forecast_data[:currently][:uvIndex] = 11
        current_weather = CurrentWeather.new(forecast_data)
        expect(current_weather.uv_exposure_level).to eq('extreme')

        forecast_data[:currently][:uvIndex] = 7
        current_weather = CurrentWeather.new(forecast_data)
        expect(current_weather.uv_exposure_level).to eq('high')

        forecast_data[:currently][:uvIndex] = 9
        current_weather = CurrentWeather.new(forecast_data)
        expect(current_weather.uv_exposure_level).to eq('very high')
      end
    end
  end
end
