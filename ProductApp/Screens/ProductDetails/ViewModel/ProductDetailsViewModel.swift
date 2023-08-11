//
//  ProductDetailsViewModel.swift
//  ProductApp
//
//  Created by Mohannad on 11/08/2023.
//

import Foundation
import RxSwift
import RxCocoa

final class ProductDetailsViewModel: ProductDetailsViewModelProtocol{
    var disposeBag: DisposeBag
    var isLoading: PublishSubject<Bool>
    var error: BehaviorSubject<ErrorDataView?>
    var productDetails: BehaviorRelay<ProductViewData>
    
    init(info: ProductViewData) {
        self.disposeBag = DisposeBag()
        self.isLoading = PublishSubject()
        self.error = BehaviorSubject(value: nil)
        self.productDetails = BehaviorRelay(value: info)
    }
}
