//
//  Coordinator.swift
//  Weather App
//
//  Created by Aleksandr Kelbas on 05/09/2021.
//

import Foundation

protocol Coordinator: class {
    var parentCoordinator: Coordinator? { get set }
    var childCoordinators: [Coordinator] { get set }
    func start()
    func finish()
}

protocol CoordinatedController {
    var coordinator: Coordinator? { get set }
}

extension Coordinator {
    func childDidFinish(_ child: Coordinator?) {
        for (idx, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: idx)
                break
            }
        }
    }
    
    func finish() {
        parentCoordinator?.childDidFinish(self)
    }
}
