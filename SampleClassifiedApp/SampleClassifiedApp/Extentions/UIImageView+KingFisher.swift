//
//  UIImageView+KingFisher.swift
//  SampleClassifiedApp
//
//  Created by irfan on 04/12/2020.
//

import Foundation
import UIKit
import Kingfisher

// References --> Code taken from Github page of KingFisher Library
// KingFisher, by default cache images by absolute url, but since, in our case, the url is constantly changing because of HMAC auth and expiry date, hence we are creating a new cache key by ignoring these attributes

@objc
extension UIImageView {
    
    func downloadImage(_ imgUrl: String, isThumbnail: Bool = false, placeholder: UIImage? = UIImage(named: "placeholder"), showIndicator: Bool = true, completion: @escaping (Bool) -> Void) {
        
        if showIndicator {
            self.showActivityIndicator(tintColor: .white)
        }
                
        let url = URL(string: imgUrl)!
        var cacheKey: String?
        
        if isThumbnail {
            // cache key for thumbnail, since absolute url are constantly changing, hence we need a new key to maintain cache
            cacheKey = imgUrl.components(separatedBy: "thumbnail?").first
        } else {
            // cache key for images, since absolute url are constantly changing, hence we need a new key to maintain cache
            cacheKey = imgUrl.components(separatedBy: "?AWSAccessKeyId").first
        }
        
        let resource = ImageResource(downloadURL: url, cacheKey: cacheKey)
        let processor = DownsamplingImageProcessor(size: self.bounds.size)
            |> RoundCornerImageProcessor(cornerRadius: 20)
        self.kf.indicatorType = .activity
        self.kf.setImage(
            with: resource,
            placeholder: placeholder,
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ], completionHandler: { result in
                self.hideIndicator()
//                switch result {
//                case .success(let value):
//                    print("Task done for: \(value.source.url?.absoluteString ?? "")")
//                case .failure(let error):
//                    print("Job failed: \(error.localizedDescription)")
//                }
            })
    }
}
