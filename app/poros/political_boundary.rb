class PoliticalBoundary
  def initialize(address_components)
    @address_components = address_components
  end

  def city_state_country
    {
      city: city,
      state_abbrev: abbreviated_state,
      country: country
    }
  end

  private

  attr_reader :address_components

  def city
    address_components[0][:long_name]
  end

  def abbreviated_state
    address_components[2][:short_name]
  end

  def country
    address_components[3][:long_name]
  end
end
