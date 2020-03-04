require 'rails_helper'

describe DarkskyService do
  context 'instance methods' do
    context '#darksky_data' do
      it 'returns weather data', :vcr do
        lat = '39.7392358'
        long = '-104.990251'
        future_time = '1583280695'

        search = DarkskyService.new(lat, long, future_time).darksky_data

        expect(search).to be_instance_of(Hash)

        expect(search).to have_key(:currently)
        expect(search).to have_key(:daily)
        expect(search).to have_key(:hourly)
      end
    end

    context '#future_darksky_data' do
      it 'returns future weather data', :vcr do
        lat = '39.7392358'
        long = '-104.990251'
        future_time = '1583280695'

        search = DarkskyService.new(lat, long, future_time).future_darksky_data

        expect(search).to be_instance_of(Hash)

        expect(search[:currently]).to have_key(:summary)
        expect(search[:currently]).to have_key(:temperature)
      end
    end

    context '#current_weather' do
      it 'returns current weather data', :vcr do
        lat = '39.7392358'
        long = '-104.990251'
        future_time = '1583280695'

        search = DarkskyService.new(lat, long, future_time).current_weather

        expect(search).to be_instance_of(Hash)

        expect(search).to have_key(:summary)
        expect(search).to have_key(:icon)
        expect(search).to have_key(:precipProbability)
        expect(search).to have_key(:temperature)
        expect(search).to have_key(:uvIndex)
      end
    end

    context '#daily_forecast' do
      it 'returns daily forecast data', :vcr do
        lat = '39.7392358'
        long = '-104.990251'
        future_time = '1583280695'

        search = DarkskyService.new(lat, long, future_time).daily_forecast

        expect(search).to be_instance_of(Hash)

        expect(search[:data][1]).to have_key(:time)
        expect(search[:data][1]).to have_key(:icon)
        expect(search[:data][1]).to have_key(:precipProbability)
        expect(search[:data][1]).to have_key(:precipType)
        expect(search[:data][1]).to have_key(:temperatureHigh)
        expect(search[:data][1]).to have_key(:temperatureLow)
      end
    end

    context '#hourly_forecast' do
      it 'returns hourly forecast data', :vcr do
        lat = '39.7392358'
        long = '-104.990251'
        future_time = '1583280695'

        search = DarkskyService.new(lat, long, future_time).hourly_forecast

        expect(search).to be_instance_of(Hash)

        expect(search[:data].first).to have_key(:time)
        expect(search[:data].first).to have_key(:icon)
        expect(search[:data].first).to have_key(:temperature)
      end
    end
  end
end
