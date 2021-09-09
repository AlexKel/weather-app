//
//  WeatherDecoderTests.swift
//  Weather AppTests
//
//  Created by Aleksandr Kelbas on 07/09/2021.
//

import XCTest

class WeatherDecoderTests: XCTestCase {

    func testWeatherDataDecodingOneCondition() throws {
        let data = Helper.loadFile(named: "sample_weather")
        
        do {
            let weather = try JSONWeatherDecoder().decode(from: data)
            XCTAssertEqual(weather.name, "London")
            XCTAssertEqual(weather.id, 2643743)
            XCTAssertEqual(weather.condition, "Clouds")
            XCTAssertEqual(weather.temp, 19.5)
            XCTAssertEqual(weather.tempMax, 21.16)
            XCTAssertEqual(weather.tempMin, 16.88)
        } catch {
            XCTFail(String(describing: error))
        }
    }
    
    func testWeatherDataDecodingMultipleConditions() throws {
        let data = Helper.loadFile(named: "sample_weather_2")
        
        do {
            let weather = try JSONWeatherDecoder().decode(from: data)
            XCTAssertEqual(weather.name, "London")
            XCTAssertEqual(weather.id, 2643743)
            XCTAssertEqual(weather.condition, "Clouds, Rain")
            XCTAssertEqual(weather.temp, 19.5)
            XCTAssertEqual(weather.tempMax, 21.16)
            XCTAssertEqual(weather.tempMin, 16.88)
        } catch {
            XCTFail(String(describing: error))
        }
    }
}
