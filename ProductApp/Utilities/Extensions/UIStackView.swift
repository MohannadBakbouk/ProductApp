//
//  UIStackView.swift
//  ProductApp
//
//  Created by Mohannad on 09/08/2023.
//

import UIKit

extension UIStackView {
    func addArrangedSubviews(contentOf items: [UIView]){
        _ = items.map{addArrangedSubview($0)}
    }
}
