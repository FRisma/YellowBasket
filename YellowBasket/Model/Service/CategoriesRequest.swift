//
//  CategoriesRequest.swift
//  YellowBasket
//
//  Created by Franco Risma on 31/07/2018.
//  Copyright © 2018 FRisma. All rights reserved.
//

import Foundation
import Alamofire
//https://api.mercadolibre.com//sites/MLA/categories

class CategoriesRequest: Request {
    var path: String
    
    var method: HTTPMethod
    
    var params: RequestParams?
    
    var headers: RequestHeaders?
    
    init(forCountryKey countryKey: String) {
        path = "/sites/\(countryKey)/categories"
        method = .get
        params = nil
        headers = nil
    }
}
