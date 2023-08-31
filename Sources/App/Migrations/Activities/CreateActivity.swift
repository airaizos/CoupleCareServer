//
//  File.swift
//  
//
//  Created by Adrian Iraizos Mendoza on 22/8/23.
//

import Vapor
import Fluent


struct CreateActivity: AsyncMigration {
    func prepare(on database: Database) async throws {
        try await database.schema(activity)
            .field(.id, .int, .identifier(auto: true))
            .field("hint", .string)
            .field("instructions", .string)
            .field("maxReward", .int)
            .field("price", .int)
            .field("categoryId", .int, .references(Category.schema, "id"))
            .unique(on: "hint")
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema(activity).delete()
    }
}
