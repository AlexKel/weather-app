//
//  CitiesSearchCoordinator.swift
//  Weather App
//
//  Created by Aleksandr Kelbas on 06/09/2021.
//

import UIKit

protocol CitiesSearchPresenter: UIViewController {
    func citiesSearchDidFinish()
}

class CitiesSearchCoordinator: Coordinator {
    weak var parentCoordinator: Coordinator?
    
    var childCoordinators: [Coordinator] = []
    
    // Presenter and data controller
    private weak var presenter: CitiesSearchPresenter?
    private let store: CitiesStore
    
    // View controllers
    private var searchResultsController: CitySearchTableViewController?
    private var searchController: UISearchController?
    
    
    init(presenter: CitiesSearchPresenter, store: CitiesStore) {
        self.presenter = presenter
        self.store = store
    }
    
    func start() {
        let searchResultsController = CitySearchTableViewController(viewModel: CitiesListViewModel(store: store))
        searchResultsController.delegate = self
        let searchController = UISearchController(searchResultsController: searchResultsController)
        searchController.searchResultsUpdater = searchResultsController
        presenter?.navigationItem.searchController = searchController
        
        
        self.searchController = searchController
        self.searchResultsController = searchResultsController
    }
}

extension CitiesSearchCoordinator: CitySearchTableViewControllerDelete {
    func citySearchControllerDidSelectCity(_ city: City) {
        store.addFavourite(city: city)
        searchController?.isActive = false
        presenter?.citiesSearchDidFinish()
    }
}

