//
//  CitiesStore.swift
//  Weather App
//
//  Created by Aleksandr Kelbas on 05/09/2021.
//

import Foundation


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
}

/// Loads cities from a local json file using intialised decoder and data url
class LocalCitiesStore: CitiesStore {
    private let cache: CitiesCache
    private let userDefaults = UserDefaults(suiteName: "cities")
    private let defaultsKey = "cities.store.favourites"
    
    
    /// Initialises cities store
    /// - Parameters:
    ///   - decoder: City data type decoder
    ///   - url: URL to a local json file with cities
    init<T: CityDecoder>(decoder: T, url: URL) {
        let data = try! Data(contentsOf: url)
        let allCities = try! decoder.decode(from: data)
        cache = CitiesCache(allCities: allCities)
    }
    
    
    /// Returns all cities
    /// - Returns: Cities array
    func getAllCities() -> [City] {
        return cache.allCities
    }
    
    
    /// Stores city id as a reference
    /// - Parameter city: your favourite city
    func addFavourite(city: City) {
        var favourites = userDefaults?.object(forKey: defaultsKey) as? [Int] ?? []
        favourites.append(city.id)
        userDefaults?.setValue(favourites, forKey: defaultsKey)
    }
    
    
    /// Removes city id reference from favourites
    /// - Parameter city: city to remove
    func removeFavourite(city: City) {
        var favourites = userDefaults?.object(forKey: defaultsKey) as? [Int] ?? []
        favourites.removeAll { $0 == city.id }
        userDefaults?.setValue(favourites, forKey: defaultsKey)
    }
    
    
    /// List of favourite cities
    /// - Returns: array of favourite cities
    func getFavouriteCities() -> [City] {
        let favourites = userDefaults?.object(forKey: defaultsKey) as? [Int] ?? []
        let cities = cache.allCities.filter { favourites.contains($0.id) }
        return cities
    }
}
