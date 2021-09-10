//
//  CitiesListViewController.swift
//  Weather App
//
//  Created by Aleksandr Kelbas on 05/09/2021.
//

import UIKit
import Combine

protocol WeatherListViewControllerDelegate: class {
    func weatherListControllerDidSelectCity(_ city: City)
}

class WeatherListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    let viewModel: WeatherListViewModel
    private let cellIdentifier = "weather_cell"
    weak var delegate: WeatherListViewControllerDelegate?
    
    init(viewModel: WeatherListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.register(cell: CityWeatherTableViewCell.self)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 72
        tableView.separatorInset = .zero
    }

}

extension WeatherListViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(forType: CityWeatherTableViewCell.self, indexPath: indexPath)
        if let vm = viewModel.cellViewModel(for: indexPath) {
            cell.configure(from: vm)   
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let city = viewModel.dataAt(indexPath: indexPath) {
            delegate?.weatherListControllerDidSelectCity(city)
        }
    }
}

extension WeatherListViewController: CitiesSearchPresenter {
    func citiesSearchDidFinish() {
        tableView.reloadData()
    }
}
