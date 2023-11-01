//
//  File.swift
//  
//
//  Created by Adrian Iraizos Mendoza on 31/10/23.
//

import Fluent
import Vapor

struct CreateSuggestedActionTags: AsyncMigration {
    
    func prepare(on database: Database) async throws {
        try await database.schema(suggestedActionTags)
            .field(.id, .int, .identifier(auto: true))
            .field("suggested_action", .int, .references(SuggestedAction.schema, "id"))
            .field("suggested_tag", .int, .references(SuggestedTag.schema, "id"))
            .unique(on: "suggested_action","suggested_tag")
            .create()
    }
    
    func revert(on database: Database) async throws {
        try await database.schema(suggestedActionTags).delete()
    }
}
