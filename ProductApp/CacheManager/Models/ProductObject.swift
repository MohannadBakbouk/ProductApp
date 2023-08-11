//
//  ProductObject.swift
//  ProductApp
//
//  Created by Mohannad on 11/08/2023.
//

import RealmSwift

class ProductObject: Object{
    @objc dynamic var id: Int = 0
    @objc dynamic var title: String = ""
    @objc dynamic var details: String = ""
    @objc dynamic var category: String = ""
    @objc dynamic var price: Double = 0.0
    @objc dynamic var rating: Double = 0.0
    @objc dynamic var reviewCount: Int = 0
    @objc dynamic var image: String = ""
    override static func primaryKey() -> String? {
        return "id"
    }
}


extension ProductObject{
    convenience init(info: Product) {
        self.init()
       id = info.id ?? 0
       title = info.title ?? ""
       details = info.description ?? ""
       category = info.category?.rawValue ?? ""
       price = info.price ?? 0.0
       rating = info.rating?.rate ?? 0.0
       reviewCount = info.rating?.count ?? 0
       image = info.image ?? ""
   }
}
