//
//  UINavigationController.swift
//  ProductApp
//
//  Created by Mohannad on 08/08/2023.
//

import UIKit

extension UINavigationController{
    convenience init(hideBar : Bool){
        self.init()
        navigationBar.isHidden = hideBar
    }
}
