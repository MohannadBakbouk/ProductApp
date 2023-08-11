//
//  ProductsViewModelProtocol.swift
//  ProductApp
//
//  Created by Mohannad on 08/08/2023.
//

import Foundation
import RxSwift
import RxCocoa

protocol ProductsViewModelProtocol: BaseViewModelProtocol{
    var  products: BehaviorSubject<[ProductViewData]> {get}
    var  isRefreshing: BehaviorRelay<Bool>{get}
    var  refreshTrigger : PublishSubject<Void> {get}
    var  selectedFilters: BehaviorSubject<FilterParams?> {get}
    var  clearFilters: PublishSubject<Void> {get}
    func loadProducts()
}
