//
//  TestUtil.swift
//  ProductAppUITests
//
//  Created by Mohannad on 12/08/2023.
//

import Foundation

enum TestUtilError: Error {
    case fileNotFound
}

class TestUtil {
    static func path(for fileName: String, in bundleClass: AnyClass) throws -> String {
        if let path = Bundle(for: bundleClass).path(forResource: fileName, ofType: nil) {
            return path
        } else {
            throw TestUtilError.fileNotFound
        }
    }
}
