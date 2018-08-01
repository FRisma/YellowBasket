//
//  ItemDescription.swift
//  YellowBasket
//
//  Created by Franco Risma on 31/07/2018.
//  Copyright © 2018 FRisma. All rights reserved.
//

import Foundation

struct ItemDescription: Decodable {
    
    let description: String
    
    enum CodingKeys : String, CodingKey {
        case description = "plain_text"
    }
}
