//
//  ContentView.swift
//  WeatherApp
//
//  Created on 2025-11-17.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = WeatherViewModel()
    @State private var cityName = ""

    var body: some View {
        NavigationView {
            ZStack {
                // 背景渐变
                LinearGradient(
                    gradient: Gradient(colors: [Color.blue.opacity(0.6), Color.purple.opacity(0.4)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()

                VStack(spacing: 20) {
                    // 搜索栏
                    HStack {
                        TextField("输入城市名称", text: $cityName)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.horizontal)

                        Button(action: {
                            Task {
                                await viewModel.fetchWeather(for: cityName)
                            }
                        }) {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.blue)
                                .clipShape(Circle())
                        }
                        .padding(.trailing)
                    }
                    .padding(.top)

                    // 内容区域
                    if viewModel.isLoading {
                        ProgressView("加载中...")
                            .foregroundColor(.white)
                            .padding()
                    } else if let errorMessage = viewModel.errorMessage {
                        VStack {
                            Image(systemName: "exclamationmark.triangle")
                                .font(.system(size: 60))
                                .foregroundColor(.white)
                            Text(errorMessage)
                                .foregroundColor(.white)
                                .padding()
                        }
                    } else if let weather = viewModel.weather {
                        WeatherView(weather: weather)
                    } else {
                        VStack {
                            Image(systemName: "cloud.sun.fill")
                                .font(.system(size: 80))
                                .foregroundColor(.white)
                                .padding()
                            Text("请输入城市名称查询天气")
                                .foregroundColor(.white)
                                .font(.headline)
                        }
                    }

                    Spacer()
                }
            }
            .navigationTitle("天气")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    ContentView()
}
