//
//  DetailsImageAndTitleViewProtocol.swift
//  YellowBasket
//
//  Created by Franco Risma on 01/08/2018.
//  Copyright © 2018 FRisma. All rights reserved.
//

import Foundation

@objc protocol DetailsImageAndTitleViewProtocol {
    
    func detailsImageView(imagesStringArrayForProductInView: DetailsImageAndTitleView) -> [String]
    
    func detailsImageView(titleForProductInView: DetailsImageAndTitleView) -> String
    
    func detailsImageView(priceForProductInView: DetailsImageAndTitleView) -> String
    
    @objc optional func carouselImageTapped()
}
