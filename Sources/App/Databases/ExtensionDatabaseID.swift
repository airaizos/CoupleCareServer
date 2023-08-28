//
//  File.swift
//  
//
//  Created by Adrian Iraizos Mendoza on 28/8/23.
//

import Vapor
import Fluent


extension DatabaseID {
    static var testingDB: DatabaseID {
        return .init(string: "testingDB")
    }
}
