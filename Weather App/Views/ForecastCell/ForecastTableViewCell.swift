//
//  ForecastTableViewCell.swift
//  Weather App
//
//  Created by Aleksandr Kelbas on 10/09/2021.
//

import UIKit

class ForecastTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var conditionLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension ForecastTableViewCell: ConfigurableCell {
    typealias ViewModel = ForecastCellViewModel
    
    func configure(from viewModel: ForecastCellViewModel) {
        titleLabel.text = viewModel.title
        conditionLabel.text = viewModel.condition
        tempLabel.text = viewModel.temperature
    }
}
