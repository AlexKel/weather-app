//
//  MockAPIClient.swift
//  Weather AppTests
//
//  Created by Aleksandr Kelbas on 09/09/2021.
//

import Foundation
import Combine

struct MockAPIClient : APIClient {
    
    let data: Data
    let statusCode: Int = 200
    
    func publisher<E, D>(for endpoint: E, decoder: D) -> AnyPublisher<D.Result, NetworkError> where E : APIEndpoint, D : DataDecoder {
        guard let result = try? decoder.decode(from: data) else {
            fatalError("Failed to decode")
        }
        
        return Just(result).setFailureType(to: NetworkError.self).eraseToAnyPublisher()
    }
    
}
