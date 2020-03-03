require 'rails_helper'

describe 'Registration API endpoint' do
  it 'successful request creates user and generates unique api key associated with user', :vcr do
      WebMock.enable_net_connect!
      VCR.eject_cassette
      VCR.turn_off!(ignore_cassettes: true)

    headers = { CONTENT_TYPE: 'application/json', ACCEPT: 'application/json' }
    params = {
      email: 'whatever@example.com',
      password: 'password',
      password_confirmation: 'password'
    }

    post '/api/v1/users', params: params

    expect(response).to be_successful
  end
end
