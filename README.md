# Weather App

## Description

Weather App is a mobile application providing current weather information and forecasts for the coming days. The app utilizes data from the OpenWeatherMap API to display weather based on the user's geolocation or a city of their choice.

## Key Features

- **Current Weather Viewing**: Displays temperature, weather condition descriptions, weather icons, feels-like temperature, humidity, wind speed, visibility, and pressure.
- **Hourly and Daily Forecast**: Users can view detailed forecasts for the upcoming hours and days.
- **Add and Remove Cities**: Users can add favorite cities for quick access to weather forecasts.
- **Automatic Location Detection**: Using the user's IP address, the app automatically determines their location and displays the relevant weather.
- **Dark and Light Theme**: Supports both light and dark UI themes.

## Technologies

- **Flutter**: Used for creating the UI and app logic.
- **Provider**: Manages the application's state.
- **SharedPreferences**: Stores user settings locally, such as selected cities and preferred theme.
- **HTTP Client**: Interacts with REST APIs to fetch weather data.
