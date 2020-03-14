# Whether, Sweater? Sweater Weather

## Project Description
Based on the premises of being a back-end developer working on a team that is building an application to plan road trips, this app allows users to view the current and forecasted weather at a destination.

The Heroku-hosted [Sweater Weather Service](https://sweater-weather-service.herokuapp.com/) app utilizes the Ruby on Rails framework and [Fast JSON API](https://github.com/Netflix/fast_jsonapi) gem to expose aggregated data from multiple external APIs via a web-based API. [Project requirements](https://backend.turing.io/module3/projects/sweater_weather/requirements) provide an overview of the app's wireframes.

## Features
- Exposes an API that aggregates data from multiple external APIs
- Exposes an API that requires an authentication token
- Exposes an API for CRUD functionality
- Completes criteria based on the needs of other developers

## APIs Used
- [Dark Sky API](https://darksky.net/dev)
- [Google Directions API](https://developers.google.com/maps/documentation/directions/start)
- [Google Geocoding API](https://developers.google.com/maps/documentation/geocoding/start)
- [Unsplash API](https://unsplash.com/developers)
- [Yelp Fusion API](https://www.yelp.com/developers/documentation/v3/get_started)

## Local Installation

- clone down the repository: `$ git clone https://github.com/freeheeling/whether_sweater.git`
- change into directory: `$ cd whether_sweater`
- run bundler: `$ bundle install`
- prepare the database: `$ rake db:{create,migrate}` 
- initialize Rails server: `$ rails s`
- open browser, and visit: `http://localhost:3000`, which serves as the domain for all resource endpoints

## Database Composition

The database is comprised of a single resource type – `Users` – whose attributes are depicted by the following visual schema.

<img width="253" alt="schema" src="https://user-images.githubusercontent.com/50811220/76686961-9c40e100-6617-11ea-8c92-728e0c277731.png">

## Endpoints

Data for all endpoints are exposed under an `api` and version (`v1`) namespace, the responses of which are returned in JSON format.

### HTTP Headers

To make a request with JSON, the appropriate HTTP headers should be:
```
Content-Type: application/json
Accept: application/json
```

### Application Landing Page

#### Forecast endpoint

Provide a location. A successful request returns geolocation details from the [Google Geocoding API](https://developers.google.com/maps/documentation/geocoding/start), and current weather conditions and an hourly (next 8 hours) and daily forecast (next 5 days) for the requested location from the [Dark Sky API](https://darksky.net/dev).

| URI endpoint | HTTP method | Query Parameter |
| :-----------:|:-----------:| :--------------:|
| `/forecast`  | GET         | `location`      |

Query Parameter specifications:
- `location`: comma-separated city and state (e.g., denver,co)

Example request:
```
GET https://sweater-weather-service.herokuapp.com/api/v1/forecast?location=denver,co
```
Example response:
```json
{
    "data": {
        "id": null,
        "type": "forecast",
        "attributes": {
            "search_location": {
                "city": "Denver",
                "state_abbrev": "CO",
                "country": "United States"
            },
            "forecast": {
                "current_weather": {
                    "time_and_date": "2:43 PM, 3/14",
                    "unix_timestamp": 1584197033,
                    "weather_conditions": "Partly Cloudy",
                    "weather_icon": "partly-cloudy-day",
                    "temp_F": 34,
                    "feels_like_F": 34,
                    "humidity_percent": 76,
                    "visibility_miles": 10,
                    "uv_index_number": 1,
                    "uv_exposure_level": "low",
                    "today_summary": "Clear throughout the day.",
                    "tonight_summary": "Clear"
                },
                "daily_forecast": [
                    {
                        "day_of_week": "Sunday",
                        "unix_timestamp": 1584252000,
                        "weather_icon": "partly-cloudy-day",
                        "precip_type": "rain",
                        "precip_probability_percent": 7,
                        "high_temp_F": 63,
                        "low_temp_F": 33
                    }, ...
                ],
                "hourly_forecast": [
                    {
                        "hour_of_day": "2 PM",
                        "unix_timestamp": 1584194400,
                        "weather_icon": "partly-cloudy-day",
                        "temp_F": 33
                    }, ...
                  
                ]
            }
        }
    }
}
```

#### Background Image endpoint

Provide a location. A successful request returns an image URL from the [Unsplash API](https://unsplash.com/developers) for the requested location.

| URI endpoint    | HTTP method | Query Parameter |
| :--------------:|:-----------:| :--------------:|
| `/backgrounds`  | GET         | `location`      |

Query Parameter specifications:
- `location`: comma-separated city and state (e.g., seattle,wa)

Example request:
```
GET https://sweater-weather-service.herokuapp.com/api/v1/backgrounds?location=seattle,wa
```

### Registration Page endpoint

Provide a valid and unique email address, password and matching password confirmation. A successful request creates a user in the database and generates and returns a unique API key associated with that user.

| URI endpoint | HTTP method | Query Parameters                             |
| :-----------:|:-----------:| :-------------------------------------------:|
| `/users`     | POST        | `email`, `password`, `password_confirmation` |

Query Parameter specifications:
- `email`: must be a valid type of address and unique within the database
- `password`: must be at least 6 characters
- `password_confirmation`: must match the provided password

Example request:
```
POST https://sweater-weather-service.herokuapp.com/api/v1/users

{
  "email": "user@example.com",
  "password": "password"
  "password_confirmation": "password"
}
```

### Login Page endpoint

Provide email address and password for an existing user. A successful request returns the user’s API key.

| URI endpoint | HTTP method | Query Parameters    |
| :-----------:|:-----------:| :------------------:|
| `/sessions`  | POST        | `email`, `password` |

Query Parameter specifications:
- `email`: valid email address stored in database
- `password`: must be associated with provided user email address

Example request:
```
POST https://sweater-weather-service.herokuapp.com/api/v1/sessions

{
  "email": "user@example.com",
  "password": "password"
}
```

### Road Trip Page endpoint

Provide organ, destination and logged-in user's API key. A successful request returns the travel time, forecasted weather conditions and temperature upon arrival.

| URI endpoint | HTTP method | Query Parameters                   |
| :-----------:|:-----------:| :---------------------------------:|
| `/road_trip` | POST        | `origin`, `destination`, `api_key` |

Query Parameter specifications:
- `origin`: comma-separated city and state (e.g., portland,or)
- `destination`: comma-separated city and state (e.g., seattle,wa)
- `api_key`: valid 24-character key, unique to user, received upon registration or login

Example request:
```
POST https://sweater-weather-service.herokuapp.com/api/v1/road_trip

{
  "origin": "portland,or",
  "destination": "seattle,wa",
  "api_key": "jgn983hy48thw9begh98h4539h4"
}
```

### Munchies Page endpoint

Provide an origin, destination and food or cuisine type. A successful request returns the travel time, weather forecast and closest, open restaurant matching search criteria at destination upon arrival, using the [Google Directions API](https://developers.google.com/maps/documentation/directions/start), [Dark Sky API](https://darksky.net/dev) and [Yelp Fusion API](https://www.yelp.com/developers/documentation/v3/get_started).

| URI endpoint | HTTP method | Query Parameters       |
| :-----------:|:-----------:| :---------------------:|
| `/munchies`  | GET         | `start`, `end`, `food` |

Query Parameter specifications:
- `start`: comma-separated city and state (e.g., portland,or)
- `end`: comma-separated city and state (e.g., seattle,wa)
- `food`: food or cuisine type (e.g., pho)

Example request:
```
GET https://sweater-weather-service.herokuapp.com/api/v1/munchies?start=portland,or&end=seattle,wa&food=pho
```

## Requirements

### Environment variables and required API keys:
* Dark Sky API key defined as `ENV['darksky_api_key']`
* Google API key defined as `ENV['google_api_key']`
* Unsplash API key defined as `ENV['unsplash_api_key']`
* Yelp API key defined as `ENV['yelp_api_key']`

### Versions
- Ruby 2.6.3
- Rails 6.0.2

## Testing

### Testing Technologies
* [capybara](https://github.com/teamcapybara/capybara)
* [pry](https://github.com/pry/pry)
* [rspec](https://github.com/rspec/rspec)
* [shoulda-matchers](https://github.com/thoughtbot/shoulda-matchers)
#### Test Coverage
* [simplecov](https://github.com/colszowka/simplecov)
#### Response Caching
* [vcr](https://github.com/vcr/vcr)
* [webmock](https://github.com/bblimke/webmock)

### Running Tests
Run the full test suite:
```
$ bundle exec rspec
```

Run a single test file:
```
$ bundle exec rspec <path-to-file>
```
### Refreshing VCR Test Cassettes

Errors will occasionally occur when testing with VCR. To refresh the cassettes being used, delete the cassettes directory within the spec folder and run `bundle exec rspec`. Reference the [VCR documentation](https://github.com/vcr/vcr) for more information pertaining to VCR cassettes.
