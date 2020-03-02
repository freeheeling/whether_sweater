class ForecastFacade
  attr_reader :id

  def initialize(location)
    @id = nil
    @location = location
  end

  def geolocation_data
    @geolocation_data ||= GoogleService.new(location).geocode_data
  end

  def forecast_data
    lat = geolocation_data[:geometry][:location][:lat]
    long = geolocation_data[:geometry][:location][:lng]
    @forecast_data ||= DarkskyService.new(lat, long).darksky_data
  end

  def search_location
    address_components = geolocation_data[:address_components]
    PoliticalBoundary.new(address_components)
  end

  def forecast
    Forecast.new(forecast_data)
  end

  private

  attr_reader :location
end
