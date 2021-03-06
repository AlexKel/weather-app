//
//  CityTableViewCell.swift
//  Weather App
//
//  Created by Aleksandr Kelbas on 08/09/2021.
//

import UIKit

class CityTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
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
    typealias ViewModel = CityCellViewModel
    
    func configure(from viewModel: CityCellViewModel) {
        nameLabel.text = viewModel.name
    }
}
