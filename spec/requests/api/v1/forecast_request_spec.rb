require 'rails_helper'

describe 'Forecast API' do
  it 'can return weather for a location', :vcr do
    headers = { CONTENT_TYPE: 'application/json', ACCEPT: 'application/json' }
    get '/api/v1/forecast?location=denver,co'

    expect(response).to be_successful

    parsed_json = JSON.parse(response.body, symbolize_names: true)

    expect(parsed_json[:data][:attributes]).to have_key(:search_location)
    expect(parsed_json[:data][:attributes]).to have_key(:forecast)

    expect(parsed_json[:data][:attributes][:forecast]).to have_key(:current_weather)

    expect(parsed_json[:data][:attributes][:forecast]).to have_key(:daily_forecast)
    expect(parsed_json[:data][:attributes][:forecast][:daily_forecast].size).to eq(5)

    expect(parsed_json[:data][:attributes][:forecast]).to have_key(:hourly_forecast)
    expect(parsed_json[:data][:attributes][:forecast][:hourly_forecast].size).to eq(8)
  end
end
