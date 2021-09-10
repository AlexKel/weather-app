//
//  ForecastDetailsViewModel.swift
//  Weather App
//
//  Created by Aleksandr Kelbas on 10/09/2021.
//

import Foundation
import Combine

class ForecastDetailsViewModel {
    private let client: APIClient
    private let store: CitiesStore
    private let city: City
    private var forecast: [DailyForecast] = []
    private var currentWeather: Weather?
    private var disposables = Set<AnyCancellable>()
    @Published var loading = true
    
    init(city: City, client: APIClient, store: CitiesStore) {
        self.city = city
        self.client = client
        self.store = store
        load()
    }
    
    var cityName: String { return city.name }
    var currentTemperature: String {
        guard let w = currentWeather else {
            return "-"
        }
        return String(format: "%.0f°", w.temp)
    }
    
}

//MARK: - List
extension ForecastDetailsViewModel: ListViewModel {
    var numberOfSections: Int { return 1 }
    func numberOfRows(in section: Int) -> Int {
        return forecast.count
    }
    
    func cellViewModel(for indexPath: IndexPath) -> ForecastCellViewModel? {
        if let dayForecast = dataAt(indexPath: indexPath) {
            return ForecastCellViewModel(forecast: dayForecast)
        }
        
        return nil
    }
    
    
    func dataAt(indexPath: IndexPath) -> DailyForecast? {
        guard indexPath.row < forecast.count else {
            return nil
        }
        
        return forecast[indexPath.row]
    }
}

//MARK: - Data loading
extension ForecastDetailsViewModel: Loadable {
    func load() {
        loadCurrentWeather()
        loadForecast()
    }
    
    private func loadCurrentWeather() {
       client.publisher(for: Endpoint.currentWeather(cityId: city.id), decoder: JSONWeatherDecoder()).sink {
            completion in
            switch completion {
            case .finished: break
            case .failure(let error):
                // TODO: Handle error
                print("Failed to load current weather: \(error)")
                
            }
        } receiveValue: { [weak self] weather in
            self?.currentWeather = weather
        }.store(in: &disposables)
        
    }
    
    private func loadForecast() {
        client.publisher(for: Endpoint.forecast(city: city), decoder: JSONForecastDecoder()).sink {
            [weak self] completion in
            switch completion {
            case .finished: break
            case .failure(let error):
                // TODO: Handle error
                print("Failed to load forecast: \(error)")
                self?.loading = false
            }
        } receiveValue: { [weak self] forecast in
            self?.forecast = forecast
            self?.loading = false
        }.store(in: &disposables)
    }
}
