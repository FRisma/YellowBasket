//
//  ItemsRequest.swift
//  YellowBasket
//
//  Created by Franco Risma on 30/07/2018.
//  Copyright © 2018 FRisma. All rights reserved.
//

import Foundation
import Alamofire

////https://api.mercadolibre.com/sites/MLA/search?q=ipod
class ItemsRequest: Request {
    var path: String
    
    var method: HTTPMethod
    
    var params: RequestParams?
    
    var headers: RequestHeaders?
    
    init(withQueryParam query: String, forCountryKey countryKey: String) {
        path = "/sites/\(countryKey)/search"
        method = .get
        params = ["q" : query]
        headers = nil
    }
    
}
