//
//  File.swift
//  
//
//  Created by Adrian Iraizos Mendoza on 22/8/23.
//

import Vapor
import Fluent


struct CreateCategory: AsyncMigration {
    func prepare(on database: Database) async throws {
        try await database.schema(category)
            .field(.id, .int, .identifier(auto: true))
            .field("name", .string)
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema(category).delete()
    }
}
