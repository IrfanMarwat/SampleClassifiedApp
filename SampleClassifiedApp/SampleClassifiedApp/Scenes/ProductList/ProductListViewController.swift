//
//  ViewController.swift
//  SampleClassifiedApp
//
//  Created by irfan on 04/12/2020.
//

import UIKit

protocol ProductListDisplayable: class {
    func displayProducts(_ viewModel: ProductListViewModel.ViewModel)
    func displayAlertView(message: String)
    func displayLoader()
    func hideLoader()
}


class ProductListViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
        
    var interactor: ProductListInteractor?
    var viewModel: ProductListViewModel.ViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
                
        let presenter = ProductListPresenter(viewController: self)
        interactor = ProductListInteractor(presenter: presenter)
        
        interactor?.fetchProductList({ (_) in })
        setNavigationBarTransparent(tintColor: .white)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        title = "Product List"
    }
    
    func showAlert(message: String) {
        DispatchQueue.main.async {
            // Show Alert
            let alertVc = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
            alertVc.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
                self.dismiss(animated: true, completion: nil)
            }))

            self.present(alertVc, animated: true)
        }
    }
}


extension ProductListViewController: ProductListDisplayable {
    
    func displayProducts(_ viewModel: ProductListViewModel.ViewModel) {
        self.viewModel = viewModel
        collectionView.reloadData()
    }
    
    func displayAlertView(message: String) {
        showAlert(message: message)
    }
    
    func displayLoader() {
        view.showActivityIndicator(.large, tintColor: .white, title: nil)
    }
    
    func hideLoader() {
        view.hideIndicator()
    }
}

