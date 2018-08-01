//
//  ProductDetailsMainPresenterProtocol.swift
//  YellowBasket
//
//  Created by Franco Risma on 31/07/2018.
//  Copyright © 2018 FRisma. All rights reserved.
//

import Foundation

protocol ProductDetailsMainPresenterProtocol {
    
    func setViewDelegate(delegate: ProductDetailsMainControllerProtocol)
    
    func setProduct(_ product: Item)
    
}
