//
//  CategoryListViewDelegate.swift
//  YellowBasket
//
//  Created by Franco Risma on 31/07/2018.
//  Copyright © 2018 FRisma. All rights reserved.
//

import UIKit

protocol CategoryListViewDelegate {
    
    func categoryList(numbersOfElementsInCategoryView categoryView: CategoryListView) -> Int
    
    func categoryList(_ categoryView: CategoryListView, viewForElementAtIndex index: Int) -> UIView
}
