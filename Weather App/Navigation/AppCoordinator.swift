//
//  AppCoordinator.swift
//  Weather App
//
//  Created by Aleksandr Kelbas on 05/09/2021.
//

import UIKit

/// Root app navigation coordinator
class AppCoordinator: Coordinator {
    
    // Root view controller
    let window: UIWindow
    let rootViewController: UINavigationController
    let citiesStore: CitiesStore
    let client: APIClient
    let weatherListCoordinator: WeatherListCoordinator
    
    
    init(window: UIWindow, store: CitiesStore, client: APIClient) {
        self.window = window
        citiesStore = store
        self.client = client
        rootViewController = UINavigationController()
        rootViewController.navigationBar.prefersLargeTitles = true
        weatherListCoordinator = WeatherListCoordinator(presenter: rootViewController, store: citiesStore, client: client)
    }
    
    func start() {
        window.rootViewController = rootViewController
        weatherListCoordinator.start()
        window.makeKeyAndVisible()
    }

}
