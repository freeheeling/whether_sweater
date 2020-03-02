class MunchieFacade
  attr_reader :id

  def initialize(origin, destination, cuisine)
    @id = nil
    @origin = origin
    @destination = destination
    @cuisine = cuisine
  end

  def route_data
    @route_data ||= GoogleService.new(origin, destination).directions_data
  end

  def end_location
    route_data.first[:end_address]
  end

  def travel_time
    route_data.first[:duration][:text]
  end

  def forecast

  end

  def restaurant

  end

  private

  attr_reader :origin,
              :destination,
              :cuisine
end
