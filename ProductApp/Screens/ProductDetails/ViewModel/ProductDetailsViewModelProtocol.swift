//
//  ProductDetailsViewModelProtocol.swift
//  ProductApp
//
//  Created by Mohannad on 11/08/2023.
//

import Foundation
import RxCocoa

protocol ProductDetailsViewModelProtocol: BaseViewModelProtocol{
    var productDetails: BehaviorRelay<ProductViewData>{get}
}
