require 'rails_helper'

describe 'Forecast API' do
  it 'can return weather for a location', :vcr do
    get '/api/v1/forecast?location=denver,co'

    expect(response).to be_successful

    weather_data = JSON.parse(response.body, symbolize_names: true)

    expect(weather_data[:data][:attributes]).to have_key(:search_location)
    expect(weather_data[:data][:attributes]).to have_key(:forecast)

    expect(weather_data[:data][:attributes][:forecast]).to have_key(:current_weather)

    expect(weather_data[:data][:attributes][:forecast]).to have_key(:daily_forecast)
    expect(weather_data[:data][:attributes][:forecast][:daily_forecast].size).to eq(5)

    expect(weather_data[:data][:attributes][:forecast]).to have_key(:hourly_forecast)
    expect(weather_data[:data][:attributes][:forecast][:hourly_forecast].size).to eq(8)
  end
end
