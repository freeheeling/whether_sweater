require 'rails_helper'

describe 'Road Trip API endpoint' do
  describe 'for a request that includes an origin, destination and API key' do
    it 'can return origin, destination, arrival forecast info and travel time', :vcr do
      user = User.create(
               email: 'whatever@example.com',
               password: 'password',
               password_confirmation: 'password'
            )

      headers = { CONTENT_TYPE: 'application/json', ACCEPT: 'application/json' }
      params = {
        origin: 'Denver,CO',
        destination: 'Pueblo,CO',
        api_key: user.api_key
      }

      post '/api/v1/road_trip', params: params

      expect(response).to be_successful

      parsed_json = JSON.parse(response.body, symbolize_names: true)

      expect(parsed_json[:data][:attributes]).to have_key(:origin)
      expect(parsed_json[:data][:attributes]).to have_key(:destination)
      expect(parsed_json[:data][:attributes]).to have_key(:travel_time)
      expect(parsed_json[:data][:attributes]).to have_key(:arrival_forecast)
    end
  end

  describe 'for a road_trip request that includes an incorrect or missing API key' do
    it 'returns a 401 (Unauthorized) status code', :vcr do
      user = User.create(
               email: 'whatever@example.com',
               password: 'password',
               password_confirmation: 'password'
            )

      headers = { CONTENT_TYPE: 'application/json', ACCEPT: 'application/json' }
      params = {
        origin: 'Denver,CO',
        destination: 'Pueblo,CO',
        api_key: 'invalid_key'
      }

      post '/api/v1/road_trip', params: params

      expect(response).to_not be_successful

      parsed_json = JSON.parse(response.body, symbolize_names: true)

      expect(parsed_json[:data][:attributes][:invalid_key]).to eq('Unauthorized')
    end
  end
end
