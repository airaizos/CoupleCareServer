//
//  File.swift
//
//
//  Created by Adrian Iraizos Mendoza on 31/10/23.
//

import Fluent
import Vapor

final class SuggestedTag: Model, Content {
    static let schema: String  = suggestedTag
    
    @ID(custom: .id) var id: Int?
    @Field(key: "name") var name: String
    @Siblings(through: SuggestedActionTags.self, from: \.$actionTag, to: \.$suggestedAction) public var suggestedActions: [SuggestedAction]
    
    init() { }
    
    init(id: Int? = nil, name: String) {
        self.id = id
        self.name = name
    }
    
}
