//
//  ProductListPresenter.swift
//  SampleClassifiedApp
//
//  Created by irfan on 04/12/2020.
//

import Foundation


protocol ProductListPresentationLogic {
    func presentProducts(_ productResponse: ProductListViewModel.ProductListResponse)
    func presentAlertView(message: String)
    func presentLoader()
    func hideLoader()
}

struct ProductListPresenter : ProductListPresentationLogic {
    weak var viewController : ProductListDisplayable?
    
    func presentProducts(_ productResponse: ProductListViewModel.ProductListResponse) {
        // convert to view model and send it to view controller
        let displayedProducts = productResponse.products.map({ProductListViewModel.ViewModel.DisplayedProduct.init(name: $0.name, price: $0.price, imageUrl: $0.thumbnailUrls.first ?? "", date: $0.dateCreated)})
        let viewModel = ProductListViewModel.ViewModel.init(products: displayedProducts)
        viewController?.displayProducts(viewModel)
    }
    
    func presentAlertView(message: String) {
        viewController?.displayAlertView(message: message)
    }
    
    func presentLoader() {
        DispatchQueue.main.async {
            self.viewController?.displayLoader()
        }
    }
    
    func hideLoader() {
        DispatchQueue.main.async {
            self.viewController?.hideLoader()
        }
    }
}
