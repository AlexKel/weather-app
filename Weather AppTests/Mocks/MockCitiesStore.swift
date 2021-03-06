//
//  MockCitiesStore.swift
//  Weather App
//
//  Created by Aleksandr Kelbas on 10/09/2021.
//

import Foundation
import Combine

class MockCitiesStore: CitiesStore {
    
    @Published private var cities: [City]
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
    
    var favouriteCititiesPublisher: AnyPublisher<[City], Never> {
        return $cities.eraseToAnyPublisher()
    }
}
