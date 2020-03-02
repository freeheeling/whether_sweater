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
    @forecast_data ||= DarkskyService.new(lat, long).darksky_data
  end

  def search_location
    PoliticalBoundary.new(address_components)
  end

  def forecast
    Forecast.new(forecast_data)
  end

  private

  attr_reader :location

  def lat
    geolocation_data[:geometry][:location][:lat]
  end

  def long
    geolocation_data[:geometry][:location][:lng]
  end

  def address_components
    geolocation_data[:address_components]
  end
end
