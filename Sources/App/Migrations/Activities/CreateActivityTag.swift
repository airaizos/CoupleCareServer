//
//  File.swift
//  
//
//  Created by Adrian Iraizos Mendoza on 22/8/23.
//

import Vapor
import Fluent

struct CreateActivityTag: AsyncMigration {
    func prepare(on database: Database) async throws {
        try await database.schema(activityTag)
            .field(.id, .int, .identifier(auto: true))
            .field("activity_id", .int, .references(Daily.schema, "id"))
            .field("tag_id", .int, .references(Tag.schema, "id"))
            .unique(on: "activity_id","tag_id")
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema(activityTag).delete()
    }
}

