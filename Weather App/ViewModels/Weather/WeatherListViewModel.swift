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
    var numberOfRows: Int { return cities.count }
    
    func cellViewModel(for indexPath: IndexPath) -> CityWeatherCellViewModel? {
        if let weather = dataAt(indexPath: indexPath) {
            return CityWeatherCellViewModel(weather: weather)
        }
        return nil
    }
    
    func dataAt(indexPath: IndexPath) -> Weather? {
        guard indexPath.row < weather.count else {
            return nil
        }
        
        return weather[indexPath.row]
    }
    
}
