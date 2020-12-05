//
//  ProductListInteractor.swift
//  SampleClassifiedApp
//
//  Created by irfan on 04/12/2020.
//

import Foundation

protocol ProductListBusinessLogic {
    func fetchProductList(_ completion: @escaping (Bool) -> Void)
}

class ProductListInteractor : NSObject {
    var presenter: ProductListPresentationLogic?
    var allProducts: [Product] = []
    let productWorker = ProductListWorker()
    
    init(presenter: ProductListPresentationLogic) {
        self.presenter = presenter
    }
}

extension ProductListInteractor: ProductListBusinessLogic {
    func fetchProductList(_ completion: @escaping (Bool)->Void) {
        self.presenter?.presentLoader()
        productWorker.fetchProducts { [weak self] (response, error) in
            guard let `self` = self else { return }
            self.presenter?.hideLoader()
            if error == nil {
                if let response = response {
                    self.allProducts = response.products
                    self.presenter?.presentProducts(response)
                    completion(true)
                } else {
                    self.presenter?.presentAlertView(message: error?.localizedDescription ?? "Data not found")
                    completion(false)
                }
            } else {
                self.presenter?.presentAlertView(message: error?.localizedDescription ?? "Server Error")
                completion(false)
            }
        }
    }
}

