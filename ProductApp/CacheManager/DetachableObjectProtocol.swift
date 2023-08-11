//
//  DetachableObjectProtocol.swift
//  ProductApp
//
//  Created by Mohannad on 11/08/2023.
//

import RealmSwift

protocol DetachableObjectProtocol: AnyObject {
  func detached() -> Self
}

extension Object: DetachableObjectProtocol {
  func detached() -> Self {
    let detached = type(of: self).init()
     _ =  objectSchema.properties.map{ property in
      guard var value = value(forKey: property.name) else {return}
      guard let detachable = value as? DetachableObjectProtocol else {
        return detached.setValue(value, forKey: property.name)
      }
      detached.setValue(detachable.detached(), forKey: property.name)
    }
    return detached
  }
}



