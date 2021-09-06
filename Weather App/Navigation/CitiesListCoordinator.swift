//
//  CitiesListCoordinator.swift
//  Weather App
//
//  Created by Aleksandr Kelbas on 05/09/2021.
//

import UIKit

/// Navigation coordinator for a cities list view controller
class CitiesListCoordinator: Coordinator {
    private let presenter: UINavigationController
    private var citiesListViewController: CitiesListViewController?
    private let store: CitiesStore
    
    init(presenter: UINavigationController, store: CitiesStore) {
        self.presenter = presenter
        self.store = store
    }
    
    func start() {
        let citiesListViewController = CitiesListViewController(nibName: nil, bundle: nil)
        citiesListViewController.title = "Cities"
        presenter.pushViewController(citiesListViewController, animated: true)
        self.citiesListViewController = citiesListViewController
    }
}
