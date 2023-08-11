//
//  CacheManagerProtocol.swift
//  ProductApp
//
//  Created by Mohannad on 11/08/2023.
//

import RealmSwift

protocol CacheManagerProtocol{
    func fetch<T: Object>(entity: T.Type) -> [T]?
    func add<T: Object> (item: T)
    func addBatch<T: Object>(items: [T])
    func update<T: Object> (item: T)
    func delete<T: Object>(item: T)
    func deleteAll<T: Object>(entity: T.Type)
    func recordsCount<T: Object>(entity: T.Type) -> Int
    func clearAll()
}



