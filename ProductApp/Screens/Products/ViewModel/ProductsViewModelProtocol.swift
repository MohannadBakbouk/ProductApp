//
//  ProductsViewModelProtocol.swift
//  ProductApp
//
//  Created by Mohannad on 08/08/2023.
//

import Foundation
import RxSwift

protocol ProductsViewModelProtocol: BaseViewModelProtocol{
    var products: BehaviorSubject<[ProductViewData]> {get}
    func loadProducts()
}
