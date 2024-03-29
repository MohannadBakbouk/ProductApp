//
//  ProductsController+Binding.swift
//  ProductApp
//
//  Created by Mohannad on 09/08/2023.
//

import Foundation
import RxCocoa
import RxSwift
import RxDataSources

extension ProductsController{
    func bindingCollectionViewDataSource(){
        /* It might be "setMessage" func has been called to display an error so I wanna clear that */
        viewModel.products
        .subscribe(onNext:{[weak self] _ in
            self?.collectionView.clearMessage()
        }).disposed(by: disposeBag)
        
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
    
    func bindingIsRefreshing(){
         viewModel.isRefreshing
        .bind(to: refreshControl.rx.isRefreshing)
        .disposed(by: disposeBag)
    }
    
    func bindingIsLoading(){
        viewModel.isLoading
        .subscribe(onNext:{[weak self] status in
            guard !(self?.viewModel.isRefreshing.value ?? true) else {return}
            _ = status ? self?.activityIndicatorView.startAnimating() : self?.activityIndicatorView.stopAnimating()
        }).disposed(by: disposeBag)
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
    
    /* Since caching was integrated so it wont be able to test this unless you turn off the internet connection and reinstall the app */
    func bindingErrorMessage(){
        viewModel.error
        .observe(on: MainScheduler.instance)
        .compactMap{$0}
        .subscribe(onNext: {[weak self] error in
            self?.collectionView.setMessage(error.message, icon: error.icon)
        }).disposed(by: disposeBag)
    }
}
