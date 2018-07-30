//
//  TrendingKeyword.swift
//  YellowBasket
//
//  Created by Franco Risma on 29/07/2018.
//  Copyright © 2018 FRisma. All rights reserved.
//

import Foundation

struct TrendingKeyword: Decodable {
    
    let term: String
    let url: String
    
    enum CodingKeys : String, CodingKey {
        case term = "keyword"
        case url
    }
}
