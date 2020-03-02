class MunchieFacade
  attr_reader :id

  def initialize(origin, destination, cuisine)
    @id = nil
    @origin = origin
    @destination = destination
    @cuisine = cuisine
  end

  def end_location

  end

  def travel_time

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
