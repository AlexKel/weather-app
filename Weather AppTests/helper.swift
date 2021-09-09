//
//  helper.swift
//  Weather AppTests
//
//  Created by Aleksandr Kelbas on 09/09/2021.
//

import Foundation


class Helper {
    static func loadFile(named: String, withExtension: String = "json") -> Data {
        guard let url = Bundle(for: Helper.self).url(forResource: named, withExtension: withExtension),
              let data = try? Data(contentsOf: url) else {
            fatalError("Cannot load resource from bundle")
        }
        
        return data
    }
}
