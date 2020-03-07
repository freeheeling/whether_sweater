class Restaurant
  attr_reader :name,
              :address

  def initialize(restaurant_data)
    @name = get_name(restaurant_data)
    @address = get_address(restaurant_data)
  end

  private

  def get_name(restaurant_data)
    if restaurant_data.first == nil
      'No records found matching search term'
    else
      restaurant_data.first[:name]
    end
  end

  def get_address(restaurant_data)
    if restaurant_data.first == nil
      'No records found matching search term'
    else
      restaurant_data.first[:location][:display_address].join(', ')
    end
  end
end
