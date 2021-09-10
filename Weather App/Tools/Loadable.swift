//
//  Loadable.swift
//  Weather App
//
//  Created by Aleksandr Kelbas on 10/09/2021.
//

import Foundation

protocol Loadable {
    var loading: Bool { get set }
    func load()
}
