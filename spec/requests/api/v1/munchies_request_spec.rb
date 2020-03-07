require 'rails_helper'

describe 'Munchies API endpoint' do
  it 'can return food & forecast info for a destination city', :vcr do
    origin = 'denver,co'
    destination = 'pueblo,co'
    cuisine = 'bagel'

    get "/api/v1/munchies?start=#{origin}&end=#{destination}&food=#{cuisine}"

    expect(response).to be_successful

    response_data = JSON.parse(response.body, symbolize_names: true)

    expect(response_data[:data][:attributes]).to have_key(:end_location)
    expect(response_data[:data][:attributes]).to have_key(:travel_time)
    expect(response_data[:data][:attributes]).to have_key(:forecast)
    expect(response_data[:data][:attributes]).to have_key(:restaurant)

    expect(response_data[:data][:attributes][:restaurant]).to have_key(:name)
    expect(response_data[:data][:attributes][:restaurant]).to have_key(:address)
  end
end
