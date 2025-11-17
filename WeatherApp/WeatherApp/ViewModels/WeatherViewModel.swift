//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created on 2025-11-17.
//

import Foundation
import CoreLocation

@MainActor
class WeatherViewModel: ObservableObject {
    @Published var weather: WeatherResponse?
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let weatherService = WeatherService.shared

    /// 根据城市名称获取天气
    func fetchWeather(for city: String) async {
        isLoading = true
        errorMessage = nil

        do {
            let weatherData = try await weatherService.fetchWeather(for: city)
            self.weather = weatherData
        } catch NetworkError.invalidURL {
            errorMessage = "无效的 URL"
        } catch NetworkError.noData {
            errorMessage = "无数据返回"
        } catch NetworkError.decodingError {
            errorMessage = "数据解析失败"
        } catch {
            errorMessage = "发生未知错误: \(error.localizedDescription)"
        }

        isLoading = false
    }

    /// 根据经纬度获取天气
    func fetchWeather(latitude: Double, longitude: Double) async {
        isLoading = true
        errorMessage = nil

        do {
            let weatherData = try await weatherService.fetchWeather(latitude: latitude, longitude: longitude)
            self.weather = weatherData
        } catch NetworkError.invalidURL {
            errorMessage = "无效的 URL"
        } catch NetworkError.noData {
            errorMessage = "无数据返回"
        } catch NetworkError.decodingError {
            errorMessage = "数据解析失败"
        } catch {
            errorMessage = "发生未知错误: \(error.localizedDescription)"
        }

        isLoading = false
    }
}
