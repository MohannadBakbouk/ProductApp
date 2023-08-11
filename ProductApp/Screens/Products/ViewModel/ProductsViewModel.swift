//
//  ProductsViewModel.swift
//  ProductApp
//
//  Created by Mohannad on 08/08/2023.
//

import Foundation
import RxSwift
import RxCocoa

final class ProductsViewModel: ProductsViewModelProtocol{
    var disposeBag: DisposeBag
    var isLoading: PublishSubject<Bool>
    var error: BehaviorSubject<ErrorDataView?>
    var products: BehaviorSubject<[ProductViewData]>
    var refreshTrigger: PublishSubject<Void>
    var selectedFilters: BehaviorSubject<FilterParams?>
    var clearFilters: PublishSubject<Void>
    let service: ProductServiceProtocol
    let cacheManager: CacheManagerProtocol
    var fetchedProducts: [Product]
   
    
    init(service: ProductServiceProtocol,cacheManager: CacheManagerProtocol) {
        self.disposeBag = DisposeBag()
        self.isLoading = PublishSubject()
        self.error = BehaviorSubject(value: nil)
        self.products = BehaviorSubject(value: [])
        self.refreshTrigger = PublishSubject()
        self.selectedFilters = BehaviorSubject(value: nil)
        self.clearFilters = PublishSubject<Void>()
        self.fetchedProducts = []
        self.service = service
        self.cacheManager = cacheManager
        subscribingToRefreshTrigger()
        subscribingToSelectedFilters()
        subscribingToClearFilters()
    }
    
    func loadProducts() {
        isLoading.onNext(true)
        service.getProducts()
        .subscribe(onNext: {[weak self] items in
            self?.fetchedProducts = items
            self?.isLoading.onNext(false)
            self?.products.onNext(items.map{ProductViewData(info: $0)})
        }, onError : { error in
            print((error as? NetworkError)?.message)
        }).disposed(by: disposeBag)
    }
    
    private func subscribingToRefreshTrigger(){
        refreshTrigger.subscribe(onNext:{[weak self]_ in
            self?.loadProducts()
        }).disposed(by: disposeBag)
    }
    
    private func subscribingToSelectedFilters(){
         selectedFilters
        .compactMap{$0}
        .subscribe(onNext:{[weak self] item in
            // write the filter implementation in case i had time
        }).disposed(by: disposeBag)
    }
    
    private func subscribingToClearFilters(){
         clearFilters
        .subscribe(onNext:{[weak self] _ in
            guard let self = self else {return}
            self.selectedFilters.onNext(nil)
            self.products.onNext(self.fetchedProducts.map{ProductViewData(info: $0)})
        }).disposed(by: disposeBag)
    }

}
