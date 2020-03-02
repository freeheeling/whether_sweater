require 'rails_helper'

describe 'Munchies API endpoint' do
  it 'can return food & forecast info for a destination city' do
    get '/api/v1/munchies?start=denver,co&end=pueblo,co&food=chinese'

    expect(response).to be_successful

    response_data = JSON.parse(response.body, symbolize_names: true)

    expect(response_data[:data]).to have_key(:munchie)

    expect(response_data[:attributes]).to have_key(:end_location)
    expect(response_data[:attributes]).to have_key(:travel_time)
    expect(response_data[:attributes]).to have_key(:forecast)
    expect(response_data[:attributes]).to have_key(:restaurant)

    expect(response_data[:attributes][:restaurant]).to have_key(:name)
    expect(response_data[:attributes][:restaurant]).to have_key(:address)
  end
end

# {
#   "data": {
#     "id": "null",
#     "type": "munchie",
#     "attributes": {
#       "end_location": "Pueblo, CO",
#       "travel_time": "1 hours 48 min",
#       "forecast": "Cloudy with a chance of meatballs"
#       "restaurant": {
#         "name": "Chinese Restaurant",
#         "address": "4602 N. Elizabeth St, Ste 120, Pueblo, CO 81008"
#       }
#     }
#   }
# }
