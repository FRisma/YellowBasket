//
//  HomeMainControllerProtocol.swift
//  YellowBasket
//
//  Created by Franco Risma on 31/07/2018.
//  Copyright © 2018 FRisma. All rights reserved.
//

import Foundation

protocol HomeMainControllerProtocol {

    func update(categories: [Category])
    func update(products: [Item])
    func goToDetailsView(forItem item: Item)
    func goToDetailsView(forCategory category: Category)
    func showErrorMessage(message: String)
}
