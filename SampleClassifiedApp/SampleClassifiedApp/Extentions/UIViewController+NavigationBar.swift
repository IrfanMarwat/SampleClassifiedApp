//
//  UIViewController+NavigationBar.swift
//  SampleClassifiedApp
//
//  Created by irfan on 05/12/2020.
//

import Foundation

@objc
extension UIViewController {
    func setNavigationBarTransparent(tintColor: UIColor) {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.backgroundColor = UIColor.clear
        navigationController?.navigationBar.tintColor = tintColor
                
        let backButton = UIBarButtonItem()
        backButton.title = ""
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton

        if tintColor == UIColor.white {
            navigationController?.navigationBar.barStyle = .black
        } else {
            navigationController?.navigationBar.barStyle = .default
        }
    }
}
