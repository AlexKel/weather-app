//
//  CitiesListCoordinator.swift
//  Weather App
//
//  Created by Aleksandr Kelbas on 05/09/2021.
//

import UIKit

/// Navigation coordinator for a cities list view controller
class WeatherListCoordinator: Coordinator {
    weak var parentCoordinator: Coordinator?
    
    var childCoordinators: [Coordinator] = []
    
    // Presenter and data controller
    private let presenter: UINavigationController
    private let store: CitiesStore
    private let client: APIClient
    
    // View controller
    private var weatherListViewController: WeatherListViewController?
    
    init(presenter: UINavigationController, store: CitiesStore, client: APIClient) {
        self.presenter = presenter
        self.store = store
        self.client = client
    }
    
    func start() {
        // Setup weather list view controller
        let weatherListViewController = WeatherListViewController(viewModel: WeatherListViewModel(client: client, store: store))
        weatherListViewController.title = "Weather"
        weatherListViewController.delegate = self
    
        presenter.pushViewController(weatherListViewController, animated: true)
        self.weatherListViewController = weatherListViewController
            
        let searchCoordinator = CitiesSearchCoordinator(presenter: weatherListViewController, store: store)
        searchCoordinator.start()
        childCoordinators.append(searchCoordinator)
    }
}

extension WeatherListCoordinator: WeatherListViewControllerDelegate {
    func weatherListControllerDidSelectCity(_ city: City) {
        let detailCoordinator = ForecastDetailsCoordinator(presenter: presenter, city: city, store: store, client: client)
        detailCoordinator.parentCoordinator = self
        childCoordinators.append(detailCoordinator)
        detailCoordinator.start()
    }
}

