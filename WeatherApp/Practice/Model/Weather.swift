//
//  Stock.swift
//  Practice
//
//  Created by iYezan on 02/05/2021.
//

import Foundation


struct WeatherData: Decodable, Identifiable {
    
    let main: Weather
    
    var id: Int
    var name: String
}

struct  Weather: Decodable {
    var temp: Double?
    var humidity: Double?
}
