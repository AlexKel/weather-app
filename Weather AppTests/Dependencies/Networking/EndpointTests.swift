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
    
    func testCurrentWeatherEndpoint() throws {
        let endpoint = Endpoint.currentWeather(cityId: 1)
        let request = endpoint.createRequest()
        XCTAssertNotNil(request)
        XCTAssertEqual(request?.httpMethod, "GET")
        XCTAssertEqual(request?.url?.absoluteString, "https://api.openweathermap.org/data/2.5/weather?id=1&appid=f12b5684517a0aa2a854cbd4685f6be6&units=metric")
    }
    
    
    func testForecastEndpointRequest() throws {
        let city = City(id: 1, name: "London", state: "", country: "UK", coord: Coordinate(lon: 1, lat: 1))
        let endpoint = Endpoint.forecast(city: city)
        let request = endpoint.createRequest()
        XCTAssertNotNil(request)
        XCTAssertEqual(request?.httpMethod, "GET")
        XCTAssertEqual(request?.url?.absoluteString, "https://api.openweathermap.org/data/2.5/onecall?lat=1.0&lon=1.0&exclude=minutely,hourly,alerts,current&appid=f12b5684517a0aa2a854cbd4685f6be6&units=metric")
    }
    
}
