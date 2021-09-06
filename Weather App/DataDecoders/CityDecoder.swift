//
//  CityDecoder.swift
//  Weather App
//
//  Created by Aleksandr Kelbas on 06/09/2021.
//

import Foundation

/// Cities decoder protocol, specified result type on DataDecoder
protocol CityDecoder: DataDecoder where Result == [City] {}

/// Decodes city type data using JSONDecoder
struct JSONCityDecoder: CityDecoder {
    func decode(from data: Data) throws -> [City] {
        do {
            let result = try JSONDecoder().decode([City].self, from: data)
            return result
        } catch {
            throw error
        }
    }
}
