//
//  WeatherView.swift
//  WeatherApp
//
//  Created on 2025-11-17.
//

import SwiftUI

struct WeatherView: View {
    let weather: WeatherResponse

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // 城市信息
                VStack(spacing: 5) {
                    Text(weather.location.name)
                        .font(.system(size: 40, weight: .medium))
                        .foregroundColor(.white)

                    Text("\(weather.location.region), \(weather.location.country)")
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.8))
                }
                .padding(.top, 20)

                // 温度和天气状况
                VStack(spacing: 10) {
                    Text("\(Int(weather.current.tempC))°C")
                        .font(.system(size: 80, weight: .thin))
                        .foregroundColor(.white)

                    Text(weather.current.condition.text)
                        .font(.title2)
                        .foregroundColor(.white)

                    Text("体感温度 \(Int(weather.current.feelslikeC))°C")
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.8))
                }
                .padding(.vertical)

                // 详细信息卡片
                VStack(spacing: 15) {
                    HStack(spacing: 20) {
                        WeatherDetailCard(
                            icon: "humidity.fill",
                            title: "湿度",
                            value: "\(weather.current.humidity)%"
                        )

                        WeatherDetailCard(
                            icon: "wind",
                            title: "风速",
                            value: "\(String(format: "%.1f", weather.current.windKph)) km/h"
                        )
                    }

                    HStack(spacing: 20) {
                        WeatherDetailCard(
                            icon: "sun.max.fill",
                            title: "紫外线指数",
                            value: "\(Int(weather.current.uv))"
                        )

                        WeatherDetailCard(
                            icon: "thermometer",
                            title: "华氏温度",
                            value: "\(Int(weather.current.tempF))°F"
                        )
                    }
                }
                .padding()

                // 更新时间
                Text("更新时间: \(weather.location.localtime)")
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.6))
                    .padding(.bottom)
            }
        }
    }
}

// MARK: - Weather Detail Card
struct WeatherDetailCard: View {
    let icon: String
    let title: String
    let value: String

    var body: some View {
        VStack(spacing: 10) {
            Image(systemName: icon)
                .font(.system(size: 30))
                .foregroundColor(.white)

            Text(title)
                .font(.caption)
                .foregroundColor(.white.opacity(0.8))

            Text(value)
                .font(.headline)
                .foregroundColor(.white)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.white.opacity(0.2))
        .cornerRadius(15)
    }
}

#Preview {
    WeatherView(weather: WeatherResponse.preview)
        .background(
            LinearGradient(
                gradient: Gradient(colors: [Color.blue.opacity(0.6), Color.purple.opacity(0.4)]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
}
