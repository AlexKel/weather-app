//
//  CityDecoderTests.swift
//  Weather AppTests
//
//  Created by Aleksandr Kelbas on 06/09/2021.
//

import XCTest

class CityDecoderTests: XCTestCase {

    func testCityDataDecoding() throws {
        guard let url = Bundle(for: CityDecoderTests.self).url(forResource: "sample_cities", withExtension: "json"),
              let data = try? Data(contentsOf: url) else {
            fatalError("Cannot load resource from bundle")
        }
        
        do {
            let cities = try JSONCityDecoder().decode(from: data)
            XCTAssertEqual(cities.count, 3)
            for i in 0..<3 {
                XCTAssertEqual(cities[i].id, i+1)
                XCTAssertEqual(cities[i].name, "City\(i+1)")
                XCTAssertEqual(cities[i].country, "\(i+1)")
            }
        } catch {
            XCTFail(String(describing: error))
        }
    }
}
