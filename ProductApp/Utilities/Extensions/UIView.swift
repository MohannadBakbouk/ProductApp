//
//  UIView.swift
//  ProductApp
//
//  Created by Mohannad on 08/08/2023.
//

import UIKit

extension UIView {
    func addSubviews(contentOf items: [UIView]){
        _ = items.map{addSubview($0)}
    }
}
