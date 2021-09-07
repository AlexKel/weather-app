//
//  APIIntegrationTests.swift
//  Weather AppTests
//
//  Created by Aleksandr Kelbas on 07/09/2021.
//

import XCTest

class APIIntegrationTests: XCTestCase {

    func testWeatherResponseCorrectness() throws {
        let client = URLSession.shared
        
        let expectation = self.expectation(description: "Current weather fetched correctly")
        
        let requestCancellable = client.publisher(for: Endpoint.currentWeather(cityId: 2643743), decoder: JSONWeatherDecoder()).receive(on: DispatchQueue.main).sink { completion in
            switch completion {
            case .finished: break
            case .failure(let error):
                XCTFail(String(describing: error))
            }
        } receiveValue: { weather in
            
            XCTAssertEqual(weather.name, "London")
            XCTAssertEqual(weather.id, 2643743)
            
            expectation.fulfill()
        }
        
        
        waitForExpectations(timeout: 5) { (error) in
            requestCancellable.cancel()
            XCTAssert(error == nil, error?.localizedDescription ?? "Expectation failed")
        }
    }

            
}
