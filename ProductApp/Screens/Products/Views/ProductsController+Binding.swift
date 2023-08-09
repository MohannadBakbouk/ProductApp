//
//  ProductsController+Binding.swift
//  ProductApp
//
//  Created by Mohannad on 09/08/2023.
//

import Foundation
import RxCocoa
import RxDataSources

extension ProductsController{
    func bindingCollectionViewDataSource(){
        viewModel.products.map { items -> [SectionModel] in
            [SectionModel(model: "", items: items)]
        }
        .bind(to: collectionView.rx.items(dataSource: collectionDataSource))
        .disposed(by: disposeBag)
    }
    
    func bindingRefreshControl(){
        refreshControl.rx.controlEvent(.valueChanged)
        .bind(to: viewModel.refreshTrigger)
        .disposed(by: disposeBag)
    }
    
    func bindingIsLoading(){
        viewModel.isLoading
        .bind(to: refreshControl.rx.isRefreshing)
        .disposed(by: disposeBag)
    }
    
    func bindingFiltersButton(){
        headerView.filtersButtonTapped
        .subscribe(onNext: { _ in
             print("filters tapped")
        }).disposed(by: disposeBag)
    }
}
