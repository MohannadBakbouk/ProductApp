//
//  ProcessInfo.swift
//  ProductApp
//
//  Created by Mohannad on 12/08/2023.
//

import Foundation

extension ProcessInfo{
    class var isTestingProcess: Bool{
        Self.processInfo.arguments.contains("-uitesting")
    }
}
