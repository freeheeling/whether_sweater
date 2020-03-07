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

  it 'can return message if no records found that match food search', :vcr do
    origin = 'denver,co'
    destination = 'pueblo,co'
    cuisine = '12345'

    get "/api/v1/munchies?start=#{origin}&end=#{destination}&food=#{cuisine}"

    expect(response).to be_successful

    response_data = JSON.parse(response.body, symbolize_names: true)

    expect(response_data[:data][:attributes]).to have_key(:end_location)
    expect(response_data[:data][:attributes]).to have_key(:travel_time)
    expect(response_data[:data][:attributes]).to have_key(:forecast)
    expect(response_data[:data][:attributes]).to have_key(:restaurant)

    restaurant_data = response_data[:data][:attributes][:restaurant]

    expect(restaurant_data[:name]).to eq('No records found matching search term')
    expect(restaurant_data[:address]).to eq('No records found matching search term')
  end
end
