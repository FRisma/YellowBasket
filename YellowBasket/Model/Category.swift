//
//  Category.swift
//  YellowBasket
//
//  Created by Franco Risma on 31/07/2018.
//  Copyright © 2018 FRisma. All rights reserved.
//

import Foundation

struct Category: Decodable {
    
    let identifier: String
    let name: String
    
    enum CodingKeys : String, CodingKey {
        case identifier = "id"
        case name
    }
}
