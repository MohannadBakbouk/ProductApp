//
//  UICollectionView.swift
//  ProductApp
//
//  Created by Mohannad on 09/08/2023.
//

import UIKit

extension UICollectionView{
    func register(_ cellClass: AnyClass){
        register(cellClass, forCellWithReuseIdentifier: String(describing: cellClass.self))
    }
}
