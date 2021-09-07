//
//  CityCellViewModel.swift
//  Weather App
//
//  Created by Aleksandr Kelbas on 07/09/2021.
//

import Foundation

class CityWeatherCellViewModel: CellViewModel {
    private let weather: Weather
    
    init(weather: Weather) {
        self.weather = weather
    }
    
    var name: String { return weather.name }
    var temp: String { return tempString(value: weather.temp) }
    var tempMin: String { return "L:\(tempString(value: weather.tempMin))" }
    var tempMax: String { return "H:\(tempString(value: weather.tempMax))" }
    var condition: String { return weather.condition }
    
    private func tempString(value: Double) -> String {
        return String(format: "%.0f°", round(value))
    }
}
