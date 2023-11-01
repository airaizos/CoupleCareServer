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
    @Field(key: "category") var category: String?
    @Field(key: "tags") var tags: String?
    init() {}
    
    init(id: UUID? = nil, hint: String? = nil, instructions: String = "", maxReward: Int? = nil, price: Int? = nil, category: String = "", tags: String = "" ) {
        self.id = id
        self.hint = hint
        self.instructions = instructions
        self.maxReward = maxReward
        self.price = price
        self.category = category
        self.tags = tags
    }
}

extension SuggestedAction {
    
    struct Create: Content, Validatable {

        var hint: String?
        var instructions: String
        var maxReward: Int?
        var price: Int?
        var category: String?
        var tags: String?
    
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
                                category: item.category ?? "",
                                tags: item.tags ?? "")
    }
}


