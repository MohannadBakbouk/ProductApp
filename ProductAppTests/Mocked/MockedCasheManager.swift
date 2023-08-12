//
//  MockedCasheManager.swift
//  ProductAppTests
//
//  Created by Mohannad on 12/08/2023.
//

import XCTest
import RealmSwift
import Foundation
@testable import ProductApp

class MockedCasheManager: CacheManagerProtocol{
    
    private var dataStore : [String: [Int: Object]]
        
    init() {
        self.dataStore = [:]
    }
    
    func fetch<T>(entity: T.Type) -> [T]? where T : Object {
        return  dataStore[String(describing: T.self)]?.values.compactMap{$0 as? T}
    }
    
    func add<T>(item: T) where T : Object {
        dataStore[String(describing: T.self), default: [:]][item.hashValue] = item
       /* var entity = dataStore[String(describing: T.self), default: [:]]
          entity[item.hashValue] = item
          dataStore[String(describing: T.self)] = entity */
    }
    
    func addBatch<T>(items: [T]) where T : Object {
        _ = items.map{add(item: $0)}
    }
    
    func update<T>(item: T) where T : Object {
        dataStore[String(describing: T.self), default: [:]][item.hashValue] = item
    }
    
    func delete<T>(item: T) where T : Object {
        dataStore[String(describing: T.self)]?[item.hashValue] = nil
    }
    
    func deleteAll<T>(entity: T.Type) where T : Object {
        dataStore[String(describing: T.self)] = nil
    }
    
    func recordsCount<T>(entity: T.Type) -> Int where T : Object {
        return dataStore[String(describing: T.self)]?.count ?? 0
    }
    
    func clearAll() {
        dataStore = [:]
    }
}
