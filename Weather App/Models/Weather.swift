//
//  Weather.swift
//  Weather App
//
//  Created by Aleksandr Kelbas on 07/09/2021.
//

import Foundation


struct Weather: Codable, Identifiable {
    var id: Int
    var name: String
    var condition: String
    var temp: Double
    var tempMin: Double
    var tempMax: Double
}

extension Weather {
    
    private enum RootKeys: String, CodingKey {
        case id, name, weather, main
    }
    
    private enum WeatherKeys: String, CodingKey {
        case condition = "main"
    }
    
    private enum TemperatureKeys: String, CodingKey {
        case temp
        case tempMin = "temp_min"
        case tempMax = "temp_max"
    }
  
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: RootKeys.self)
        
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        
        var allWeatherConditions: [String] = []
        var weatherContainer = try container.nestedUnkeyedContainer(forKey: .weather)
        while !weatherContainer.isAtEnd {
            let conditionsContainer = try weatherContainer.nestedContainer(keyedBy: WeatherKeys.self)
            let condition = try conditionsContainer.decode(String.self, forKey: .condition)
            allWeatherConditions.append(condition)
        }
        condition = allWeatherConditions.joined(separator: ", ")
        
        let tempContainer = try container.nestedContainer(keyedBy: TemperatureKeys.self, forKey: .main)
        temp = try tempContainer.decode(Double.self, forKey: .temp)
        tempMin = try tempContainer.decode(Double.self, forKey: .tempMin)
        tempMax = try tempContainer.decode(Double.self, forKey: .tempMax)
    }
}
