//
//  APIService.swift
//  YellowBasket
//
//  Created by Franco Risma on 27/07/2018.
//  Copyright © 2018 FRisma. All rights reserved.
//

import Foundation

class APIService {
    
    static let shared = APIService()
    private var provider: ProviderProtocol!
    
    private init() {
        provider = selectProvider()
    }
    
    func getAvailableCountries(onSuccess:@escaping ([Country]) -> Void, onFailure:@escaping (Error) -> Void) {
        provider.fetchAvailableCountries(withRequest: CountrySearchRequest()) { ($1 != nil) ? onFailure($1!) : onSuccess($0!) }
    }
    
    func getTrendingKeywords(onSuccess:@escaping ([TrendingKeyword]) -> Void, onFailure:@escaping (Error) -> Void) {
        provider.getTrendingKeywords(withRequest: TrendingKeywordsRequest()) { ($1 != nil) ? onFailure($1!) : onSuccess($0!) }
    }
    
    func getItems(forQuery query: String, onSuccess:@escaping ([Item]) -> Void, onFailure:@escaping (Error) -> Void) {
        provider.getItems(withRequest: ItemsRequest()) { ($1 != nil) ? onFailure($1!) : onSuccess($0!) }
    }
    
    func getDetails(forItem item: Item, onSuccess:@escaping (Item) -> Void, onFailure:@escaping (Error) -> Void) {
        provider.getItemDetail(withRequest: ItemRequest()) { ($1 != nil) ? onFailure($1!) : onSuccess($0!) }
    }
    
    // MARK: Internal
    private func selectProvider() -> ProviderProtocol {
        return MercadoLibreProvider.shared
    }
    
}
