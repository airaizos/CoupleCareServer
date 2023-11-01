//
//  File.swift
//  
//
//  Created by Adrian Iraizos Mendoza on 31/10/23.
//

import Fluent
import Vapor

struct CreateSuggestedTag: AsyncMigration {
    func prepare(on database: Database) async throws {
        try await database.schema(suggestedActionTags)
            .field(.id, .int, .identifier(auto: true))
            .field("name", .string)
            .create()
    }
    
    func revert(on database: Database) async throws {
        try await database.schema(suggestedActionTags).delete()
    }
}
