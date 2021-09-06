//
//  DataDecoder.swift
//  Weather App
//
//  Created by Aleksandr Kelbas on 06/09/2021.
//

import Foundation

/// General data decoder protocol
protocol DataDecoder {
    associatedtype Result
    func decode(from data: Data) throws -> Result
}
