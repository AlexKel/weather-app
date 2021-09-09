//
//  ListViewModel.swift
//  Weather App
//
//  Created by Aleksandr Kelbas on 08/09/2021.
//

import Foundation

protocol ListViewModel {
    associatedtype CellViewModelType: CellViewModel
    associatedtype DataType
    var numberOfSections: Int { get }
    func numberOfRows(in section: Int) -> Int
    func cellViewModel(for indexPath: IndexPath) -> CellViewModelType?
    func dataAt(indexPath: IndexPath) -> DataType?
}
