//
//  ForecastDetailsViewController.swift
//  Weather App
//
//  Created by Aleksandr Kelbas on 10/09/2021.
//

import UIKit
import Combine

protocol ForecastDetailsViewControllerDelegate: class {
    func didSelectDeleteForCity(_ city: City)
}

class ForecastDetailsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    let viewModel: ForecastDetailsViewModel
    private var disposables = Set<AnyCancellable>()
    
    init(viewModel: ForecastDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.register(cell: ForecastTableViewCell.self)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorInset = .zero
        
        title = viewModel.cityName
        
        viewModel.$loading.receive(on: DispatchQueue.main).sink { [weak self] (loading) in
            if loading {
                self?.activityIndicator.startAnimating()
            } else {
                self?.activityIndicator.stopAnimating()
                self?.tableView.reloadData()
            }
            
        }.store(in: &disposables)
        
    }

}

extension ForecastDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(forType: ForecastTableViewCell.self, indexPath: indexPath)
        
        if let cellVM = viewModel.cellViewModel(for: indexPath) {
            cell.configure(from: cellVM)
        }
        
        cell.selectionStyle = .none
        
        return cell
    }
    
}
