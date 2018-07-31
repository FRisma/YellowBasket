//
//  HomeMainViewPresenter.swift
//  YellowBasket
//
//  Created by Franco Risma on 27/07/2018.
//  Copyright © 2018 FRisma. All rights reserved.
//

import Foundation

class HomeMainViewPresenter: HomeMainPresenterProtocol {
    
    private var viewDelegate: HomeMainControllerProtocol? {
        didSet {
            work()
        }
    }
    
    //MARK: HomeMainPresenterProtocol
    func setViewDelegate(delegate: HomeMainControllerProtocol) {
        viewDelegate = delegate
    }
    
    func touched(category: Category) {
        self.viewDelegate?.goToDetailsView(forCategory: category)
    }
    
    func touched(item: Item) {
        self.viewDelegate?.goToDetailsView(forItem: item)
    }
    
    //MARK: Internal
    private func work() {
        APIService.shared.getCategories(onSuccess: { (categoriesArray) in
            self.viewDelegate?.update(categories: categoriesArray)
        }) { (error) in
            self.viewDelegate?.showErrorMessage(message: "No hay categorias")
        }
        
        APIService.shared.getItems(forQuery: "audi a3", onSuccess: { (itemsArray) in
            self.viewDelegate?.update(products: itemsArray)
        }) { (error) in
            self.viewDelegate?.showErrorMessage(message: "No hay productos")
        }
        
        //        let fakeItem = Item(identifier: "MLA679232727", title: "String", price: 123, currencyId: "<#T##String#>", quantity: 1, condition: "Nueo", thumbnail: "tuhermana")
        //        APIService.shared.getDetails(forItem: fakeItem, onSuccess: { (itemDetails) in
        //            print("Jamon")
        //        }) { (error) in
        //            print("error")
        //        }
    }
    
    
}
