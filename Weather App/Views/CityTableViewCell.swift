//
//  CityTableViewCell.swift
//  Weather App
//
//  Created by Aleksandr Kelbas on 07/09/2021.
//

import UIKit

class CityTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var conditionsLabel: UILabel!
    @IBOutlet weak var highTempLabel: UILabel!
    @IBOutlet weak var lowTempLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

extension CityTableViewCell: ConfigurableCell {
    typealias ViewModel = CityWeatherCellViewModel
    
    func configure(from viewModel: CityWeatherCellViewModel) {
        nameLabel.text = viewModel.name
        tempLabel.text = viewModel.temp
        conditionsLabel.text = viewModel.condition
        highTempLabel.text = viewModel.tempMax
        lowTempLabel.text = viewModel.tempMin
    }
}
