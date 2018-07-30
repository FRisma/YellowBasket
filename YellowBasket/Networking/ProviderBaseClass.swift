//
//  ProviderBaseClass.swift
//  YellowBasket
//
//  Created by Franco Risma on 29/07/2018.
//  Copyright © 2018 FRisma. All rights reserved.
//

import UIKit
import Alamofire

class ProviderBaseClass {
    
    private let manager: Alamofire.SessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 10
        configuration.timeoutIntervalForResource = 10
        return Alamofire.SessionManager(configuration: configuration)
    }()
    
    public func call(endpoint: String,
                     request: Request,
                     onSuccess:@escaping (String) -> Void,
                     onFailure:@escaping (Error) -> Void) {
        
        guard let url = URL(string: endpoint + request.path) else {
            onFailure(NSError(domain: "com.yellowBasket", code: 234, userInfo: ["underlyingError" : "Bad url"]))
            return
        }
        
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        /*
         request.setValue("application/json", forHTTPHeaderField: "Content-Type")
         request.timeoutInterval = 10 // 10 secs
         let values = ["key": "value"]
         request.httpBody = try! JSONSerialization.data(withJSONObject: values, options: [])
         */
        
        manager.request(urlRequest as URLRequestConvertible)
            .validate()
            .responseString { response in
                switch(response.result) {
                case .success(let responseString):
                    onSuccess(responseString)
                case .failure(let error):
                    onFailure(error)
                }
        }
    }
}
