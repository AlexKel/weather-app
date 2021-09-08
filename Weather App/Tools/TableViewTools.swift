//
//  TableViewTools.swift
//  Weather App
//
//  Created by Aleksandr Kelbas on 08/09/2021.
//

import UIKit


extension UITableView {
    private func reuseIdentifier<T>(for type: T.Type) -> String {
        return String(describing: type)
    }
    
    func register<T: UITableViewCell>(cell: T.Type) {
        register(T.self, forCellReuseIdentifier: reuseIdentifier(for: cell))
        register(UINib(nibName: String(describing: T.self), bundle: nil), forCellReuseIdentifier: reuseIdentifier(for: cell))
    }
    
    func dequeueReusableCell<T: UITableViewCell>(forType type: T.Type, indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: reuseIdentifier(for: type), for: indexPath) as? T else {
            fatalError("Failed to dequeue cell.")
        }
        
        return cell
    }
}
