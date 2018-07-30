//
//  CountrySearchRequest.swift
//  YellowBasket
//
//  Created by Franco Risma on 29/07/2018.
//  Copyright © 2018 FRisma. All rights reserved.
//

import Foundation
import Alamofire

class CountrySearchRequest: Request {
    
    var path: String
    
    var method: HTTPMethod
    
    var params: RequestParams
    
    var headers: [String : Any]?
    
    init() {
        path = "/sites"
        method = .get
        params = .url(nil)
        headers = nil
    }
}
