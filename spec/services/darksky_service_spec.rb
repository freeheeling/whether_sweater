require 'rails_helper'

describe DarkskyService do
  context 'instance methods' do
    context '#darksky_data' do
      it 'returns weather data', :vcr do
        lat = '39.7392358'
        long = '-104.990251'
        search = DarkskyService.new(lat, long).darksky_data

        expect(search).to be_instance_of(Hash)

        expect(search[:currently]).to have_key(:time)
        expect(search[:currently]).to have_key(:temperature)
        expect(search[:currently]).to have_key(:apparentTemperature)
        expect(search[:currently]).to have_key(:icon)
        expect(search[:currently]).to have_key(:humidity)
        expect(search[:currently]).to have_key(:visibility)
        expect(search[:currently]).to have_key(:uvIndex)

        expect(search[:daily]).to have_key(:summary)

        expect(search[:daily][:data]).to be_instance_of(Array)
        expect(search[:daily][:data][0]).to have_key(:time)
        expect(search[:daily][:data][0]).to have_key(:temperatureHigh)
        expect(search[:daily][:data][0]).to have_key(:temperatureLow)
        expect(search[:daily][:data][0]).to have_key(:icon)
        expect(search[:daily][:data][0]).to have_key(:precipProbability)
        expect(search[:daily][:data][0]).to have_key(:precipType)

        expect(search[:hourly][:data]).to be_instance_of(Array)
        expect(search[:hourly][:data][0]).to have_key(:icon)
        expect(search[:hourly][:data][0]).to have_key(:time)
        expect(search[:hourly][:data][0]).to have_key(:temperature)
      end
    end
  end
end
