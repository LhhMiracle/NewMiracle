//
//  WeatherData.swift
//  WeatherApp
//
//  Created on 2025-11-17.
//

import Foundation

// MARK: - Weather Response
struct WeatherResponse: Codable {
    let location: Location
    let current: CurrentWeather
}

// MARK: - Location
struct Location: Codable {
    let name: String
    let region: String
    let country: String
    let lat: Double
    let lon: Double
    let localtime: String

    enum CodingKeys: String, CodingKey {
        case name, region, country, lat, lon, localtime
    }
}

// MARK: - Current Weather
struct CurrentWeather: Codable {
    let tempC: Double
    let tempF: Double
    let condition: WeatherCondition
    let windKph: Double
    let windMph: Double
    let humidity: Int
    let feelslikeC: Double
    let feelslikeF: Double
    let uv: Double

    enum CodingKeys: String, CodingKey {
        case tempC = "temp_c"
        case tempF = "temp_f"
        case condition
        case windKph = "wind_kph"
        case windMph = "wind_mph"
        case humidity
        case feelslikeC = "feelslike_c"
        case feelslikeF = "feelslike_f"
        case uv
    }
}

// MARK: - Weather Condition
struct WeatherCondition: Codable {
    let text: String
    let icon: String
}

// MARK: - Mock Data for Testing
extension WeatherResponse {
    static var preview: WeatherResponse {
        WeatherResponse(
            location: Location(
                name: "北京",
                region: "Beijing",
                country: "China",
                lat: 39.93,
                lon: 116.40,
                localtime: "2025-11-17 12:00"
            ),
            current: CurrentWeather(
                tempC: 15.0,
                tempF: 59.0,
                condition: WeatherCondition(
                    text: "晴",
                    icon: "//cdn.weatherapi.com/weather/64x64/day/113.png"
                ),
                windKph: 10.0,
                windMph: 6.2,
                humidity: 45,
                feelslikeC: 14.0,
                feelslikeF: 57.2,
                uv: 3.0
            )
        )
    }
}
