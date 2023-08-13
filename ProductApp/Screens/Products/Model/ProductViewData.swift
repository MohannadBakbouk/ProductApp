//
//  ProductViewData.swift
//  ProductApp
//
//  Created by Mohannad on 09/08/2023.
//

import Foundation

struct ProductViewData{
    let id          : Int
    let title       : String
    let price       : Double
    let description : String
    let category    : Category
    let image       : String
    let rating      : RatingViewData
    var priceWithUnit: String{
        return "\(String(format: "%.2f", price)) €"
    }
    var deliveryNote: String{
        "Free Delivery"
    }
}

extension ProductViewData{
    init(info: Product) {
        self.id  = info.id ?? 0
        self.title = info.title ?? ""
        self.price = info.price ?? 0.0
        self.description = info.description ?? ""
        self.category = info.category ?? .electronics
        self.image = info.image ?? ""
        self.rating = RatingViewData(info: info.rating ?? Rating())
    }
}
