//
//  File.swift
//  
//
//  Created by Adrian Iraizos Mendoza on 21/8/23.
//

import Fluent
import Vapor

final class Category: Model, Content {
    static let schema:String = category
    
    @ID(custom: .id) var id: Int?
    @Field(key:"name") var name: String
    
    init() { }
    
    init(id: Int? = nil, name: String) {
        self.id = id
        self.name = name
    }
}
