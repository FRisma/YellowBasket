//
//  HomeMainControllerProtocol.swift
//  YellowBasket
//
//  Created by Franco Risma on 31/07/2018.
//  Copyright © 2018 FRisma. All rights reserved.
//

import Foundation

protocol HomeMainControllerProtocol: AnyObject {
    
    func update(products: [Item])
    
    func goToDetailsView(forItem item: Item)
    
    func goToDetailsView(forCategory category: Category)
    
    func showErrorMessage(message: String)
    
    func showTrendingKeywordsView(withElements elements: [String])
    
    func showLoadingIndicator()
    
    func hideLoadingIndicator()
}
