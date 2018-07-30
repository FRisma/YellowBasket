//
//  LandingMainViewController.swift
//  YellowBasket
//
//  Created by Franco Risma on 27/07/2018.
//  Copyright © 2018 FRisma. All rights reserved.
//

import UIKit

class LandingMainViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .green
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        APIService.shared.getTrendingKeywords(onSuccess: { (keywordsArray) in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            print("success")
        }) { (error) in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            print("error")
        }
        
        APIService.shared.getTrendingKeywords(onSuccess: { (keywordsArray) in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            print("success")
        }) { (error) in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            print("error")
        }
    }
}
