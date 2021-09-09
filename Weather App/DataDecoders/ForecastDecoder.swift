//
//  ForecastDecoder.swift
//  Weather App
//
//  Created by Aleksandr Kelbas on 09/09/2021.
//

import Foundation

protocol ForecastDecoder: DataDecoder where Result == [DailyForecast] {}

/// Decodes 7 day forecast into `DailyForecast` array
struct JSONForecastDecoder: ForecastDecoder {
    func decode(from data: Data) throws -> [DailyForecast] {
        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .secondsSince1970
            let result = try decoder.decode(Forecast.self, from: data)
            return result.daily
        } catch {
            throw error
        }
    }
}
