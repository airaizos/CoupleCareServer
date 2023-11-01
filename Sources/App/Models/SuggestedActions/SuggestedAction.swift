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
    
    init(id: UUID? = nil, hint: String? = nil, instructions: String = "", maxReward: Int? = nil, price: Int? = nil, category: Int) {
        self.id = id
        self.hint = hint
        self.instructions = instructions
        self.maxReward = maxReward
        self.price = price
        self.$category.id = category
    }
}

extension SuggestedAction {
    
    struct Create: Content, Validatable {

        var hint: String?
        var instructions: String
        var maxReward: Int?
        var price: Int?
        var category: Int?
        var tags: [SuggestedTag]
    
       static func validations(_ validations: inout Validations) {
         
            validations.add("instructions", as: String.self, is: !.empty)
        }
    }
}


extension SuggestedAction {
    static func newSuggestedAction(_ item: SuggestedAction.Create) -> SuggestedAction {
       SuggestedAction(id: UUID(),
                               hint: item.hint ?? "",
                               instructions: item.instructions,
                               maxReward: item.maxReward ?? 0 ,
                               price: item.price ?? 0,
                               category: item.category ?? 1)
    }
}


