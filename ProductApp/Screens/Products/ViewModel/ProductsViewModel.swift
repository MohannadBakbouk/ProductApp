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
    let service: ProductServiceProtocol
    
    init(service: ProductServiceProtocol) {
        self.disposeBag = DisposeBag()
        self.isLoading = PublishSubject()
        self.error = BehaviorSubject(value: nil)
        self.products = BehaviorSubject(value: [])
        self.service = service
    }
    
    func loadProducts() {
        service.getProducts()
        .subscribe(onNext: {[weak self] items in
            self?.products.onNext(items.map{ProductViewData(info: $0)})
        }, onError : { error in
            print((error as? NetworkError)?.message)
        }).disposed(by: disposeBag)
    }
}
