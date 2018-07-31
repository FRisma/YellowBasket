//
//  ItemRequest.swift
//  YellowBasket
//
//  Created by Franco Risma on 30/07/2018.
//  Copyright © 2018 FRisma. All rights reserved.
//

import Foundation
import Alamofire

//https://api.mercadolibre.com/items/MLA717988441
class ItemRequest: Request {
    var path: String
    
    var method: HTTPMethod
    
    var params: RequestParams?
    
    var headers: RequestHeaders?
    
    init(withItemId itemId: String) {
        path = "/items/\(itemId)"
        method = .get
        params = nil
        headers = nil
    }
    
}
