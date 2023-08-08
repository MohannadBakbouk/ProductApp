//
//  String.swift
//  ProductApp
//
//  Created by Mohannad on 08/08/2023.
//

import Foundation

extension String {
    func asURL () -> URL?{
        return URL(string: self)
    }
}



