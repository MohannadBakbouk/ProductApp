//
//  UIButton.swift
//  ProductApp
//
//  Created by Mohannad on 09/08/2023.
//

import UIKit

extension UIButton{
    func setup(text: String, color: UIColor) -> UIButton{
        self.setTitle(text, for: .normal)
        self.setTitleColor(color, for: .normal)
        return self
    }
}
