//
//  CityCellViewModelTests.swift
//  Weather AppTests
//
//  Created by Aleksandr Kelbas on 08/09/2021.
//

import XCTest

class CityCellViewModelTests: XCTestCase {

    func testCityCellViewModel() throws {
        let city = City(id: 1, name: "London", state: "", country: "UK", coord: Coordinate(lon: 1, lat: 2))
        
        let vm = CityCellViewModel(city: city)
        XCTAssertEqual(vm.name, "London")
    }
}
