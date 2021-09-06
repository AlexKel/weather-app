//
//  City.swift
//  Weather App
//
//  Created by Aleksandr Kelbas on 05/09/2021.
//

import Foundation

struct City: Codable, Identifiable {
    var id: Int
    var name: String
    var state: String
    var country: String
    var coord: Coordinate
}

struct Coordinate: Codable {
    var lon: Double
    var lat: Double
}

