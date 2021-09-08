//
//  CitiesListViewModelTests.swift
//  Weather AppTests
//
//  Created by Aleksandr Kelbas on 08/09/2021.
//

import XCTest

class MockCitiesStore: CitiesStore {
    
    private let cities: [City]
    private var favs: [City] = []
    
    init(cities: [City]) {
        self.cities = cities
    }
    
    func getAllCities() -> [City] {
        return cities
    }
    
    func addFavourite(city: City) {
        guard (!favs.contains { $0.id == city.id }) else { return }
        favs.append(city)
    }
    
    func removeFavourite(city: City) {
        favs.removeAll { $0.id == city.id }
    }
    
    func getFavouriteCities() -> [City] {
        return favs
    }
}

class CitiesListViewModelTests: XCTestCase {

    static var store: MockCitiesStore?
    static var viewModel: CitiesListViewModel?
    var viewModel: CitiesListViewModel? {
        return CitiesListViewModelTests.viewModel
    }

    override class func setUp() {
        super.setUp()
        guard let url = Bundle(for: CityDecoderTests.self).url(forResource: "sample_cities", withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let cities = try? JSONCityDecoder().decode(from: data) else {
            fatalError("Cannot find test resource")
        }
        
        store = MockCitiesStore(cities: cities)
        viewModel = CitiesListViewModel(store: store!)
    }
    
    

    func testTableDelegateFunctions() throws {
        XCTAssertEqual(viewModel?.numberOfSections, 1)
        XCTAssertEqual(viewModel?.numberOfRows, 3)
    }
    
    func testReturnsCorrectCityForIndexPath() throws {
        let city = viewModel?.dataAt(indexPath: IndexPath(row: 1, section: 1))
        XCTAssertEqual(city?.id, 2)
        XCTAssertEqual(city?.name, "City2")
    }
   
    func testCitiesFilterFunction() throws {
        viewModel?.filter(text: "2")
        XCTAssertEqual(viewModel?.numberOfRows, 1)
        XCTAssertEqual(viewModel?.dataAt(indexPath: IndexPath(row: 0, section: 1))?.id, 2)
        
        viewModel?.filter(text: "")
        XCTAssertEqual(viewModel?.numberOfRows, 3)
    }

    func testReturnsCorrectViewModel() throws {
        let cellVM = viewModel?.cellViewModel(for: IndexPath(row: 1, section: 1))
        XCTAssertEqual(cellVM?.name, "City2, 2")
    }
}
