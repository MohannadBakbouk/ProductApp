//
//  Rating.swift
//  ProductApp
//
//  Created by Mohannad on 08/08/2023.
//

import Foundation

struct Rating: Codable {
    let rate: Double?
    let count: Int?
    
    enum CodingKeys: String, CodingKey {
        case rate  = "rate"
        case count = "count"
    }
    
    init(from decoder: Decoder) throws {
      let values = try decoder.container(keyedBy: CodingKeys.self)
      rate  = try values.decodeIfPresent(Double.self, forKey: .rate)
      count = try values.decodeIfPresent(Int.self, forKey: .count)
    }
    
    init() {
        self.rate   = 0.0
        self.count  = 0
    }
}
