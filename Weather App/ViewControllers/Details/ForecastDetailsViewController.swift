//
//  ForecastDetailsViewController.swift
//  Weather App
//
//  Created by Aleksandr Kelbas on 10/09/2021.
//

import UIKit
import Combine

protocol ForecastDetailsViewControllerDelegate: class {
    func didSelectDelete()
}

class ForecastDetailsViewController: CoordinatedViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    let viewModel: ForecastDetailsViewModel
    private var disposables = Set<AnyCancellable>()
    weak var delegate: ForecastDetailsViewControllerDelegate?
    
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
        
        
        let deleteButton = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteCity(sender:)))
        navigationItem.rightBarButtonItem = deleteButton
    }
    
    // TODO: Pass to coordinator
    @objc func deleteCity(sender: UIBarButtonItem) {
        let controller = UIAlertController(title: "Are you sure?", message: nil, preferredStyle: .actionSheet)
        controller.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        controller.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { [weak self] (_) in
            self?.delegate?.didSelectDelete()
        }))
        
        navigationController?.present(controller, animated: true, completion: nil)
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
