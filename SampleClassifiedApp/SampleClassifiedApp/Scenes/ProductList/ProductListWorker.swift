//
//  ProductListWorker.swift
//  SampleClassifiedApp
//
//  Created by irfan on 04/12/2020.
//

import Foundation

struct ProductListWorker {
    func fetchProducts(_ completion: @escaping (ProductListViewModel.ProductListResponse?, Error?) -> Void) {
        APIClient.apiClient.executeRequest(path: Constants.API_ENDPOINTS.ProductListAPI, method: .get, params: [:]) { (result) in
            if result.isSuccess {
                if let data = result.value as? Data {
                    let productResponse = parseResponse(data)
                    completion(productResponse, nil)
                } else {
                    completion(nil, result.error)
                }
            } else {
                completion(nil, result.error)
            }
        }
    }
    
    func parseResponse(_ jsonData: Data) -> ProductListViewModel.ProductListResponse? {
        do {
            let jsonDecoder = JSONDecoder()
            let products = try jsonDecoder.decode(ProductResponse.self, from: jsonData)
            return ProductListViewModel.ProductListResponse(products: products.list)
        } catch {
            return nil
        }
    }
}
