//
//  ProductListTableView+Delegates.swift
//  SampleClassifiedApp
//
//  Created by irfan on 04/12/2020.
//

import UIKit
import Foundation

extension ProductListViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.products.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "productCell", for: indexPath) as! ProductCollectionViewCell
        let displayedProduct = viewModel!.products[indexPath.row]
        cell.configure(displayedProduct)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = (UIScreen.main.bounds.size.width / 2) - 32
        
        return CGSize(width: cellWidth, height: 240.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "ProductDetailViewController") as! ProductDetailViewController
        detailVc.setupInteractor()
        let product = interactor!.allProducts[indexPath.row]
        detailVc.interactor.product = product
        navigationItem.title = " "
        self.navigationController?.pushViewController(detailVc, animated: true)
    }
}
