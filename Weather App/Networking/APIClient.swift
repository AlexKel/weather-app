//
//  APIClient.swift
//  Weather App
//
//  Created by Aleksandr Kelbas on 07/09/2021.
//

import Foundation
import Combine

enum NetworkError: Error {
    case badRequest
    case badStatusCode(Int)
    case badResponse
    case other(Error)
    
    static func map(_ error: Error) -> NetworkError {
        return (error as? NetworkError) ?? .other(error)
    }
}

protocol APIClient {
    func publisher<E: APIEndpoint, D: DataDecoder>(for endpoint: E, decoder: D) -> AnyPublisher<D.Result, NetworkError>
}

extension URLSession: APIClient {
    func publisher<E: APIEndpoint, D: DataDecoder>(
        for endpoint: E,
        decoder: D
    ) -> AnyPublisher<D.Result, NetworkError> {
        guard let request = endpoint.createRequest() else {
            return Fail(error: NetworkError.badRequest).eraseToAnyPublisher()
        }
        
        return dataTaskPublisher(for: request)
            .tryMap { response -> Data in
                guard let httpResponse = response.response as? HTTPURLResponse else {
                    throw NetworkError.badResponse
                }
                
                let statusCode = httpResponse.statusCode
                
                guard (200...299).contains(statusCode) else {
                    throw NetworkError.badStatusCode(statusCode)
                }

                return response.data
            }
            .tryMap { data -> D.Result in
                do {
                    let result = try decoder.decode(from: data)
                    return result
                } catch {
                    throw NetworkError.other(error)
                }
            }
            .mapError { NetworkError.map($0) }
            .eraseToAnyPublisher()
    }
}

