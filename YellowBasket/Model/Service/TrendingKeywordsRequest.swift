//
//  TrendingKeywordsRequest.swift
//  YellowBasket
//
//  Created by Franco Risma on 29/07/2018.
//  Copyright © 2018 FRisma. All rights reserved.
//

import Foundation
import Alamofire

class TrendingKeywordsRequest: Request {
    var path: String
    
    var method: HTTPMethod
    
    var params: RequestParams?
    
    var headers: RequestHeaders?
    
    init(forCountryKey countryKey: String) {
        path = "/sites/\(countryKey)/trends/search"
        method = .get
        params = nil
        headers = nil
    }
}
