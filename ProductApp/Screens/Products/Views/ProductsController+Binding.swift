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
        .subscribe(onNext: {[weak self] _ in
            (self?.coordinator as? MainCoordinator)?.showFilters()
        }).disposed(by: disposeBag)
    }
    
    func bindingSelectedFilterParams(){
        NotificationCenter.default.rx
        .notification(.selectedFilters)
        .subscribe(onNext:{[weak self] info in
            self?.viewModel.selectedFilters.onNext(info.object as? FilterParams)
        }).disposed(by: disposeBag)
    }
    
    func bindingClearSelectedFilters(){
        NotificationCenter.default.rx
        .notification(.clearFilters)
        .subscribe(onNext:{[weak self] _ in
            self?.viewModel.clearFilters.onNext(())
        }).disposed(by: disposeBag)
    }
    
    func bindingCollectionSelectItem(){
        collectionView.rx.modelSelected(ProductViewData.self)
       .subscribe(onNext: {[weak self] selectedItem in
           (self?.coordinator as? MainCoordinator)?.showProductsDetails(info: selectedItem)
       }).disposed(by: disposeBag)
    }
}
