//
//  TrendingKeywordsViewDelegate.swift
//  YellowBasket
//
//  Created by Franco Risma on 02/08/2018.
//  Copyright © 2018 FRisma. All rights reserved.
//

import UIKit

protocol TrendingKeywordsViewDelegate: AnyObject {
    func tapped(onKeyword keyword: String)
}
