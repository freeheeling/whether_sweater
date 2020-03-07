class PoliticalBoundary
  attr_reader :city,
              :state_abbrev,
              :country

  def initialize(address_components)
    @city = get_city(address_components)
    @state_abbrev = get_state_abbrev(address_components)
    @country = get_country(address_components)
  end

  private

  def get_city(address_components)
    address_components[0][:long_name]
  end

  def get_state_abbrev(address_components)
    address_components[2][:short_name]
  end

  def get_country(address_components)
    address_components[3][:long_name]
  end
end
