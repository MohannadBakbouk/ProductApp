//
//  UITableView.swift
//  ProductApp
//
//  Created by Mohannad on 09/08/2023.
//

import UIKit

extension UITableView{
    func register(_ cellClass: AnyClass){
        register(cellClass, forCellReuseIdentifier: String(describing: cellClass.self))
    }
    
    func register(mutipleCells: [AnyClass]){
         _ = mutipleCells.map {register($0, forCellReuseIdentifier: String(describing: $0.self))}
    }
    
    func dequeueReusableCell(with cellClass: AnyClass, for indexPath: IndexPath) -> UITableViewCell?{
        dequeueReusableCell(withIdentifier: String(describing: cellClass.self), for: indexPath)
    }
}
