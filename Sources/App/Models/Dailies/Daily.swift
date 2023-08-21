//
//  File.swift
//  
//
//  Created by Adrian Iraizos Mendoza on 21/8/23.
//

import Fluent
import Vapor


final class Daily: Model, Content {
    static let schema: String = daily
    init() {}
    
    @ID(custom: .id) var id: Int?
    @Field(key: "instructions") var instructions: String
    
    @Siblings(through: DailyTag.self, from: \.$daily, to: \.$tag) public var tags: [Tag]
    
    init(id: Int? = nil, instructions: String) {
        self.id = id
        self.instructions = instructions
        
    }
    
}
