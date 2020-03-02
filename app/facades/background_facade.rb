class BackgroundFacade
  attr_reader :id

  def initialize(location)
    @id = nil
    @location = location
  end

  def image_data
    @image_data ||= UnsplashService.new(location).image_for_query
  end

  def image_uri
    image_data.first[:urls][:raw]
  end

  private

  attr_reader :location
end
