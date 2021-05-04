//
//  NetworkManager.swift
//  Practice
//
//  Created by iYezan on 02/05/2021.
//

import Foundation

class NetworkManager: ObservableObject {
    
    // WeatherData Identifiable
    @Published var weatherData = [WeatherData]()
    
    private let baseURL = "https://api.openweathermap.org/data/2.5/weather?q="
    let cities = ["London", "Mombasa", "Dublin", "Dubai", "Egypt", "Aden"]
    private let api = "&appid="+"{ API key }" // get your API key from openweathermap
    
    init() {
        for city in self.cities {
            self.load(self.baseURL+city+self.api)
        }
    }
    
    func load(_ urlString: String) {
        if let url = URL(string: urlString) {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                do {
                    if let d = data {
                        let decodedLists = try JSONDecoder().decode(WeatherData.self, from: d)
                        DispatchQueue.main.async {
                            self.weatherData.append(decodedLists)
                        }
                    } else {
                        print("No Data")
                    }
                } catch {
                    print("Error")
                }
                
            }.resume()
        } else {
            print("Unable to decode URL")
        }
    }
}

extension NetworkManager {
    
    func getWeather(city: String, completion: @escaping (Weather?) -> ()) {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid={ API key }&units=metric") else {
            completion(nil)
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            
            let weatherData = try? JSONDecoder().decode(WeatherData.self, from: data)
            if let weatherData = weatherData {
                let weather = weatherData.main
                completion(weather)
            } else {
                completion(nil)
            }
        }.resume()
    }
}
