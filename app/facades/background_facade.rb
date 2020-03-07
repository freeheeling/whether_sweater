class BackgroundFacade
  attr_reader :id,
              :image_uri

  def initialize(location)
    @id = nil
    @location = location
    @image_uri = get_image_uri
  end

  private

  attr_reader :location

  def image_data
    @image_data ||= UnsplashService.new(location).image_for_query
  end

  def get_image_uri
    image_data.first[:urls][:raw]
  end
end
