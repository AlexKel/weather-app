//
//  ForecastDetailsCoordinator.swift
//  Weather App
//
//  Created by Aleksandr Kelbas on 10/09/2021.
//

import UIKit

class ForecastDetailsCoordinator: Coordinator {
    weak var parentCoordinator: Coordinator?
    
    var childCoordinators: [Coordinator] = []
    private let presenter: UINavigationController
    private let client: APIClient
    private let store: CitiesStore
    private let city: City
    
    private var forecastViewController: ForecastDetailsViewController?
    
    init(presenter: UINavigationController, city: City, store: CitiesStore, client: APIClient) {
        self.presenter = presenter
        self.client = client
        self.store = store
        self.city = city
    }
    
    func start() {
        let details = ForecastDetailsViewController(viewModel: ForecastDetailsViewModel(city: city, client: client, store: store))
        details.delegate = self
        details.coordinator = self
        presenter.pushViewController(details, animated: true)
        self.forecastViewController = details
    }
}

extension ForecastDetailsCoordinator: ForecastDetailsViewControllerDelegate {
    func didSelectDelete() {
        store.removeFavourite(city: city)
        presenter.popViewController(animated: true)
    }
}
