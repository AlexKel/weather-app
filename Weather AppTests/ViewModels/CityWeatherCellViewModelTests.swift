//
//  CityWeatherCellViewModelTests.swift
//  Weather AppTests
//
//  Created by Aleksandr Kelbas on 07/09/2021.
//

import XCTest

class CityWeatherCellViewModelTests: XCTestCase {

    func testCityWeatherCellViewModel() throws {
        let weather = Weather(id: 1, name: "London", condition: "Cloudy", temp: 19.5, tempMin: 16.88, tempMax: 22.34)
        let vm = CityWeatherCellViewModel(weather: weather)
        XCTAssertEqual(vm.name, "London")
        XCTAssertEqual(vm.temp, "20°")
        XCTAssertEqual(vm.tempMax, "H:22°")
        XCTAssertEqual(vm.tempMin, "L:17°")
        XCTAssertEqual(vm.condition, "Cloudy")
    }

}
