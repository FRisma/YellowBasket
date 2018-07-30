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
let trends = "%s/sites/%s/trends/search" //https://api.mercadolibre.com/sites/MLA/trends/search
/*
 NSString * const kMLAPISitesURI = @"/sites";
 NSString * const kMLAPIItemsURI = @"/items";
 NSString * const kMLAPICountryURI = @"/MLA";
 NSString * const kMLAPISearchURI = @"/search";
 NSString * const kMLAPISearchParameter = @"q";
 */

class MercadoLibreProvider: ProviderBaseClass, ProviderProtocol {
    
    static let shared = MercadoLibreProvider()
    
    override private init() {
    }
    
    func fetchAvailableCountries(withRequest request: Request, completion: @escaping ([Country]?,Error?) -> Void) {
        self.call(endpoint: baseURL,request: request, onSuccess: { (responseString) in
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
        self.call(endpoint: baseURL, request: request, onSuccess: { (responseString) in
            guard let keywordsArray = try? JSONDecoder().decode(Array<TrendingKeyword>.self, from: responseString.data(using: String.Encoding.utf8)!) else {
                print("Error: Couldn't decode data into TrendingKeyword")
                return completion(nil,NSError() as Error)
            }
            completion(keywordsArray,nil)
        }) { (error) in
            completion(nil,error)
        }
    }
    
    //https://api.mercadolibre.com/sites/MLA/search?q=ipod
    func getItems(withRequest request: Request, completion: @escaping ([Item]?, Error?) -> Void) {
        self.call(endpoint: baseURL, request: request, onSuccess: { (responseString) in
            guard let itemsArray = try? JSONDecoder().decode(Array<Item>.self, from: responseString.data(using: String.Encoding.utf8)!) else {
                print("Error: Couldn't decode data into Items Array")
                return completion(nil,NSError() as Error)
            }
            completion(itemsArray,nil)
        }) { (error) in
            completion(nil,error)
        }
    }
    
    
    //https://api.mercadolibre.com/items/MLA717988441
    func getItemDetail(withRequest request: Request, completion: @escaping (Item?, Error?) -> Void) {
        self.call(endpoint: baseURL, request: request, onSuccess: { (responseString) in
            guard let itemDetail = try? JSONDecoder().decode(Item.self, from: responseString.data(using: String.Encoding.utf8)!) else {
                print("Error: Couldn't decode data into Items Array")
                return completion(nil,NSError() as Error)
            }
            completion(itemDetail,nil)
        }) { (error) in
            completion(nil,error)
        }
    }
}

