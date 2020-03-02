class ForecastSerializer
  include FastJsonapi::ObjectSerializer
  attributes :search_location,
             :forecast
end
