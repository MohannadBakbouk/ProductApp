//
//  UIFiltersViewProtocol.swift
//  ProductApp
//
//  Created by Mohannad on 10/08/2023.
//

import Foundation
import UIKit
import RxSwift

/* I did define the protocol, enabling me to replace the UIFiltersView easily with any other view, confirms this as well as inherits of UIView  */
protocol UIFiltersViewProtocol: UIView{
    var resetButtonTapped: PublishSubject<Void>{get}
    var filtersButtonTapped: PublishSubject<Void>{get}
    var doneButtonTapped: PublishSubject<Void>{get}
    var selectedCategory: PublishSubject<Category>{get}
    var selectedSortMethod: PublishSubject<SortMethod>{get}
}
