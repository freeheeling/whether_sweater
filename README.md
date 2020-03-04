# Whether, Sweater? Sweater Weather

## Project Description
Sweater Weather utilizes the Ruby on Rails framework and [Fast JSON API](https://github.com/Netflix/fast_jsonapi) gem to expose aggregated data from multiple external APIs via a web-based API.

Based on the premises of being a back-end developer working on a team that is building an application to plan road trips, this app allows users to view the current weather as well as the forecasted weather at a destination.

The [Sweater Weather Service](https://sweater-weather-service.herokuapp.com/) is hosted on Heroku.

## Features
- Exposes an API that aggregates data from multiple external APIs
- Exposes an API that requires an authentication token
- Exposes an API for CRUD functionality
- Completes criteria based on the needs of other developers

## Local Installation

- clone down the repository: `$ git clone https://github.com/freeheeling/whether_sweater.git`
- change into directory: `$ cd whether_sweater`
- run bundler: `$ bundle install`
- prepare the database: `$ rake db:{create,migrate}` 
- initialize Rails server: `$ rails s`
- open browser, and visit: `http://localhost:3000`, which serves as the domain for all resource endpoints

## Database Composition

The database is comprised of a single resource type – Users – whose attributes are depicted by the following Active Designer-generated schema.

![schema](https://user-images.githubusercontent.com/50811220/75908595-ab4db500-5e07-11ea-840d-caa7dd9bd21d.png)

## Endpoints

Data for all endpoints are exposed under an `api` and version (`v1`) namespace, returned in JSON format.

### Application Landing Page

#### 1a. Retrieve weather for a city

```
GET /api/v1/forecast?location=denver,co
```

#### 1b. Retrieve Background Image for a city

```
GET /api/v1/backgrounds?location=denver,co
```
- This will return the url to an appropriate background image for a location.

### Registration Page

```
POST /api/v1/users

{
  "email": "user@example.com",
  "password": "password"
  "password_confirmation": "password"
}
```
- A successful request creates a user and generates a unique api key associated with that user.

### Login Page

```
POST /api/v1/sessions

{
  "email": "user@example.com",
  "password": "password"
}
```

- A successful request returns the user’s api key.

### Road Trip Page

```
POST /api/v1/road_trip

{
  "origin": "Denver,CO",
  "destination": "Pueblo,CO",
  "api_key": "jgn983hy48thw9begh98h4539h4"
}
```

## Requirements
Environment variables and required API keys:
* Dark Sky API key defined as `ENV['darksky_api_key']`
* Google API key defined as `ENV['google_api_key']`
* Unsplash API key defined as `ENV['unsplash_api_key']`

### Versions
- Ruby 2.6.3
- Rails 6.0.2

## Testing

### Testing Technologies
* [capybara](https://github.com/teamcapybara/capybara)
* [pry](https://github.com/pry/pry)
* [rspec](https://github.com/rspec/rspec)
* [shoulda-matchers](https://github.com/thoughtbot/shoulda-matchers)
* [simplecov](https://github.com/colszowka/simplecov)
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
