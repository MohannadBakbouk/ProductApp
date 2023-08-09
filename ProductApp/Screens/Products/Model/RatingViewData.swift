//
//  RatingViewData.swift
//  ProductApp
//
//  Created by Mohannad on 09/08/2023.
//

import Foundation

struct RatingViewData: Codable {
    let value: Double
    let count: Int
    var reviewText: String{
        return "(\(count) rating)"
    }
}

extension RatingViewData {
    init(info: Rating) {
        self.value = info.rate ?? 0.0
        self.count = info.count ?? 0
    }
}
