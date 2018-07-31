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

        
        viewControllers = [HomeMainViewController()]
        
        if !hasSetACountry() {
            perform(#selector(navigateToLandingMainViewController), with: nil, afterDelay: 1)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func hasSetACountry() -> Bool {
        return UserDefaults.standard.hasSelectedACountry()
        
    }
    
    //MARK: Iternal
    @objc private func navigateToCountrySelectionViewController() {
        present(CountrySelectionMainViewController(), animated: true, completion: nil)
    }
    
    @objc private func navigateToLandingMainViewController() {
        viewControllers = [HomeMainViewController()]
    }

}
