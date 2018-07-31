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
        
        let url = endpoint+request.path
        manager.request(url,
                        method: HTTPMethod.init(rawValue: request.method.rawValue)!,
                        parameters: request.params,
                        encoding: URLEncoding.default,
                        headers: [:])
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
