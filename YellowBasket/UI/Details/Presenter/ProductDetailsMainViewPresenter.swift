//
//  ProductDetailsMainViewPresenter.swift
//  YellowBasket
//
//  Created by Franco Risma on 27/07/2018.
//  Copyright © 2018 FRisma. All rights reserved.
//

import Foundation

class ProductDetailsMainViewPresenter: ProductDetailsMainPresenterProtocol {
    
    private var product: Item?
    
    private var viewDelegate: ProductDetailsMainControllerProtocol? {
        didSet {
            work()
        }
    }
    
    //MARK: ProductDetailsMainPresenterProtocol
    func setViewDelegate(delegate: ProductDetailsMainControllerProtocol) {
        viewDelegate = delegate
    }
    
    func setProduct(_ product: Item) {
        self.product = product
    }
    
    //MARK: Internal
    private func work() {
        guard let anItem = product  else {
            return
        }
        self.viewDelegate?.showLoadingIndicator()
        APIService.shared.getDetails(forItem: anItem, onSuccess: { (item) in
            self.product = item
            self.viewDelegate?.updateInfoForProduct(item)
            self.viewDelegate?.hideLoadingIndicator()
        }) { (error) in
            self.viewDelegate?.hideLoadingIndicator()
            self.viewDelegate?.showErrorMessage(message: "Could not retrieve info")
        }
        
        APIService.shared.getDescription(forItem: anItem, onSuccess: { (description) in
            self.viewDelegate?.updateProductDescription(description.description)
        }) { (error) in
            self.viewDelegate?.hideLoadingIndicator()
            self.viewDelegate?.showErrorMessage(message: "Could not retrieve info")
        }
    }

}
