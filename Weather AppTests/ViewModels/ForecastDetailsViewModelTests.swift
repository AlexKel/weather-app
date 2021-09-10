//
//  ForecastDetailsViewModelTests.swift
//  Weather AppTests
//
//  Created by Aleksandr Kelbas on 10/09/2021.
//

import XCTest

class ForecastDetailsViewModelTests: XCTestCase {
    var city: City!
    var store: MockCitiesStore!
    
    override func setUp() {
        city = City(id: 1, name: "London", state: "", country: "UK", coord: Coordinate(lon: 1, lat: 1))
        store = MockCitiesStore(cities: [city])
    }
    
    func testForecastDetailsViewModel() throws {
        let currentWeather = Helper.loadFile(named: "sample_weather")
        let forecast = Helper.loadFile(named: "sample_forecast")
        
        let client = MockAPIClient(data: [
            Endpoint.currentWeather(cityId: city.id).path: currentWeather,
            Endpoint.forecast(city: city).path: forecast
        ])
        
        let firstForecastIsToday = Calendar.current.isDateInToday(Date(timeIntervalSince1970: 1631260800))
        
        let vm = ForecastDetailsViewModel(city: city, client: client, store: store)
        
        XCTAssertEqual(vm.cityName, "London")
        XCTAssertEqual(vm.currentTemperature, "20°")
        
        XCTAssertEqual(vm.numberOfSections, 1)
        XCTAssertEqual(vm.numberOfRows(in: 0), 8)
        let cellVM = vm.cellViewModel(for: IndexPath(row: 0, section: 0))
        XCTAssertNotNil(cellVM)
        XCTAssertEqual(cellVM?.title, firstForecastIsToday ? "Today" : "Friday")
        XCTAssertEqual(cellVM?.temperature, "26° - 26°")
        XCTAssertEqual(cellVM?.condition, "Rain")
    }
    
}
