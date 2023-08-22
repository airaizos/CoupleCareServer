//
//  File.swift
//  
//
//  Created by Adrian Iraizos Mendoza on 22/8/23.
//

import Vapor
import Fluent


struct CreateDaily: AsyncMigration {
    func prepare(on database: Database) async throws {
        try await database.schema(daily)
            .field(.id, .int, .identifier(auto: true))
            .field("instructions", .string)
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema(daily).delete()
    }
}
