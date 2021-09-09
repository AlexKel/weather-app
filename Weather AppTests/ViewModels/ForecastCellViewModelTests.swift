//
//  ForecastCellViewModelTests.swift
//  Weather AppTests
//
//  Created by Aleksandr Kelbas on 09/09/2021.
//

import XCTest

class ForecastCellViewModelTests: XCTestCase {

    func testForecastCellViewModel() throws {
        let forecast = DailyForecast(date: Date(), tempMin: 11.2, tempMax: 13.5, condition: "Cool")
        let vm = ForecastCellViewModel(forecast: forecast)
        
        XCTAssertEqual(vm.title, "Today")
        XCTAssertEqual(vm.temperature, "11° - 14°")
        XCTAssertEqual(vm.condition, "Cool")
    }

}
