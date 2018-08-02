//
//  Item.swift
//  YellowBasket
//
//  Created by Franco Risma on 30/07/2018.
//  Copyright © 2018 FRisma. All rights reserved.
//

import Foundation

struct Items: Decodable {
    
    let itemsArray: [Item]
    
    enum CodingKeys : String, CodingKey {
        case itemsArray = "results"
    }
}

struct Item: Decodable {
    
    let identifier: String
    let title: String?
    let price: Double?
    let currencyId: String?
    let quantity: Int?
    let condition: String?
    let thumbnail: String?
    let images: [Pictures]?
    let sharingURL: String?
    
    enum CodingKeys : String, CodingKey {
        case identifier = "id"
        case title
        case price
        case currencyId = "currency_id"
        case quantity = "available_quantity"
        case condition
        case thumbnail
        case images = "pictures"
        case sharingURL = "permalink"
    }
}

struct Pictures: Decodable {
    
    let url: String
    
    enum CodingKeys : String, CodingKey {
        case url = "secure_url"
    }
}
