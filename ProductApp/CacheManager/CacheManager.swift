//
//  CacheManager.swift
//  ProductApp
//
//  Created by Mohannad on 11/08/2023.
//

import Foundation
import RealmSwift

final class CacheManager: CacheManagerProtocol{
    
    private let realmStore: Realm?
    
    init(configs: Realm.Configuration = Realm.Configuration(deleteRealmIfMigrationNeeded: true)) {
        self.realmStore = try? Realm(configuration: configs)
    }
    
    func add<T>(item: T) where T: Object {
        guard let realm = realmStore else {return}
        try? realm.write{
            realm.add(item, update: .modified)
        }
    }
    
    func addBatch<T>(items: [T]) where T: Object {
        guard let realm = realmStore else {return}
        _ = try? realm.write{
            items.map{realm.add($0, update: .modified)}
        }
    }
    
    func update<T>(item: T) where T: Object {
        add(item: item)
    }

    func fetch<T>(entity: T.Type) -> [T]? where T: Object {
        guard let realm = realmStore else {return nil}
        return realm.objects(entity).map{$0.detached()}
    }
    
    func delete<T>(item: T) where T: Object {
        guard let realm = realmStore else {return}
        _ = try? realm.write{
            realm.delete(item)
        }
    }
    
    func deleteAll<T>(entity: T.Type) where T: Object {
        guard let realm = realmStore else {return}
        _ = try? realm.write{
            realm.delete(realm.objects(entity))
        }
    }
    
    func recordsCount<T>(entity: T.Type) -> Int where T : Object {
        guard let realm = realmStore else {return 0}
        return realm.objects(entity).count
    }
    
    func clearAll() {
        guard let realm = realmStore else {return}
        _ = try? realm.write{
            realm.deleteAll()
        }
    }
}


