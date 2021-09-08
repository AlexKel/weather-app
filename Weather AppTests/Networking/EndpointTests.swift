//
//  EndpointTests.swift
//  Weather AppTests
//
//  Created by Aleksandr Kelbas on 07/09/2021.
//

import XCTest

class EndpointTests: XCTestCase {

    func testEndpointComponents() throws {
        let endpoint = Endpoint<Weather>(path: "weather")
        let comps = endpoint.createComponents()
        XCTAssertEqual(comps.scheme, "https")
        XCTAssertEqual(comps.host, "api.openweathermap.org")
        XCTAssertEqual(comps.path, "/data/2.5/weather")
        XCTAssertEqual(comps.queryItems, [URLQueryItem(name: "appid", value: "f12b5684517a0aa2a854cbd4685f6be6"), URLQueryItem(name: "units", value: "metric")])
        XCTAssertEqual(comps.url?.absoluteString, "https://api.openweathermap.org/data/2.5/weather?appid=f12b5684517a0aa2a854cbd4685f6be6&units=metric")
    }

    func testEndpointRequest() throws {
        let endpoint = Endpoint<Weather>(path: "weather")
        let request = endpoint.createRequest()
        XCTAssertNotNil(request)
        XCTAssertEqual(request?.httpMethod, "GET")
        XCTAssertEqual(request?.url?.absoluteString, "https://api.openweathermap.org/data/2.5/weather?appid=f12b5684517a0aa2a854cbd4685f6be6&units=metric")
    }

}
