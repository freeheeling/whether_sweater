require 'rails_helper'

describe 'Registration API endpoint' do
  it 'successful request creates user and generates unique api key for user' do
    headers = { CONTENT_TYPE: 'application/json', ACCEPT: 'application/json' }
    params = {
      email: 'whatever@example.com',
      password: 'password',
      password_confirmation: 'password'
    }

    post '/api/v1/users', params: params

    expect(response).to be_successful

    parsed_json = JSON.parse(response.body, symbolize_names: true)

    expect(parsed_json[:data][:attributes]).to have_key(:api_key)
    expect(parsed_json[:data][:attributes][:api_key]).to_not eq(nil)
  end

  it "returns 400 level status code and error message if passwords don't match" do
    headers = { CONTENT_TYPE: 'application/json', ACCEPT: 'application/json' }
    params = {
      email: 'whatever@example.com',
      password: 'forward',
      password_confirmation: 'reverse'
    }

    post '/api/v1/users', params: params

    expect(response).to_not be_successful

    parsed_json = JSON.parse(response.body, symbolize_names: true)
    password_error = parsed_json[:data][:attributes][:error_message][:password_confirmation]

    expect(parsed_json[:data][:id]).to eq(nil)
    expect(password_error).to include("doesn't match Password")
  end

  it 'returns 400 level status code and error message if email is not unique' do
    User.create(
      email: 'whatever@example.com',
      password: 'password',
      password_confirmation: 'password'
    )

    headers = { CONTENT_TYPE: 'application/json', ACCEPT: 'application/json' }
    params = {
      email: 'whatever@example.com',
      password: 'drowssap',
      password_confirmation: 'drowssap'
    }

    post '/api/v1/users', params: params

    expect(response).to_not be_successful

    parsed_json = JSON.parse(response.body, symbolize_names: true)
    email_error = parsed_json[:data][:attributes][:error_message][:email]

    expect(parsed_json[:data][:id]).to eq(nil)
    expect(email_error).to include('has already been taken')
  end

  it 'returns 400 level status code and error message if a field is empty' do
    headers = { CONTENT_TYPE: 'application/json', ACCEPT: 'application/json' }
    params = {
      email: '',
      password: 'password',
      password_confirmation: 'password'
    }

    post '/api/v1/users', params: params

    expect(response).to_not be_successful

    parsed_json = JSON.parse(response.body, symbolize_names: true)
    field_error = parsed_json[:data][:attributes][:error_message][:email]

    expect(parsed_json[:data][:id]).to eq(nil)
    expect(field_error).to include("can't be blank")
  end

  it 'returns 400 level status code and error message if email is invalid' do
    headers = { CONTENT_TYPE: 'application/json', ACCEPT: 'application/json' }
    params = {
      email: 'whatever.com',
      password: 'password',
      password_confirmation: 'password'
    }

    post '/api/v1/users', params: params

    expect(response).to_not be_successful

    parsed_json = JSON.parse(response.body, symbolize_names: true)
    email_error = parsed_json[:data][:attributes][:error_message][:email]

    expect(parsed_json[:data][:id]).to eq(nil)
    expect(email_error).to include('is invalid')
  end

  it 'returns 400 level status code and error message if password length is too short' do
    headers = { CONTENT_TYPE: 'application/json', ACCEPT: 'application/json' }
    params = {
      email: 'whatever@example.com',
      password: 'passw',
      password_confirmation: 'passw'
    }

    post '/api/v1/users', params: params

    expect(response).to_not be_successful

    parsed_json = JSON.parse(response.body, symbolize_names: true)
    password_error = parsed_json[:data][:attributes][:error_message][:password]

    expect(parsed_json[:data][:id]).to eq(nil)
    expect(password_error).to include('is too short (minimum is 6 characters)')
  end
end
