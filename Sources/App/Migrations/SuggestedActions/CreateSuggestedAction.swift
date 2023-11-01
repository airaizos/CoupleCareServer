//
//  File.swift
//  
//
//  Created by Adrian Iraizos Mendoza on 31/10/23.
//

import Vapor
import Fluent

struct CreateSuggestedAction: AsyncMigration {
    func prepare(on database: Database) async throws {
        try await database.schema(suggestedAction)
            .field(.id, .uuid, .identifier(auto: true))
            .field("hint", .string)
            .field("instructions", .string)
            .field("maxReward", .int)
            .field("price", .int)
            .field("category", .string)
            .field("tags", .string)
            .create()
    }
    
    func revert(on database: Database) async throws {
        try await database.schema(suggestedAction).delete()
    }
    
    
}
