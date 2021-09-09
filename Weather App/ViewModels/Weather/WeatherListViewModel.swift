//
//  WeatherListViewModel.swift
//  Weather App
//
//  Created by Aleksandr Kelbas on 08/09/2021.
//

import Foundation

class WeatherListViewModel: ListViewModel {
    private let client: APIClient
    private let store: CitiesStore
    private var weather: [Weather] = []
    private var cities: [City] {
        return store.getFavouriteCities()
    }
    
    init(client: APIClient, store: CitiesStore) {
        self.client = client
        self.store = store
    }
    
    
    var numberOfSections: Int { return 1 }
    func numberOfRows(in section: Int) -> Int {
        return cities.count
    }
    
    func cellViewModel(for indexPath: IndexPath) -> CityWeatherCellViewModel? {
        if let city = dataAt(indexPath: indexPath) {
            return CityWeatherCellViewModel(city: city, client: client)
        }
        return nil
    }
    
    func dataAt(indexPath: IndexPath) -> City? {
        guard indexPath.row < cities.count else {
            return nil
        }
        
        return cities[indexPath.row]
    }
    
}
