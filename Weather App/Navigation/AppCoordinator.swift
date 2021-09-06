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
    let citiesListCoordinator: CitiesListCoordinator
    
    
    init(window: UIWindow, store: CitiesStore) {
        self.window = window
        citiesStore = store
        rootViewController = UINavigationController()
        rootViewController.navigationBar.prefersLargeTitles = true
        citiesListCoordinator = CitiesListCoordinator(presenter: rootViewController, store: citiesStore)
    }
    
    func start() {
        window.rootViewController = rootViewController
        citiesListCoordinator.start()
        window.makeKeyAndVisible()
    }

}
