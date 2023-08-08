//
//  BaseViewModelProtocol.swift
//  ProductApp
//
//  Created by Mohannad on 08/08/2023.
//

import Foundation
import RxSwift

protocol BaseViewModelProtocol  {
    var disposeBag: DisposeBag {get}
    var isLoading: PublishSubject<Bool>{get}
    var error: BehaviorSubject<ErrorDataView?> {get}
}

class BaseViewModel: BaseViewModelProtocol{
    var disposeBag = DisposeBag()
    var isLoading = PublishSubject<Bool>()
    var error = BehaviorSubject<ErrorDataView?>(value: nil)
}
