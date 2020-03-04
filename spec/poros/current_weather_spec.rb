require 'rails_helper'

describe CurrentWeather do
  describe 'instance methods' do
    context '#uv_exposure_level' do
      xit 'returns associated uv exposure level for uv index number' do
        current_conditions = {
          currently: {
            time: 1583330087,
            summary: 'Clear',
            icon: 'clear-night',
            temperature: 53.28,
            apparentTemperature: 53.28,
            humidity: 0.69,
            visibility: 10,
            uvIndex: 0
          },
          daily: {
            summary: 'Light rain next Wednesday.'
          },
          hourly: {
            data: {
              icon: 'clear-night',
              summary: 'Clear'
            }
          }
        }

        current_weather = CurrentWeather.new(current_conditions)

        expect(current_conditions[:currently][:uvIndex]).to eq(0)
        expect(current_weather.uv_exposure_level).to eq('low')

        current_conditions[:currently][:uvIndex] = 5
        expect(current_weather.uv_exposure_level).to eq('moderate')

        current_conditions[:currently][:uvIndex] = 7
        expect(current_weather.uv_exposure_level).to eq('high')

        current_conditions[:currently][:uvIndex] = 10
        expect(current_weather.uv_exposure_level).to eq('very high')

        current_conditions[:currently][:uvIndex] = 11
        expect(current_weather.uv_exposure_level).to eq('extreme')
      end
    end
  end
end
