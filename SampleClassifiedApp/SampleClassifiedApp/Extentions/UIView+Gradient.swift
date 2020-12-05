//
//  UIView+Gradient.swift
//  SampleClassifiedApp
//
//  Created by irfan on 04/12/2020.
//

import Foundation
import UIKit

@objc
extension UIView {
    func applyGradient(with colours: [UIColor],layerFrame: CGRect = CGRect.zero) {
        let gradient = CAGradientLayer()
        
        if let layer = self.layer.sublayers?[0] as? CAGradientLayer {
            layer.removeFromSuperlayer()
        }
        
        gradient.frame =  layerFrame == CGRect.zero ? self.bounds : layerFrame
        gradient.colors = colours.map { $0.cgColor }
        gradient.startPoint = CGPoint.init(x: 0.0,y: 0.0)
        gradient.endPoint = CGPoint(x: 0.0,y: 1.0)
        self.layer.insertSublayer(gradient, at: 0)
    }
}
