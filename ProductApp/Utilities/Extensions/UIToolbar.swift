//
//  UIToolbar.swift
//  ProductApp
//
//  Created by Mohannad on 09/08/2023.
//

import UIKit

extension UIToolbar {
    convenience init(items: [UIBarButtonItem]){
        self.init()
        self.items = items
        self.sizeToFit()
    }
}
