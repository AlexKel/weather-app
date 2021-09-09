//
//  DailyForecast.swift
//  Weather App
//
//  Created by Aleksandr Kelbas on 09/09/2021.
//

import Foundation

struct Forecast: Codable {
    var daily: [DailyForecast]
}

struct DailyForecast: Codable {
    var date: Date
    var tempMin: Double
    var tempMax: Double
    var condition: String
}

extension DailyForecast {
    private enum RootKeys: String, CodingKey {
        case date = "dt"
        case temp, weather
    }
    
    private enum TemperatureKeys: String, CodingKey {
        case tempMin = "min"
        case tempMax = "max"
    }
    
    private enum WeatherKeys: String, CodingKey {
        case condition = "main"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: RootKeys.self)
        date = try container.decode(Date.self, forKey: .date)
        
        let tempContainer = try container.nestedContainer(keyedBy: TemperatureKeys.self, forKey: .temp)
        tempMin = try tempContainer.decode(Double.self, forKey: .tempMin)
        tempMax = try tempContainer.decode(Double.self, forKey: .tempMax)
        
        var allWeatherConditions: [String] = []
        var weatherContainer = try container.nestedUnkeyedContainer(forKey: .weather)
        while !weatherContainer.isAtEnd {
            let conditionsContainer = try weatherContainer.nestedContainer(keyedBy: WeatherKeys.self)
            let condition = try conditionsContainer.decode(String.self, forKey: .condition)
            allWeatherConditions.append(condition)
        }
        condition = allWeatherConditions.joined(separator: ", ")
    }
}
