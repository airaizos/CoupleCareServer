//
//  File.swift
//  
//
//  Created by Adrian Iraizos Mendoza on 21/8/23.
//

import Fluent
import Vapor

final class Tag: Model, Content {
    static let schema: String = tag
    
    init() {}
    
    @ID(custom: .id)  var id: Int?
    @Field(key: "name") var name: String?
    @Siblings(through: ActivityTag.self, from: \.$tag, to: \.$activity) public var actions: [Activity]
    
    init(id: Int? = nil, name: String? = nil) {
        self.id = id
        self.name = name
    }
    
    
}
