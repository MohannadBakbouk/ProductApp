//
//  FiltersViewModelProtocol.swift
//  ProductApp
//
//  Created by Mohannad on 09/08/2023.
//

import Foundation
import RxSwift
import RxCocoa

protocol FiltersViewModelProtocol: BaseViewModelProtocol{
    //Input events
    var selectedCategory: BehaviorRelay<Category?>{get}
    var selectedSortMethod: BehaviorRelay<SortMethod?>{get}
    var selectedParams: FilterParams{get}
}
