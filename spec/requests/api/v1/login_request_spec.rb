require 'rails_helper'

describe 'Login API endpoint' do
  it 'successful login returns api key for associated user' do
    User.create(
      email: 'whatever@example.com',
      password: 'password',
      password_confirmation: 'password'
    )

    headers = { CONTENT_TYPE: 'application/json', ACCEPT: 'application/json' }
    params = { email: 'whatever@example.com', password: 'password' }

    post '/api/v1/sessions', params: params

    expect(response).to be_successful

    parsed_json = JSON.parse(response.body, symbolize_names: true)

    expect(parsed_json[:data][:attributes]).to have_key(:api_key)
    expect(parsed_json[:data][:attributes][:api_key]).to_not eq(nil)
  end

  it 'returns 400 level status code and invalid credentials response for invalid email/password combination' do
    User.create(
      email: 'whatever@example.com',
      password: 'password',
      password_confirmation: 'password'
    )

    headers = { CONTENT_TYPE: 'application/json', ACCEPT: 'application/json' }
    params = { email: 'whatever@example.com', password: 'invalid_password' }

    post '/api/v1/sessions', params: params

    expect(response).to_not be_successful

    parsed_json = JSON.parse(response.body, symbolize_names: true)
    invalid_credentials_error = parsed_json[:data][:attributes][:invalid_credentials]

    expect(invalid_credentials_error).to eq('Invalid email or password')
  end
end
