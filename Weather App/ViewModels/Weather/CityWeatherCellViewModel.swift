//
//  CityCellViewModel.swift
//  Weather App
//
//  Created by Aleksandr Kelbas on 07/09/2021.
//

import Foundation
import Combine


class CityWeatherCellViewModel: CellViewModel {
    
    private let city: City
    private var weather: Weather?
    private let client: APIClient
    private var disposables = Set<AnyCancellable>()
    
    init(city: City, client: APIClient) {
        self.city = city
        self.client = client
        load()
    }
    
    @Published var loading: Bool = true
    
    var name: String { return city.name }
    var temp: String { return tempString(value: weather?.temp) }
    var tempMin: String { return loading ? "" : "L:\(tempString(value: weather?.tempMin))" }
    var tempMax: String { return loading ? "" : "H:\(tempString(value: weather?.tempMax))" }
    var condition: String { return weather?.condition ?? "" }
    
    private func tempString(value: Double?) -> String {
        guard let val = value else {
            return ""
        }
        return String(format: "%.0f°", round(val))
    }
    
    
    
    func load() {
        client.publisher(for: Endpoint.currentWeather(cityId: city.id), decoder: JSONWeatherDecoder()).sink {
            [weak self] completion in
            switch completion {
            case .finished: break
            case .failure(let error):
                // TODO: Handle error
                print("Failed to load: \(error)")
                self?.loading = false
            }
        } receiveValue: { [weak self] weather in
            self?.weather = weather
            self?.loading = false
        }.store(in: &disposables)
    }
}
