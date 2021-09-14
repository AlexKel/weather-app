//
//  CoordinatedViewController.swift
//  Weather App
//
//  Created by Aleksandr Kelbas on 14/09/2021.
//

import UIKit

class CoordinatedViewController: UIViewController, CoordinatedController {
    weak var coordinator: Coordinator?
    
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        coordinator?.finish()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
