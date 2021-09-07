//
//  ConfigurableCell.swift
//  Weather App
//
//  Created by Aleksandr Kelbas on 07/09/2021.
//

import Foundation

protocol ConfigurableCell {
    associatedtype ViewModel: CellViewModel
    func configure(from viewModel: ViewModel)
}
