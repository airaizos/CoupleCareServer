//
//  File.swift
//  
//
//  Created by Adrian Iraizos Mendoza on 22/8/23.
//

import Vapor
import Fluent


struct ControllerCoupleCareServer: RouteCollection {
    let queryDb = CCQueryDB(dbName: DatabaseID.sqlite,apiGroup: "couplecare")
    
    func boot(routes: RoutesBuilder) throws {
        try queryDb.boot(api: queryDb.apiGroup, routes: routes)
    }
    
    
}
