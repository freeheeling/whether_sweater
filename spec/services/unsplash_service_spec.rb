require 'rails_helper'

describe UnsplashService do
  context 'instance methods' do
    context '#image_for_query' do
      it 'returns image data', :vcr do
        search = UnsplashService.new('denver,co').image_for_query

        expect(search).to be_instance_of(Array)
        expect(search.size).to eq(1)

        image_data = search.first

        expect(image_data).to have_key(:urls)
        expect(image_data[:urls]).to have_key(:raw)
      end
    end
  end
end
