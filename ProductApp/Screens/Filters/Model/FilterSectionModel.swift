//
//  FilterSection.swift
//  ProductApp
//
//  Created by Mohannad on 10/08/2023.
//

import Foundation
import RxDataSources


enum FilterSectionModel{
    case buttons(items: [FilterItem])
    case catgories(items: [FilterItem])
    case sortMethod(items: [FilterItem])
}

extension FilterSectionModel: SectionModelType{

    var items: [FilterItem] {
        switch self {
        case .buttons(let items):
            return items.map { $0 }
        case .catgories(let items):
            return items.map { $0 }
        case .sortMethod(let items):
            return items.map { $0 }
        }
    }
    
    init(original: FilterSectionModel, items: [FilterItem]) {
        switch original {
            case .buttons(let items):
                self = .buttons(items: items)
            case .catgories(let items):
                self = .catgories(items: items)
            case .sortMethod(let items):
                self = .sortMethod(items: items)
        }
    }
}
