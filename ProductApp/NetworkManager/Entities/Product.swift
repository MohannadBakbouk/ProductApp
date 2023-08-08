//
//  Product.swift
//  ProductApp
//
//  Created by Mohannad on 08/08/2023.
//

import Foundation

struct Product: Codable {
    let id          : Int?
    let title       : String?
    let price       : Double?
    let description : String?
    let category    : Category?
    let image       : String?
    let rating      : Rating?
    
    enum CodingKeys: String, CodingKey {
        case id          = "id"
        case title       = "title"
        case price       = "price"
        case description = "description"
        case category    = "category"
        case image       = "image"
        case rating      = "rating"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id          = try values.decodeIfPresent(Int.self    , forKey: .id          )
        title       = try values.decodeIfPresent(String.self , forKey: .title       )
        price       = try values.decodeIfPresent(Double.self , forKey: .price       )
        description = try values.decodeIfPresent(String.self , forKey: .description )
        category    = try values.decodeIfPresent(Category.self , forKey: .category  )
        image       = try values.decodeIfPresent(String.self , forKey: .image       )
        rating      = try values.decodeIfPresent(Rating.self , forKey: .rating      )
        
    }
}
