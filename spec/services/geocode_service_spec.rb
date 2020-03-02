require 'rails_helper'

describe GeocodeService do
  context 'instance methods' do
    context '#geocode_data' do
      it 'returns geolocation data', :vcr do
        search = GeocodeService.new('denver,co').geocode_data

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
  end
end
