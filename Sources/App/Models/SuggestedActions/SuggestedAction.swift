//
//  File.swift
//  
//
//  Created by Adrian Iraizos Mendoza on 31/10/23.
//

import Fluent
import Vapor

final class SuggestedAction: Model, Content {
    static let schema: String = suggestedAction
    
    @ID(custom: .id) var id: UUID?
    @Field(key: "hint") var hint: String?
    @Field(key: "instructions") var instructions: String
    @Field(key: "maxReward") var maxReward: Int?
    @Field(key: "price") var price: Int?
    @Parent(key: "category") var category: Category

    @Siblings(through: SuggestedActionTags.self, from: \.$suggestedAction, to: \.$actionTag) public var tags: [SuggestedTag]
    
    init() {}
    
    init(id: UUID? = nil, hint: String? = nil, instructions: String = "", maxReward: Int? = nil, price: Int? = nil, category: Category) {
        self.id = id
        self.hint = hint
        self.instructions = instructions
        self.maxReward = maxReward
        self.price = price
        self.category = category
    }
}





