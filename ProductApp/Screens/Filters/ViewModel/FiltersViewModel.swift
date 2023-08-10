//
//  FiltersViewModel.swift
//  ProductApp
//
//  Created by Mohannad on 09/08/2023.
//

import Foundation
import RxSwift
import RxCocoa

typealias FilterParams = (category: Category?, sortMethod: SortMethod?)

final class FiltersViewModel: FiltersViewModelProtocol{
    var disposeBag: DisposeBag
    var isLoading: PublishSubject<Bool>
    var error: BehaviorSubject<ErrorDataView?>
    var selectedCategory: BehaviorRelay<Category?>
    var selectedSortMethod: BehaviorRelay<SortMethod?>
    var selectedParams: FilterParams{
        return FilterParams(selectedCategory.value, selectedSortMethod.value)
    }
    
    init() {
        self.disposeBag = DisposeBag()
        self.isLoading = PublishSubject()
        self.error = BehaviorSubject(value: nil)
        self.selectedCategory = BehaviorRelay(value: nil)
        self.selectedSortMethod = BehaviorRelay(value: nil)
    }
    
}
