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
    //Output 
    var  products: BehaviorSubject<[ProductViewData]> {get}
    var  isRefreshing: BehaviorRelay<Bool>{get}
    //Input
    var  refreshTrigger : PublishSubject<Void> {get}
    var  selectedFilters: BehaviorSubject<FilterParams?> {get}
    var  clearFilters: PublishSubject<Void>{get}
    //Internal
    var loadCachedProductsOrFireError: PublishSubject<NetworkError>{get}
    var cachingProductsTrigger: PublishSubject<[Product]>{get}
    func loadProducts()
}
