//
//  MercadoLibreProvider.swift
//  YellowBasket
//
//  Created by Franco Risma on 27/07/2018.
//  Copyright © 2018 FRisma. All rights reserved.
//

import Foundation
import Alamofire

/*
 NSString * const kMLAPIBaseURL = @"https://api.mercadolibre.com";
 NSString * const kMLAPISitesURI = @"/sites";
 NSString * const kMLAPIItemsURI = @"/items";
 NSString * const kMLAPICountryURI = @"/MLA";
 NSString * const kMLAPISearchURI = @"/search";
 NSString * const kMLAPISearchParameter = @"q";
 */

class MercadoLibreProvider {
    
    static let shared = MercadoLibreProvider()
    
    private init() {
    }
    
    func fetchAvailableCountries(completion: @escaping ([Any]?) -> Void) {
        guard let url = URL(string: "https://api.mercadolibre.com/sites") else {
            completion(nil)
            return
        }
        Alamofire.request(url,
                          method: .get,
                          parameters: nil)
            .validate()
            .responseString { response in
                
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                
                switch(response.result) {
                case .success(let responseString):
                    //Do something
                    guard let countriesArray = try? JSONDecoder().decode(Array<Country>.self, from: responseString.data(using: .utf8)!) else {
                        print("Error: Couldn't decode data into Country")
                        //onCompletion(nil,NSError(domain:"com.yellowBasket.provider", code:500, userInfo:nil) )
                        return
                    }
                    print("Success")
                case .failure:
                    print("fail")
                }
                
                guard response.result.isSuccess else {
                    print("Error while fetching remote sites")
                        completion(nil)
                    return
                }
                
                
                
                /*guard let chats = try? JSONDecoder().decode(Country.self, from: response.result.value.data(using: .utf8)!) else {
                    print("Error: Couldn't decode data into Country")
                    onCompletion(nil,NSError(domain:"com.yellowBasket.provider", code:500, userInfo:nil) )
                    return
                }*/
                
                //let rooms = rows.flatMap { roomDict in return RemoteRoom(jsonData: roomDict) }
                //completion(rooms)
                }
    }
}
