# Sweater Weather 

Sweater Weather is an API that allows users to look up forecasts for a given location, make a road trip, and add users and sessions. The API endpoints are designed to manipulate data and return what the user is searching for within a query param. 

## Table of Contents

  - [Getting Started](#getting-started)
  - [Versions](#versions)
  - [Local Setup](#local-setup)
  - [Endpoints](#endpoints)
  - [Examples](#examples)
  - [Running the Tests](#running-the-tests)
  - [Developers](#developers)
  - [Acknowledgments](#acknowledgments)

## Getting Started

Visit http://localhost:3000 and get started with the steps below. 

## Versions

- Ruby 2.5.3

- Rails 5.2.5

## Local Setup

1. Fork and Clone this repo
2. Setup the database: `rails db:(drop,create,migrate,seed)` or `rails db:setup`
3. Run command `rails s` and navigate to http://localhost:3000 to consume API endpoints below 

## Endpoints 
The following are all API endpoints. Note, some endpoints have optional or required query parameters.
 - All endpoints run off base connector `http://localhost:3000` on local

| Method   | URL                                      | Description                              |
| -------- | ---------------------------------------- | ---------------------------------------- |
| `GET`    | `/api/v1/forecast?location=<location>`                             | Retrieve forecast for a given location.                      |
| `GET`   | `/api/v1/backgrounds?location=<location>`                             | Retrieve city backgrounds for a given location.                       |
| `GET`    | `/api/v1/book-search?location=<location>&quantity=<quantity>`                          | Retrieve books with titles of a given location.                       |
| `POST`  | `/api/v1/road_trip?origin=<origin>&destination=<destination>&api_key=<api_key>`                          | Create a new road trip for a user by authenticating their api key.                 |
| `POST`   | `/api/v1/users?email=<email>&password=<password>&password_confirmation=<password_confirmation>`                 | Create a new user. Email must not exist and passwords must match.                 |
| `POST`   | `api/v1/sessions?email=<email>&password=<password>` | Create a session for a user. Email and password must match a user in the database to create a session. | 

## Example Responses 

### Weather for a city(location): 

``` 
{
  "data": {
    "id": null,
    "type": "forecast",
    "attributes": {
      "current_weather": {
        "datetime": "2020-09-30 13:27:03 -0600",
        "temperature": 79.4,
        etc
      },
      "daily_weather": [
        {
          "date": "2020-10-01",
          "sunrise": "2020-10-01 06:10:43 -0600",
          etc
        },
        {...} etc
      ],
      "hourly_weather": [
        {
          "time": "14:00:00",
          "conditions": "cloudy with a chance of meatballs",
          etc
        },
        {...} etc
      ]
    }
  }
}
``` 

### Background image for a city: 

``` 
{
  "data": {
    "id": null,
    "type": "image",
    "attributes": {
      "description": "people walking on street near brown concrete building during daytime",
      "image_url": "https://images.unsplash.com/photo-1617379527979-3ab4b133f37f?     crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwyMzkxMjl8MHwxfHJhbmRvbXx8fHx8fHx8fDE2MjM4MTE2MjQ&ixlib=rb-1.2.1&q=80&w=1080",
      "source": "https://unsplash.com/photos/uquc2_aHuLQ",
      "author": "qOQ1e9l0U_s"
      }
    }
  }
}
``` 

### Create a user 
``` 
{
  "data": {
    "type": "users",
    "id": "1",
    "attributes": {
      "email": "whatever@example.com",
      "api_key": "jgn983hy48thw9begh98h4539h4"
    }
  }
}
``` 
### Login a user
```
{
  "data": {
    "type": "users",
    "id": "1",
    "attributes": {
      "email": "whatever@example.com",
      "api_key": "jgn983hy48thw9begh98h4539h4"
    }
  }
}
```
### Create a road trip 
```
{
  "data": {
    "id": null,
    "type": "roadtrip",
    "attributes": {
      "start_city": "Denver, CO",
      "end_city": "Estes Park, CO",
      "travel_time": "2 hours, 13 minutes"
      "weather_at_eta": {
        "temperature": 59.4,
        "conditions": "partly cloudy with a chance of meatballs"
      }
    }
  }
}
```

## Running the tests

Run all tests in application with `bundle exec rspec`. When test is complete, run `open coverage` to see where tests are being run and where they are not.

## Deployment

- To run this app locally, run `rails s` and navigate to `http://localhost:3000/` in your browser.

## Built Using

  - Ruby on Rails
