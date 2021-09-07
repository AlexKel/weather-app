//
//  Endpoint.swift
//  Weather App
//
//  Created by Aleksandr Kelbas on 07/09/2021.
//

import Foundation

protocol APIEndpoint {
    var path: String { get set }
    var queryItems: [URLQueryItem] { get set }
    func createComponents() -> URLComponents
    func createRequest() -> URLRequest?
}

// Default implementation
struct Endpoint<Response: Decodable>: APIEndpoint {
    var path: String
    var queryItems: [URLQueryItem] = []
    private var host: String { return "api.openweathermap.org" }
    private var apiKey: String { return "f12b5684517a0aa2a854cbd4685f6be6" }
    
    func createComponents() -> URLComponents {
        var components = URLComponents()
        components.scheme = "https"
        components.host = host
        components.path = "/data/2.5/\(path)"
        // Combine endpoint query items with default ones
        components.queryItems = queryItems + [URLQueryItem(name: "appid", value: apiKey), URLQueryItem(name: "units", value: "metric")]
        
        return components
    }
    
    func createRequest() -> URLRequest? {
        guard let url = createComponents().url else {
            return nil
        }
        return URLRequest(url: url)
    }
}

extension Endpoint where Response == Weather {
    static func currentWeather(cityId: Int) -> Self {
        return Endpoint(path: "weather", queryItems: [URLQueryItem(name: "id", value: "\(cityId)")])
    }
}


