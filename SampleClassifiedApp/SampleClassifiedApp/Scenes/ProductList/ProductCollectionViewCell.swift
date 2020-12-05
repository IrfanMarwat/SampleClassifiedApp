//
//  ProductTableViewCell.swift
//  SampleClassifiedApp
//
//  Created by irfan on 04/12/2020.
//

import UIKit
import Kingfisher

class ProductCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageViewProduct: UIImageView!
    @IBOutlet weak var labelProductName: UILabel!
    @IBOutlet weak var labelDate: UILabel!
    @IBOutlet weak var labelPrice: UILabel!
    @IBOutlet weak var gradientView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        applyGradient()
    }
    
    
    func configure(_ viewModel: ProductListViewModel.ViewModel.DisplayedProduct) {
        labelProductName.text = viewModel.name
        labelPrice.text = viewModel.price
        labelDate.text = viewModel.date
        imageViewProduct.downloadImage(viewModel.imageUrl, isThumbnail: true) { (_) in }
    }
    
    func applyGradient() {
        let gradientEndColor = UIColor(white: 26.0 / 255.0, alpha: 1.0)
        let colors = [gradientEndColor.withAlphaComponent(0.0),UIColor.black.withAlphaComponent(1)]
        gradientView.applyGradient(with: colors)
    }
}
