//
//  File.swift
//  
//
//  Created by Adrian Iraizos Mendoza on 21/8/23.
//

import Fluent
import Vapor

final class Activity: Model, Content {
    static let schema:String = activity
    
    @ID(custom: .id) var id: Int?
    @Field(key:"hint") var hint: String
    @Field(key: "instructions") var instructions: String
    @Field(key: "maxReward") var maxReward: Int
    @Field(key: "price") var price: Int
    @Parent(key: "categoryId") var categoryId: Category
    @Siblings(through: ActivityTag.self, from:  \.$activity, to: \.$tag) public var tags: [Tag]
    
    
    init() { }
    
    init(id: Int? = nil, hint: String, instructions: String, maxReward: Int = 3, price: Int = 5, categoryId: Int) {
        self.id = id
        self.hint = hint
        self.instructions = instructions
        self.maxReward = maxReward
        self.price = price
        self.$categoryId.id = categoryId
    }
}
