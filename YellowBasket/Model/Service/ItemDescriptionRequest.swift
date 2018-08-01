//
//  ItemDescriptionRequest.swift
//  YellowBasket
//
//  Created by Franco Risma on 31/07/2018.
//  Copyright © 2018 FRisma. All rights reserved.
//

import Foundation
import Alamofire

//https://api.mercadolibre.com/items/MLA713654941/descriptions
class ItemDescriptionRequest: Request {
    var path: String
    
    var method: HTTPMethod
    
    var params: RequestParams?
    
    var headers: RequestHeaders?
    
    init(withItemId itemId: String) {
        path = "/items/\(itemId)/descriptions"
        method = .get
        params = nil
        headers = nil
    }
    
}
