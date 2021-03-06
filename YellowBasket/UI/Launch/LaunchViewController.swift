//
//  LaunchViewController.swift
//  YellowBasket
//
//  Created by Franco Risma on 27/07/2018.
//  Copyright © 2018 FRisma. All rights reserved.
//

import UIKit
import SnapKit

class LaunchViewController: UIViewController {

    private var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView = UIImageView(image: UIImage(named: "launchScreen"))
        view.addSubview(imageView)
        
        imageView.snp.makeConstraints { (make) in
            make.center.equalTo(view)
        }
        
        view.backgroundColor = .clear
        let backgroundLayer = GradientColors(withTopColor: kLaunchScreenTopColor, bottomColor: kLaunchScreenBottomColor).layer
        backgroundLayer?.frame = view.frame
        view.layer.insertSublayer(backgroundLayer!, at: 0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.view.shake(view: self.imageView)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            if !self.hasSetACountry() {
                self.present(CountrySelectionMainViewController(), animated: true, completion: nil)
            } else {
                let nc = UINavigationController(rootViewController: HomeMainViewController(withPresenter: HomeMainViewPresenter()))
                self.present(nc, animated: true, completion: nil)
            }
        }
    }
    
    private func hasSetACountry() -> Bool {
        return UserDefaults.standard.hasSelectedACountry()
        
    }
}
