//
//  WeatherDecoder.swift
//  Weather App
//
//  Created by Aleksandr Kelbas on 07/09/2021.
//

import Foundation

protocol WeatherDecoder: DataDecoder where Result == Weather {}

struct JSONWeatherDecoder: WeatherDecoder {
    func decode(from data: Data) throws -> Weather {
        do {
            let result = try JSONDecoder().decode(Weather.self, from: data)
            return result
        } catch {
            throw error
        }
    }
}
