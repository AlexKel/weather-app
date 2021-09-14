//
//  CityTableViewCell.swift
//  Weather App
//
//  Created by Aleksandr Kelbas on 07/09/2021.
//

import UIKit
import Combine

class CityWeatherTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var conditionsLabel: UILabel!
    @IBOutlet weak var highTempLabel: UILabel!
    @IBOutlet weak var lowTempLabel: UILabel!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    private var disposables = Set<AnyCancellable>()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

extension CityWeatherTableViewCell: ConfigurableCell {
    typealias ViewModel = CityWeatherCellViewModel
    
    func configure(from viewModel: CityWeatherCellViewModel) {
        viewModel.$loading.receive(on: DispatchQueue.main).sink { [weak self] (loading) in
            if loading {
                self?.loadingIndicator.startAnimating()
            } else {
                self?.loadingIndicator.stopAnimating()
            }

            self?.nameLabel.text = viewModel.name
            self?.tempLabel.text = viewModel.temp
            self?.conditionsLabel.text = viewModel.condition
            self?.highTempLabel.text = viewModel.tempMax
            self?.lowTempLabel.text = viewModel.tempMin

        }.store(in: &disposables)
    }
    
    override func prepareForReuse() {
        disposables.forEach { $0.cancel() }
        super.prepareForReuse()
    }
}
