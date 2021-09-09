//
//  LocalCitiesStoreTests.swift
//  Weather AppTests
//
//  Created by Aleksandr Kelbas on 06/09/2021.
//

import XCTest

class LocalCitiesStoreTests: XCTestCase {
    
    var store: LocalCitiesStore!
    
    override func setUp() {
        guard store == nil else { return }
        guard let url = Bundle(for: LocalCitiesStoreTests.self).url(forResource: "sample_cities", withExtension: "json") else {
            fatalError("Cannot find test resource")
        }
        
        store = LocalCitiesStore(decoder: JSONCityDecoder(), url: url)
    }

    func testGetAllCitites() throws {
        let cities = store.getAllCities()
        XCTAssertEqual(cities.count, 3)
    }
    
    func testAddFavourite() throws {
        
        var favCities = store.getFavouriteCities()
        XCTAssertEqual(favCities.count, 0)
        
        let favCity = store.getAllCities()[0]
        store.addFavourite(city: favCity)
        favCities = store.getFavouriteCities()
        XCTAssertEqual(favCities.count, 1)
        XCTAssertEqual(favCities[0].name, "City1")
    }
    
    func testRemoveFavourite() throws {
        var favCities = store.getFavouriteCities()
        XCTAssertEqual(favCities.count, 1)
        let favCity = favCities[0]
        
        store.removeFavourite(city: favCity)
        favCities = store.getFavouriteCities()
        XCTAssertEqual(favCities.count, 0)
    }

}
