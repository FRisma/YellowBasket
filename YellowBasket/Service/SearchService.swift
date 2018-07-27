//
//  SearchService.swift
//  YellowBasket
//
//  Created by Franco Risma on 27/07/2018.
//  Copyright © 2018 FRisma. All rights reserved.
//

import Foundation

class SearchService {
    
    static let shared = SearchService()
    
    private init() {
    }
    
    func getAvailableCountries() {
        MercadoLibreProvider.shared.fetchAvailableCountries { (elements) in
            // Do something
        }
    }
    
}
