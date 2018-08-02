//
//  MercadoLibreProvider.swift
//  YellowBasket
//
//  Created by Franco Risma on 27/07/2018.
//  Copyright © 2018 FRisma. All rights reserved.
//

import Foundation
import Alamofire

let baseURL = "https://api.mercadolibre.com"

class MercadoLibreProvider: ProviderBaseClass, ProviderProtocol {

    static let shared = MercadoLibreProvider()
    
    override private init() {
    }
    
    func fetchAvailableCountries(withRequest request: Request, completion: @escaping ([Country]?,Error?) -> Void) {
        call(endpoint: baseURL,request: request, onSuccess: { (responseString) in
            guard let countriesArray = try? JSONDecoder().decode(Array<Country>.self, from: responseString.data(using: String.Encoding.utf8)!) else {
                print("Error: Couldn't decode data into Country")
                completion(nil,NSError(domain: "com.yellowBasket", code: 234, userInfo: ["underlyingError" : "Couldn't decode data into Country"]))
                return
            }
            completion(countriesArray,nil)
        }) { (error) in
            completion(nil,error)
        }
    }
    
    func getTrendingKeywords(withRequest request: Request, completion: @escaping ([TrendingKeyword]?, Error?) -> Void) {
        call(endpoint: baseURL, request: request, onSuccess: { (responseString) in
            guard let keywordsArray = try? JSONDecoder().decode(Array<TrendingKeyword>.self, from: responseString.data(using: String.Encoding.utf8)!) else {
                print("Error: Couldn't decode data into TrendingKeyword")
                return completion(nil,NSError() as Error)
            }
            completion(keywordsArray,nil)
        }) { completion(nil,$0) }
    }
    
    func getItems(withRequest request: Request, completion: @escaping ([Item]?, Error?) -> Void) {
        call(endpoint: baseURL, request: request, onSuccess: { (responseString) in
            guard let result = try? JSONDecoder().decode(Items.self, from: responseString.data(using: String.Encoding.utf8)!) else {
                print("Error: Couldn't decode data into Items Array")
                return completion(nil,NSError() as Error)
            }
            completion(result.itemsArray,nil)
        }) { completion(nil,$0) }
    }
    
    func getItemDetail(withRequest request: Request, completion: @escaping (Item?, Error?) -> Void) {
        call(endpoint: baseURL, request: request, onSuccess: { (responseString) in
            guard let itemDetail = try? JSONDecoder().decode(Item.self, from: responseString.data(using: String.Encoding.utf8)!) else {
                print("Error: Couldn't decode data into Items Details")
                return completion(nil,NSError() as Error)
            }
            completion(itemDetail,nil)
        }) { completion(nil,$0) }
    }
    
    func getItemDescription(withRequest request: Request, completion: @escaping (ItemDescription?, Error?) -> Void) {
        call(endpoint: baseURL, request: request, onSuccess: { (responseString) in
            guard let description = try? JSONDecoder().decode(Array<ItemDescription>.self, from: responseString.data(using: String.Encoding.utf8)!) else {
                print("Error: Couldn't decode data into ItemDescription")
                return completion(nil,NSError() as Error)
            }
            completion(description.first,nil)
        }) { completion(nil,$0) }
    }
    
    func getCategories(withRequest request: Request, completion: @escaping ([Category]?, Error?) -> Void) {
        call(endpoint: baseURL, request: request, onSuccess: { (responseString) in
            guard let result = try? JSONDecoder().decode(Array<Category>.self, from: responseString.data(using: String.Encoding.utf8)!) else {
                print("Error: Couldn't decode data into Category Array")
                return completion(nil,NSError() as Error)
            }
            completion(result,nil)
        }) { completion(nil,$0) }
    }
}

