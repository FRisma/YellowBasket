//
//  Request.swift
//  YellowBasket
//
//  Created by Franco Risma on 29/07/2018.
//  Copyright © 2018 FRisma. All rights reserved.
//

import Foundation
import Alamofire

protocol Request {
    // Endpoint path (ie /user/1234)
    var path: String { get }
    
    // HTTP: GET POST PUT DELETE OPTIONS...
    var method: HTTPMethod { get }
    
    var params: RequestParams? { get }
    
    // Headers sent with every request
    var headers: RequestHeaders? { get }
}
