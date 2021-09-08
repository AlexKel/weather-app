//
//  CityCellViewModel.swift
//  Weather App
//
//  Created by Aleksandr Kelbas on 08/09/2021.
//

import Foundation

class CityCellViewModel: CellViewModel {
    private let city: City
    
    init(city: City) {
        self.city = city
    }
    
    var name: String { return city.name }
}
