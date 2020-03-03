require 'rails_helper'

describe 'Registration API endpoint' do
  it 'successful request creates user and generates unique api key associated with user' do
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


# POST /api/v1/users
# Content-Type: application/json
# Accept: application/json

# {
#   "email": "whatever@example.com",
#   "password": "password"
#   "password_confirmation": "password"
# }
