//
//  File.swift
//  
//
//  Created by Adrian Iraizos Mendoza on 27/8/23.
//

import Vapor
import Fluent



struct ControllerCCTestingServer: RouteCollection {
    let queryDb = CCQueryDB(dbName: DatabaseID.testingDB, apiGroup: "testing")
    
    
    func boot(routes: RoutesBuilder) throws {
        try queryDb.boot(api: queryDb.apiGroup, routes: routes)
        
        let tokenAuth = routes.grouped(UserToken.authenticator())
        
        let testing = tokenAuth.grouped("\(queryDb.apiGroup)")
        let fixed = testing.grouped("static")
        
        fixed.get("current", use: currentVersion)
        fixed.get("categories",use: getCategoriesJson)
        fixed.get("image",use: getImage)
        
        let tokenProtected = fixed.grouped(UserToken.authenticator())
        tokenProtected.get("me", use: withToken)
    }
    
    func withToken(req:Request) async throws -> HTTPStatus {
        let user = try await getContentFrom(file: "User.json", type: User.self)
       // let user = try req.auth.require(User.self)
        return .ok
        
    }
    
    //MARK - Métodos solo de testing
    func getContentFrom<T:Content>(file: String, type: T.Type) async throws -> T {
        let path = URL(string: "http://127.0.0.1:8080/\(file)")!
        let data = try Data(contentsOf: path, options: .alwaysMapped)
        let content = try JSONDecoder().decode(type.self, from: data)
        return content
    }
    
    //MARK: Testing GetURL Jsons
    
    func currentVersion(req:Request) async throws -> Double {
        99.9
    }
    
    func getCategoriesJson(req: Vapor.Request) async throws -> [Category] {
        try await getContentFrom(file: "Categories.json", type: [Category].self)
    }

    func getImage(req:Request) async throws -> View {
        return try await req.view.render("image", ["image":"http://127.0.0.1:8080/image.png"])
    }

    
 
}


