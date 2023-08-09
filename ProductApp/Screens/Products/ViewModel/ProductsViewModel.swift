//
//  ProductsViewModel.swift
//  ProductApp
//
//  Created by Mohannad on 08/08/2023.
//

import Foundation
import RxSwift

final class ProductsViewModel: ProductsViewModelProtocol{
    var disposeBag: DisposeBag
    var isLoading: PublishSubject<Bool>
    var error: BehaviorSubject<ErrorDataView?>
    var products: BehaviorSubject<[ProductViewData]>
    var refreshTrigger: PublishSubject<Void>
    let service: ProductServiceProtocol
    
    init(service: ProductServiceProtocol) {
        self.disposeBag = DisposeBag()
        self.isLoading = PublishSubject()
        self.error = BehaviorSubject(value: nil)
        self.products = BehaviorSubject(value: [])
        self.refreshTrigger = PublishSubject()
        self.service = service
        subscribingToRefreshTrigger()
    }
    
    func loadProducts() {
        isLoading.onNext(true)
        service.getProducts()
        .subscribe(onNext: {[weak self] items in
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
}
