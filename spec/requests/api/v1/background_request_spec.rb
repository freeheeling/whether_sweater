require 'rails_helper'

describe 'Background API' do
  it 'can return background image of a location', :vcr do
    get '/api/v1/backgrounds?location=denver,co'

    expect(response).to be_successful

    image_data = JSON.parse(response.body, symbolize_names: true)

    expect(image_data[:data][:attributes]).to have_key(:image_uri)
  end
end
