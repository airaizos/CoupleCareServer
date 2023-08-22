//
//  File.swift
//  
//
//  Created by Adrian Iraizos Mendoza on 22/8/23.
//

import Vapor
import Fluent


struct CreateTag: AsyncMigration {
    func prepare(on database: Database) async throws {
        try await database.schema(tag)
            .field(.id, .int, .identifier(auto: true))
            .field("name", .string)
            .unique(on: "name")
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema(tag).delete()
    }
}

