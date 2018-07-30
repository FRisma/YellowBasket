//
//  Utils.swift
//  YellowBasket
//
//  Created by Franco Risma on 27/07/2018.
//  Copyright © 2018 FRisma. All rights reserved.
//

import Foundation
import UIKit


/**
 * Language
 */

let kITLang = "lang"

/**
 * Style
 */

let kLaunchScreenTopColor = UIColor(0xf8ff47)
let kLaunchScreenBottomColor = UIColor(0xfaff89)

/**
 * @brief Add the ability for UIColor to be initialized with hex values
 *
 * @discussion Currently there is no implementation in the iOS SDK for initializing a color from
 * an hexadecimal value
 */
extension UIColor {
    convenience init(_ hex: UInt) {
        self.init(
            red: CGFloat((hex & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((hex & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(hex & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}

/**
 * @brief Shake animation for every view
 *
 * @discussion Just call yourview.shake() and you'll get the animation
 */
extension UIView {
    func shake(view: UIView) {
        let animation = CAKeyframeAnimation()
        animation.keyPath = "position.y"
        animation.values = [0, 10, -10, 10, -5, 5, -5, 0 ]
        animation.keyTimes = [0, 0.125, 0.25, 0.375, 0.5, 0.625, 0.75, 0.875, 1]
        animation.duration = 1
        animation.isAdditive = true
        
        view.layer.add(animation, forKey: "shake")
    }
}


class GradientColors {
    var layer:CAGradientLayer!
    
    init(withTopColor topC: UIColor, bottomColor bottomC: UIColor) {
        layer = CAGradientLayer()
        layer.colors = [topC.cgColor, bottomC.cgColor]
        layer.locations = [0.0, 1.0]
    }
}

extension UserDefaults {
    enum UserDefaultsKeys: String {
        case countrySelected
    }
    
    func setselectedCountry(country: String) {
        set("AR", forKey: UserDefaultsKeys.countrySelected.rawValue)
        synchronize()
    }
    
    func set(selectedCountry country: String) {
        set("AR", forKey: UserDefaultsKeys.countrySelected.rawValue)
        synchronize()
    }
    
    func hasSelectedACountry() -> Bool {
        let value = UserDefaults.standard.value(forKey: UserDefaultsKeys.countrySelected.rawValue) as? String
        if value != nil {
            return true
        }
        return false
    }
}
