//
//  File.swift
//  
//
//  Created by Adrian Iraizos Mendoza on 31/10/23.
//

import Fluent
import Vapor

final class SuggestedActionTags: Model, Content {
    static let schema: String = suggestedActionTags
    
    @ID(custom: .id) var id: Int?
    @Parent(key: "suggested_tag") var actionTag: SuggestedTag
    @Parent(key: "suggested_action") var suggestedAction: SuggestedAction
    
    init() {}
    
    init(id: Int? = nil, action: SuggestedAction, tag: SuggestedTag) throws {
        self.id = id
        self.$suggestedAction.id = try action.requireID()
        self.$actionTag.id =  try tag.requireID()
    }
}


extension SuggestedActionTags {
    static func newActionTag(_ item: SuggestedAction) throws -> [SuggestedActionTags]  {
        
        try item.tags.compactMap { tag in
             try SuggestedActionTags(action: item, tag: tag)
            
        }
        
        
    }
    
}
