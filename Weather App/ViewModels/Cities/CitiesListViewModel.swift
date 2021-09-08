//
//  CitiesListViewModel.swift
//  Weather App
//
//  Created by Aleksandr Kelbas on 06/09/2021.
//

import Foundation

class CitiesListViewModel: ListViewModel {
    private let store: CitiesStore
    var cities: [City] = []
    
    init(store: CitiesStore) {
        self.store = store
        cities = store.getAllCities()
    }
    
    var numberOfSections: Int { return 1 }
    
    var numberOfRows: Int { return cities.count }
    
    func cellViewModel(for indexPath: IndexPath) -> CityCellViewModel? {
        if let city = dataAt(indexPath: indexPath) {
            return CityCellViewModel(city: city)
        }
        
        return nil
    }
    
    func filter(text: String) {
        if text.isEmpty {
            cities = store.getAllCities()
        } else {
            cities = store.getAllCities().filter { city -> Bool in
                return city.name.lowercased().contains(text.lowercased())
            }
        }
    }
    
    func dataAt(indexPath: IndexPath) -> City? {
        guard indexPath.row < cities.count else {
            return nil
        }
        
        return cities[indexPath.row]
    }
        
}
