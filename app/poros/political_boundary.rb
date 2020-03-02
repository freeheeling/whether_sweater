class PoliticalBoundary
  attr_reader :city,
              :state_abbrev,
              :country

  def initialize(address_components)
    @city = address_components[0][:long_name]
    @state_abbrev = address_components[2][:short_name]
    @country = address_components[3][:long_name]
  end
end
