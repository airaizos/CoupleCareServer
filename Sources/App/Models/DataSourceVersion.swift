//
//  File.swift
//  
//
//  Created by Adrian Iraizos Mendoza on 22/8/23.
//

import Fluent
import Vapor

final class DataSourceVersion: Model, Content {
    static let schema: String = dataSourceVersion
    @ID(custom: .id) var id: Int?
    @Field(key: "current") var current: Double
    
    init() { }
    
    init(id: Int? = nil, current: Double) {
        self.id = id
        self.current = current
    
    }
}
