//
//  ProductsViewModel.swift
//  ProductApp
//
//  Created by Mohannad on 08/08/2023.
//

import Foundation
import RxSwift
import RxCocoa
import RealmSwift

final class ProductsViewModel: ProductsViewModelProtocol{
    var disposeBag: DisposeBag
    //Output events
    var isLoading: PublishSubject<Bool>
    var isRefreshing: BehaviorRelay<Bool>
    var error: BehaviorSubject<ErrorDataView?>
    var products: BehaviorSubject<[ProductViewData]>
    //Input events
    var refreshTrigger: PublishSubject<Void>
    var selectedFilters: BehaviorSubject<FilterParams?>
    var clearFilters: PublishSubject<Void>
    //Internal events
    var loadCachedProductsOrFireError: PublishSubject<NetworkError>
    var cachingProductsTrigger: PublishSubject<[Product]>
    
    let service: ProductServiceProtocol
    let cacheManager: CacheManagerProtocol
    var allProducts: [Product] 
   
    
    init(service: ProductServiceProtocol,cacheManager: CacheManagerProtocol) {
        self.disposeBag = DisposeBag()
        self.isLoading = PublishSubject()
        self.isRefreshing = BehaviorRelay(value: false)
        self.error = BehaviorSubject(value: nil)
        self.products = BehaviorSubject(value: [])
        self.refreshTrigger = PublishSubject()
        self.selectedFilters = BehaviorSubject(value: nil)
        self.clearFilters = PublishSubject<Void>()
        self.loadCachedProductsOrFireError = PublishSubject()
        self.cachingProductsTrigger = PublishSubject()
        self.allProducts = []
        self.service = service
        self.cacheManager = cacheManager
        subscribingToRefreshTrigger()
        subscribingToSelectedFilters()
        subscribingToClearFilters()
        subscribingToloadCachedProductsOrFireError()
        subscribingToCacheProductsTrigger()
    }
    
    func loadProducts() {
        isLoading.onNext(true)
        service.getProducts()
        .subscribe(onNext: {[weak self] items in
            self?.allProducts = items
            self?.isLoading.onNext(false)
            self?.products.onNext(items.map{ProductViewData(info: $0)})
            self?.cachingProductsTrigger.onNext(items)
            self?.isRefreshing.accept(false)
        }, onError : {[weak self] error in
            let networkError = error as? NetworkError ?? .errorOccured
            self?.loadCachedProductsOrFireError.onNext(networkError)
        }).disposed(by: disposeBag)
    }
    
    private func subscribingToRefreshTrigger(){
        refreshTrigger.subscribe(onNext:{[weak self]_ in
            self?.isRefreshing.accept(true)
            self?.loadProducts()
        }).disposed(by: disposeBag)
    }
    
    private func subscribingToSelectedFilters(){
         selectedFilters
        .compactMap{$0}
        .subscribe(onNext:{[weak self] params in
            guard let self = self else {return}
            let items = params.category != nil ? allProducts.filter{$0.category == params.category!} : allProducts
            var productItems = items.map{ProductViewData(info: $0)}
            productItems = params.sortMethod != nil ? self.sortProducts(method: params.sortMethod!, items: productItems) : productItems
            self.products.onNext(productItems)
        }).disposed(by: disposeBag)
    }
    
    private func subscribingToClearFilters(){
         clearFilters
        .subscribe(onNext:{[weak self] _ in
            guard let self = self else {return}
            self.selectedFilters.onNext(nil)
            self.products.onNext(self.allProducts.map{ProductViewData(info: $0)})
        }).disposed(by: disposeBag)
    }
    
    private func subscribingToloadCachedProductsOrFireError(){
         loadCachedProductsOrFireError
        .subscribe(onNext: {[weak self] error in
            guard let self = self  else {return}
            guard let items = self.cacheManager.fetch(entity: ProductObject.self) , items.count > 0 else {
                  self.isLoading.onNext(false)
                  self.isRefreshing.accept(false)
                  self.error.onNext(ErrorDataView(with: error))
                  return
            }
            let products = items.map{Product(info: $0)}
            self.allProducts = products
            self.products.onNext(products.map{ProductViewData(info: $0)})
            self.isLoading.onNext(false)
        }).disposed(by: disposeBag)
    }
    
    private func subscribingToCacheProductsTrigger(){
        cachingProductsTrigger
        .subscribe(onNext:{[weak self] items in
            self?.cacheManager.addBatch(items: items.map{ProductObject(info: $0)})
        }).disposed(by: disposeBag)
    }
}


extension ProductsViewModel{
    func sortProducts(method: SortMethod, items: [ProductViewData]) -> [ProductViewData]{
        var sorted = items
        sorted.sort{ lhs, rhs in
            switch method{
                case .topRated:       return lhs.rating.value > rhs.rating.value
                case .nearest:        return lhs.id < rhs.id
                case .highToLow:      return lhs.price > rhs.price
                case .lowToHigh:      return lhs.price < rhs.price
            }
        }
        return sorted
    }
}
