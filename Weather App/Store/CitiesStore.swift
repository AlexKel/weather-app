//
//  CitiesStore.swift
//  Weather App
//
//  Created by Aleksandr Kelbas on 05/09/2021.
//

import Foundation
import Combine

/// Defines a cities store
protocol CitiesStore {
    func getAllCities() -> [City]
    func addFavourite(city: City)
    func removeFavourite(city: City)
    func getFavouriteCities() -> [City]
}

/// Cache for original cities data
struct CitiesCache {
    let allCities: [City]
    var favouriteCities: [City] = []
}

/// Loads cities from a local json file using intialised decoder and data url
class LocalCitiesStore: CitiesStore {
    private var cache: CitiesCache
    private let userDefaults = UserDefaults(suiteName: "cities")
    private let defaultsKey = "cities.store.favourites"
    private var disposables = Set<AnyCancellable>()
    
    /// Initialises cities store
    /// - Parameters:
    ///   - decoder: City data type decoder
    ///   - url: URL to a local json file with cities
    init<T: CityDecoder>(decoder: T, url: URL) {
        let data = try! Data(contentsOf: url)
        let allCities = try! decoder.decode(from: data)
        cache = CitiesCache(allCities: allCities)
        loadFavourites().sink { [weak self] (favs) in
            self?.cache.favouriteCities = favs
        }.store(in: &disposables)
    }
    
    
    /// Returns all cities
    /// - Returns: Cities array
    func getAllCities() -> [City] {
        return cache.allCities
    }
    
    
    /// Stores city id as a reference
    /// - Parameter city: your favourite city
    func addFavourite(city: City) {
        guard !(cache.favouriteCities.contains { $0.id == city.id }) else {
            return
        }
        
        cache.favouriteCities.append(city)
        saveFavourites(favs: cache.favouriteCities).sink { (_) in
            // Saved
        }.store(in: &disposables)
    }
    
    
    /// Removes city id reference from favourites
    /// - Parameter city: city to remove
    func removeFavourite(city: City) {
        cache.favouriteCities.removeAll { $0.id == city.id }
        saveFavourites(favs: cache.favouriteCities).sink { (_) in
            // Saved
        }.store(in: &disposables)
    }
    
    
    /// List of favourite cities
    /// - Returns: array of favourite cities
    func getFavouriteCities() -> [City] {
        return cache.favouriteCities
    }
    
    private func loadFavourites() -> Future<[City], Never> {
        print("Load favs")
        return Future() { [weak self] promise in
            guard let `self` = self else {
                return
            }
            
            let favourites = self.userDefaults?.object(forKey: self.defaultsKey) as? [Int] ?? []
            print("Favourites: ", favourites)
            let cities = self.cache.allCities.filter { favourites.contains($0.id) }
            promise(Result.success((cities)))
        }
    }
    
    private func saveFavourites(favs: [City]) -> Future<Void, Never> {
        return Future() { promise in
            self.userDefaults?.setValue(favs.map{ $0.id }, forKey: self.defaultsKey)
            promise(Result.success(()))
        }
    }
}
