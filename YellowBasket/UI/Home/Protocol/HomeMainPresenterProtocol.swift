//
//  HomeMainPresenterProtocol.swift
//  YellowBasket
//
//  Created by Franco Risma on 31/07/2018.
//  Copyright © 2018 FRisma. All rights reserved.
//

import Foundation

protocol HomeMainPresenterProtocol {
    
    func setViewDelegate(delegate: HomeMainControllerProtocol)
    
    func touched(category: Category)
    func touched(item: Item)
}
