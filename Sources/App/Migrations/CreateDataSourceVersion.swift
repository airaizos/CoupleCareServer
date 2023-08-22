//
//  File.swift
//  
//
//  Created by Adrian Iraizos Mendoza on 22/8/23.
//

import Vapor
import Fluent


struct CreateDataSourceVersion: AsyncMigration {
    func prepare(on database: Database) async throws {
        try await database.schema(dataSourceVersion)
            .field(.id, .int, .identifier(auto: true))
            .field("current", .double)
            .unique(on: "current")
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema(dataSourceVersion).delete()
    }
}
