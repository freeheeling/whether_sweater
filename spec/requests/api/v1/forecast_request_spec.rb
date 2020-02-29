require 'rails_helper'

describe 'Forecast API' do
  it 'can retrieve weather for a city' do
    get '/api/v1/forecast?location=denver,co'

    expect(response).to be_successful
  end
end
