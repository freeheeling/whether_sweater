require 'rails_helper'

describe YelpService do
  context 'instance methods' do
    context '#business_from_term' do
      it 'returns restaurant business data', :vcr do
        lat = '38.2542053'
        long = '104.6087488'
        cuisine = 'bagel'
        time = '1583560000'

        search = YelpService.new(lat, long, cuisine, time).business_from_term

        expect(search).to be_instance_of(Hash)

        restaurant_data = search[:businesses]

        expect(restaurant_data.first).to have_key(:name)
        expect(restaurant_data.first).to have_key(:location)
        expect(restaurant_data.first[:location]).to have_key(:display_address)
      end

      it 'returns zero results if no restaurants matching search terms are found', :vcr do
        lat = '38.2542053'
        long = '104.6087488'
        cuisine = 'chinese'
        time = '1583560000'

        search = YelpService.new(lat, long, cuisine, time).business_from_term

        expect(search).to be_instance_of(Hash)

        restaurant_data = search[:businesses]

        expect(restaurant_data.first).to eq(nil)
      end
    end
  end
end
