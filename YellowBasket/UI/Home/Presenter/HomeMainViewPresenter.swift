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
    
    func searchingForText(_ text: String) {
        performSearchForString(text)
    }
    
    //MARK: Internal
    private func work() {
        getAvailableCategories()
        performSearchForString("Freddie Mercury")
    }
    
    private func performSearchForString(_ text: String) {
        self.viewDelegate?.showLoadingIndicator()
        APIService.shared.getItems(forQuery: text, onSuccess: { (itemsArray) in
            self.viewDelegate?.hideLoadingIndicator()
            if itemsArray.isEmpty {
                self.viewDelegate?.showErrorMessage(message: "No hay productos que coincidan con la búsqueda")
                return
            }
            self.viewDelegate?.update(products: itemsArray)
        }) { (error) in
            self.viewDelegate?.hideLoadingIndicator()
            self.viewDelegate?.showErrorMessage(message: "Algo salió mal")
        }
    }
    
    private func getAvailableCategories() {
        viewDelegate?.showLoadingIndicator()
        APIService.shared.getCategories(onSuccess: { (categoriesArray) in
            if categoriesArray.isEmpty {
                self.viewDelegate?.showErrorMessage(message: "No hay categorias")
                return
            }
            self.viewDelegate?.update(categories: categoriesArray)
        }) { (error) in
            self.viewDelegate?.hideLoadingIndicator()
            self.viewDelegate?.showErrorMessage(message: "Algo salió mal")
        }
    }
}
