require 'rails_helper'

describe GoogleService do
  context 'instance methods' do
    context '#geocode_data' do
      it 'returns geolocation data', :vcr do
        search = GoogleService.new('denver,co', 'pueblo,co').geocode_data

        expect(search).to be_instance_of(Hash)

        address_components = search[:address_components]

        expect(address_components[0]).to have_key(:long_name)
        expect(address_components[2]).to have_key(:short_name)
        expect(address_components[3]).to have_key(:long_name)

        coordinates = search[:geometry][:location]

        expect(coordinates).to have_key(:lat)
        expect(coordinates).to have_key(:lng)
      end
    end

    context '#directions_data' do
      it 'returns route data', :vcr do
        search = GoogleService.new('denver,co', 'pueblo,co').directions_data

        expect(search).to be_instance_of(Hash)

        expect(search).to have_key(:duration)
        expect(search).to have_key(:end_address)
        expect(search).to have_key(:start_address)
      end
    end
  end
end
