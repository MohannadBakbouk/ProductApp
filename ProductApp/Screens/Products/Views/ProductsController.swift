//
//  ProductsController.swift
//  ProductApp
//
//  Created by Mohannad on 08/08/2023.
//

import UIKit

final class ProductsController: BaseViewController<ProductsViewModel> {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .darkGray
        ProductService().getProducts()
        .subscribe(onNext: { event in
            print(event.count)
        }, onError : { error in
            print((error as? NetworkError)?.message)
        }).disposed(by: disposeBag)
    }
}
