//
//  WeatheViewModel.swift
//  Practice
//
//  Created by iYezan on 04/05/2021.
//

import Foundation
import Combine

class WeatherVM: ObservableObject {
    private var networkManager: NetworkManager!
    
    @Published var weather = Weather()
    
    init() {
        self.networkManager = NetworkManager()
    }
    
    var temprature: String {
        if let temp = self.weather.temp {
            return String(format: "%.0f", temp)
        } else {
            return ""
        }
    }
    var humidity: String {
        if let humidity = self.weather.humidity {
            return String(format: "%.0f", humidity)
        } else {
            return ""
        }
    }
    
    // for search TextField
    var cityName: String = ""
    
    func search() {
        if let city = self.cityName.addingPercentEncoding(withAllowedCharacters: .urlUserAllowed) {
            fetchWeather(by: city)
        }
    }
    
    private func fetchWeather(by city: String) {
        self.networkManager.getWeather(city: city) { weather in
            if let weather = weather {
                DispatchQueue.main.async {
                    self.weather = weather
                }
            }
        }
    }
    
}
