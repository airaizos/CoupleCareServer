//
//  File.swift
//  
//
//  Created by Adrian Iraizos Mendoza on 4/9/23.
//

import Vapor
import Fluent



struct CCQueryDB  {
    let dbName: DatabaseID
    
    
    
    
    
    
    
    //MARK: - Random
    func getRandomDaily(req:Request) async throws -> Daily {
        let total = try await Daily
            .query(on: req.db(dbName))
            .count()
        if total == 0 {
            throw Abort(.noContent)
        } else {
            
            var random = SystemRandomNumberGenerator()
            let randomId = Int(random.next(upperBound: UInt(total)))
            
            if let daily = try await Daily
                .query(on: req.db(dbName))
                .filter(\.$id == randomId)
                .first() {
                return daily
            } else {
                throw Abort(.noContent)
            }
        }
    }
}
