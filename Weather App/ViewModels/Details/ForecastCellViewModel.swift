//
//  ForecastCellViewModel.swift
//  Weather App
//
//  Created by Aleksandr Kelbas on 10/09/2021.
//

import Foundation

/// View model for daily forcast data
class ForecastCellViewModel: CellViewModel {
    private let forecast: DailyForecast
    
    init(forecast: DailyForecast) {
        self.forecast = forecast
    }
    
    /// Returns either "Today" or a weekday
    var title: String {
        if Calendar.current.isDateInToday(forecast.date) {
            return "Today"
        }
        return Calendar.current.weekdaySymbols[Calendar.current.component(.weekday, from: forecast.date)-1]
    }
    
    var temperature: String {
        return String(format: "%.0f° - %.0f°", forecast.tempMin, forecast.tempMax)
    }
    
    var condition: String { return forecast.condition }
}
