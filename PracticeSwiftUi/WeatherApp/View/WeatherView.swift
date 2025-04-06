//
//  WeatherView.swift
//  PracticeSwiftUi
//
//  Created by 심연아 on 4/7/25.
//

import SwiftUI
import CoreLocation

struct WeatherView: View {
    @StateObject private var locationManager = LocationManager()
    @State private var weatherData: WeatherData? = nil

    var body: some View {
        ZStack {
                // 배경
                LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.6), Color.purple.opacity(0.6)]),
                               startPoint: .topLeading,
                               endPoint: .bottomTrailing)
                    .ignoresSafeArea()

                // 카드 뷰
                VStack(spacing: 16) {
                    if let weatherData = weatherData {
                        // 온도 + 아이콘
                        VStack(spacing: 4) {
                            Image(systemName: iconName(for: weatherData.condition))
                                .resizable()
                                .scaledToFit()
                                .frame(width: 60, height: 60)
                                .foregroundColor(.white)

                            Text("\(Int(weatherData.temperature))°C")
                                .font(.system(size: 64, weight: .semibold))
                                .foregroundColor(.white)
                        }

                        // 위치 및 상태
                        VStack(spacing: 2) {
                            Text(weatherData.locationName)
                                .font(.title2)
                                .bold()
                                .foregroundColor(.white)
                            
                            Text(weatherData.condition.capitalized)
                                .font(.body)
                                .foregroundColor(.white.opacity(0.8))
                        }

                        Spacer()

                        // 하단 태그
                        Text("CodeLab")
                            .font(.footnote)
                            .foregroundColor(.white.opacity(0.6))
                    } else {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    }
                }
                .padding()
                .frame(maxWidth: 320, maxHeight: 380)
                .background(.ultraThinMaterial)
                .cornerRadius(25)
                .padding()
            }
            .onAppear {
                locationManager.requestLocation()
            }
            .onReceive(locationManager.$location) { location in
                guard let location = location else { return }
                fetchWeatherData(for: location)
            }
        }
    func iconName(for condition: String) -> String {
        let lowercased = condition.lowercased()
        if lowercased.contains("cloud") {
            return "cloud.fill"
        } else if lowercased.contains("rain") {
            return "cloud.rain.fill"
        } else if lowercased.contains("clear") {
            return "sun.max.fill"
        } else if lowercased.contains("snow") {
            return "snow"
        } else {
            return "cloud.sun.fill"
        }
    }

    private func fetchWeatherData(for location: CLLocation) {
        let apiKey = "29f96e59a94e30470c855b6c6d9e17e5"
        let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(location.coordinate.latitude)&lon=\(location.coordinate.longitude)&appid=\(apiKey)&units=metric"
        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else { return }

            do {
                let decoder = JSONDecoder()
                let weatherResponse = try decoder.decode(WeatherResponse.self, from: data)

                DispatchQueue.main.async {
                    weatherData = WeatherData(
                        locationName: weatherResponse.name,
                        temperature: weatherResponse.main.temp,
                        condition: weatherResponse.weather.first?.description ?? ""
                    )
                }
            } catch {
                print("Decoding error: \(error)")
            }
        }.resume()
    }
}


//#Preview {
//    WeatherView()
//}
