//
//  ProductListViewModel.swift
//  SampleClassifiedApp
//
//  Created by irfan on 04/12/2020.
//

import Foundation


struct ProductListViewModel {
    
    struct ProductListResponse {
        let products: [Product]
    }
    
    struct ProductListResponseError: Error {
        var localizedDescription: String
    }
    
    struct ViewModel {
        let products: [DisplayedProduct]
        
        struct DisplayedProduct {
            var name: String
            var price: String
            var imageUrl: String
            var date: String
        }
    }
    
}
