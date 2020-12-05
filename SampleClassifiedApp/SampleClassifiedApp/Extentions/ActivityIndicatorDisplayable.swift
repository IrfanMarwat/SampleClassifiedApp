//
//  ActivityIndicatorDisplayable.swift
//  SampleClassifiedApp
//
//  Created by irfan on 04/12/2020.
//

import Foundation
import UIKit

struct AssociatedKeys {
    static var indicator: UInt8 = 0
}

extension UIView {
    
    var activityIndicator : UIActivityIndicatorView? {
        
        get {
            guard let indicator = objc_getAssociatedObject(self, &AssociatedKeys.indicator) as? UIActivityIndicatorView else  {
                return nil
            }
            
            return indicator
        }
        
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.indicator, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    func showActivityIndicator(_ style: UIActivityIndicatorView.Style = UIActivityIndicatorView.Style.medium, tintColor: UIColor? = nil, title: String? = nil) {
        
        DispatchQueue.main.async { [weak self] in
            
            guard let `self` = self else {
                return
            }
            
            self.activityIndicator = UIActivityIndicatorView(style: style)
            
            guard let activityIndicator = self.activityIndicator else {
                return
            }
            
            self.addSubview(activityIndicator)
            
            self.activityIndicator?.hidesWhenStopped = true
            activityIndicator.center = self.center
            if let color = tintColor {
                activityIndicator.color = color
            }
            activityIndicator.startAnimating()
        }
    }
    
    func hideIndicator() {
        
        DispatchQueue.main.async { [weak self] in
            
            guard let `self` = self else {
                return
            }
            
            self.activityIndicator?.stopAnimating()
        }
    }
}
