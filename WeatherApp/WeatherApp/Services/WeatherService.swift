//
//  WeatherService.swift
//  WeatherApp
//
//  Created on 2025-11-17.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

class WeatherService {
    static let shared = WeatherService()

    private init() {}

    // 注意：使用前需要替换为你自己的 API Key
    // 可以在 https://www.weatherapi.com/ 免费注册获取
    private let apiKey = "YOUR_API_KEY_HERE"
    private let baseURL = "https://api.weatherapi.com/v1"

    /// 根据城市名称获取天气信息
    /// - Parameter city: 城市名称（支持中文）
    /// - Returns: 天气响应数据
    func fetchWeather(for city: String) async throws -> WeatherResponse {
        guard let encodedCity = city.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: "\(baseURL)/current.json?key=\(apiKey)&q=\(encodedCity)&aqi=no") else {
            throw NetworkError.invalidURL
        }

        let (data, _) = try await URLSession.shared.data(from: url)

        guard !data.isEmpty else {
            throw NetworkError.noData
        }

        do {
            let decoder = JSONDecoder()
            let weatherResponse = try decoder.decode(WeatherResponse.self, from: data)
            return weatherResponse
        } catch {
            print("Decoding error: \(error)")
            throw NetworkError.decodingError
        }
    }

    /// 根据经纬度获取天气信息
    /// - Parameters:
    ///   - latitude: 纬度
    ///   - longitude: 经度
    /// - Returns: 天气响应数据
    func fetchWeather(latitude: Double, longitude: Double) async throws -> WeatherResponse {
        let location = "\(latitude),\(longitude)"
        guard let url = URL(string: "\(baseURL)/current.json?key=\(apiKey)&q=\(location)&aqi=no") else {
            throw NetworkError.invalidURL
        }

        let (data, _) = try await URLSession.shared.data(from: url)

        guard !data.isEmpty else {
            throw NetworkError.noData
        }

        do {
            let decoder = JSONDecoder()
            let weatherResponse = try decoder.decode(WeatherResponse.self, from: data)
            return weatherResponse
        } catch {
            print("Decoding error: \(error)")
            throw NetworkError.decodingError
        }
    }
}
