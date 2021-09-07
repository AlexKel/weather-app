//
//  WeatherDecoderTests.swift
//  Weather AppTests
//
//  Created by Aleksandr Kelbas on 07/09/2021.
//

import XCTest

class WeatherDecoderTests: XCTestCase {

    func testWeatherDataDecodingOneCondition() throws {
        guard let url = Bundle(for: CityDecoderTests.self).url(forResource: "sample_weather", withExtension: "json"),
              let data = try? Data(contentsOf: url) else {
            fatalError("Cannot load resource from bundle")
        }
        
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
        guard let url = Bundle(for: CityDecoderTests.self).url(forResource: "sample_weather_2", withExtension: "json"),
              let data = try? Data(contentsOf: url) else {
            fatalError("Cannot load resource from bundle")
        }
        
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
