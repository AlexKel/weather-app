//
//  CityWeatherCellViewModelTests.swift
//  Weather AppTests
//
//  Created by Aleksandr Kelbas on 07/09/2021.
//

import XCTest
import Combine

class CityWeatherCellViewModelTests: XCTestCase {

    func testCityWeatherCellViewModel() throws {
        let city = City(id: 1, name: "London", state: "", country: "UK", coord: Coordinate(lon: 1, lat: 1))
        let data = Helper.loadFile(named: "sample_weather")
        let client = MockAPIClient(data: [Endpoint.currentWeather(cityId: city.id).path : data])
        let vm = CityWeatherCellViewModel(city: city, client: client)
        XCTAssertEqual(vm.name, "London")
        XCTAssertEqual(vm.temp, "20°")
        XCTAssertEqual(vm.tempMax, "H:21°")
        XCTAssertEqual(vm.tempMin, "L:17°")
        XCTAssertEqual(vm.condition, "Clouds")
    }

}
