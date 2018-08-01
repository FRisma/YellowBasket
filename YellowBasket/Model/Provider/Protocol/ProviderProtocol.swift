//
//  ProviderProtocol.swift
//  YellowBasket
//
//  Created by Franco Risma on 29/07/2018.
//  Copyright © 2018 FRisma. All rights reserved.
//

import Foundation

protocol ProviderProtocol {
    
    func fetchAvailableCountries(withRequest request: Request, completion: @escaping ([Country]?,Error?) -> Void)
    
    func getTrendingKeywords(withRequest request:Request, completion: @escaping ([TrendingKeyword]?,Error?) -> Void)
    
    func getItems(withRequest request: Request, completion: @escaping ([Item]?, Error?) -> Void)
    
    func getItemDetail(withRequest request: Request, completion: @escaping (Item?, Error?) -> Void)
    
    func getItemDescription(withRequest request: Request, completion: @escaping (ItemDescription?, Error?) -> Void)
    
    func getCategories(withRequest request: Request, completion: @escaping ([Category]?, Error?) -> Void)
}
