//
//  File.swift
//  
//
//  Created by Adrian Iraizos Mendoza on 22/8/23.
//

import Vapor
import Fluent


struct CreateQuote: AsyncMigration {
    func prepare(on database: Database) async throws {
        try await database.schema(quotes)
            .field(.id, .int, .identifier(auto: true))
            .field("quote", .string)
            .field("author", .string)
            .create()
    }
    func revert(on database: Database) async throws {
        try await database.schema(quotes).delete()
    }
    
}
