//
//  ProductDetailsMainControllerProtocol.swift
//  YellowBasket
//
//  Created by Franco Risma on 31/07/2018.
//  Copyright © 2018 FRisma. All rights reserved.
//

import Foundation

protocol ProductDetailsMainControllerProtocol {
    
    func showErrorMessage(message: String)
    
    func showLoadingIndicator()
    
    func hideLoadingIndicator()
    
    func updateInfoForProduct(_ product: Item)
    
    func updateProductDescription(_ descr: String)
}
