//
//  CitySearchTableViewController.swift
//  Weather App
//
//  Created by Aleksandr Kelbas on 08/09/2021.
//

import UIKit

protocol CitySearchTableViewControllerDelete: class {
    func citySearchControllerDidSelectCity(_ city: City)
}

class CitySearchTableViewController: UITableViewController {
    
    weak var delegate: CitySearchTableViewControllerDelete?
    private let cityCellIdentifier = "city_cell"
    var viewModel: CitiesListViewModel
        
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(cell: CityTableViewCell.self)
    }
    
    init(viewModel: CitiesListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(forType: CityTableViewCell.self, indexPath: indexPath)
        if let vm = viewModel.cellViewModel(for: indexPath) {
            cell.configure(from: vm)
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let city = viewModel.dataAt(indexPath: indexPath) {
            delegate?.citySearchControllerDidSelectCity(city)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension CitySearchTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        viewModel.filter(text: searchBar.text ?? "")
        tableView.reloadData()
    }
}
