//
//  ForecastDecoderTests.swift
//  Weather AppTests
//
//  Created by Aleksandr Kelbas on 09/09/2021.
//

import XCTest

class ForecastDecoderTests: XCTestCase {

    func testForecastDataDecoding() throws {
        let data = Helper.loadFile(named: "sample_forecast")
        
        do {
            let forecast = try JSONForecastDecoder().decode(from: data)
            XCTAssertEqual(forecast.count, 8)
            XCTAssertEqual(forecast.first?.date.timeIntervalSince1970, 1631260800)
            XCTAssertEqual(forecast.first?.tempMin, 25.8)
            XCTAssertEqual(forecast.first?.tempMax, 26.33)
            XCTAssertEqual(forecast.first?.condition, "Rain")
            XCTAssertEqual(forecast.last?.date.timeIntervalSince1970, 1631865600)
            XCTAssertEqual(forecast.last?.tempMin, 26.15)
            XCTAssertEqual(forecast.last?.tempMax, 26.45)
            XCTAssertEqual(forecast.last?.condition, "Rain")
        } catch {
            XCTFail(String(describing: error))
        }
    }
    
}
