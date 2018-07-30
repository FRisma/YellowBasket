//
//  MainNavigationController.swift
//  YellowBasket
//
//  Created by Franco Risma on 27/07/2018.
//  Copyright © 2018 FRisma. All rights reserved.
//

import UIKit

class MainNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        if self.hasSetACountry() {
            // Country selected
        } else {
            pushViewController(CountrySelectionMainViewController(), animated: true)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func hasSetACountry() -> Bool {
        return false
        //return UserDefaults.standard.value(forKey: "selectedCountry") as! Bool
    }

}
