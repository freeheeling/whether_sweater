require 'rails_helper'

describe 'Background API' do
  it 'can return background image of a location', :vcr do
    headers = { CONTENT_TYPE: 'application/json', ACCEPT: 'application/json' }

    get '/api/v1/backgrounds?location=denver,co'

    expect(response).to be_successful

    parsed_json = JSON.parse(response.body, symbolize_names: true)

    expect(parsed_json[:data][:attributes]).to have_key(:image_uri)
  end
end
