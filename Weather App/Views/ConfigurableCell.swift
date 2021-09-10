//
//  ConfigurableCell.swift
//  Weather App
//
//  Created by Aleksandr Kelbas on 07/09/2021.
//

import Foundation

// TODO: Create Forecast details VM and ViewController, also Coordinator and push

protocol ConfigurableCell {
    associatedtype ViewModel: CellViewModel
    func configure(from viewModel: ViewModel)
}
