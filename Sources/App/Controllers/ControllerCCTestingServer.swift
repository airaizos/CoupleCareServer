//
//  File.swift
//  
//
//  Created by Adrian Iraizos Mendoza on 27/8/23.
//

import Vapor
import Fluent



struct ControllerCCTestingServer: RouteCollection, ControllerCCEndPoints {

    func boot(routes: RoutesBuilder) throws {
        let api = routes.grouped("testing")
        
        api.get("currentversion", use: currentVersion)
        api.get("categories", use: getCategories)
        api.get("tags",use: getTags)
        api.get("activities", use: getActivities)
        api.get("activitiesdetail", use: getActivitiesDetail)
        api.get("activitytags", use: getActivityTags)
        api.get("dailies", use: getDailies)
        api.get("dailiesdetail", use: getDailiesDetail)
        api.get("dailytags", use: getDailyTags)
        api.get("quotes", use: getQuotes)
        api.get("image", use:getImage)
        
        
        let latest = api.grouped("latest")
        latest.get("activities",":id", use: getLatestActivities)
        latest.get("quotes",":id", use: getLatestQuotes)
        latest.get("categories",":id", use: getLatestCategories)
        latest.get("dailies",":id", use: getLatestDailies)
        latest.get("tags", ":id", use: getLatestTags)
 
    }
    
    //MARK - Métodos Compartidos
    func getContentFrom<T:Content>(file: String, type: T.Type) async throws -> T {
        let path = URL(string: "http://127.0.0.1:8080/\(file)")!
        let data = try Data(contentsOf: path, options: .alwaysMapped)
        let content = try JSONDecoder().decode(type.self, from: data)
        return content
    }
    
    //MARK: Testing GetURSL
    
    func currentVersion(req:Request) async throws -> Double {
        99.9
    }
    
    func getCategories(req: Vapor.Request) async throws -> [Category] {
        try await getContentFrom(file: "Categories.json", type: [Category].self)
    }
    
    func getTags(req: Vapor.Request) async throws -> [Tag] {
        try await getContentFrom(file: "Tags.json", type: [Tag].self)
    }
    
    func getQuotes(req: Vapor.Request) async throws -> [Quote] {
        try await getContentFrom(file: "Quotes.json", type: [Quote].self)
    }
    
    func getActivities(req: Vapor.Request) async throws -> [Activity] {
        try await getContentFrom(file: "Activities.json", type: [Activity].self)
    }
    
    func getActivitiesDetail(req: Vapor.Request) async throws -> [Activity] {
        try await getContentFrom(file: "Activities.json", type: [Activity].self)
    }
    
    func getActivityTags(req: Vapor.Request) async throws -> [ActivityTag] {
        try await getContentFrom(file: "ActivityTags.json", type: [ActivityTag].self)
    }
    
    func getDailies(req: Vapor.Request) async throws -> [Daily] {
        try await getContentFrom(file: "Dailies.json", type: [Daily].self)
    }
    
    func getDailiesDetail(req: Vapor.Request) async throws -> [Daily] {
        try await getContentFrom(file: "Dailiesdetail.json", type: [Daily].self)
    }
    
    func getDailyTags(req: Vapor.Request) async throws -> [DailyTag] {
        try await getContentFrom(file: "DailyTags.json", type: [DailyTag].self)
    }
    
    func getImage(req:Request) async throws -> View {
        return try await req.view.render("image", ["image":"http://127.0.0.1:8080/image.png"])
    }
    
    
    //MARK: Registros filtrados
    
    
    func getLatestTags(req: Vapor.Request) async throws -> [Tag] {
        guard let id = req.parameters.get("id", as: Int.self) else {
            throw Abort(.badRequest)
        }
        
        if id < 0 {
            let tags =  try await getContentFrom(file: "Tags.json", type: [Tag].self)
            return tags.filter { ($0.id ?? 0) >= -id  }
        } else {
            return try await Tag
                .query(on: req.db(DatabaseID.testingDB))
                .filter(\.$id >= id)
                .sort(\.$id)
                .all()
        }
    }
    
    func getLatestActivities(req: Vapor.Request) async throws -> [Activity] {
     
        guard let id = req.parameters.get("id", as: Int.self) else {
            throw Abort(.badRequest)
        }
        
        if id < 0 {
            let activities =  try await getContentFrom(file: "Activities.json", type: [Activity].self)
            return activities.filter { ($0.id ?? 0) >= -id }
        } else {
            return try await Activity
                .query(on: req.db(DatabaseID.testingDB))
                .filter(\.$id >= id)
                .sort(\.$id)
                .all()
        }
    }
    
    func getLatestQuotes(req: Vapor.Request) async throws -> [Quote] {
        guard let id = req.parameters.get("id", as: Int.self) else {
            throw Abort(.badRequest)
        }
        
        if id < 0 {
            let quotes =  try await getContentFrom(file: "Quotes.json", type: [Quote].self)
            return quotes.filter { ($0.id ?? 0) >= -id  }
        } else {
            return try await Quote
                .query(on: req.db(DatabaseID.testingDB))
                .filter(\.$id >= id)
                .sort(\.$id)
                .all()
        }
    }
    
    func getLatestCategories(req: Vapor.Request) async throws -> [Category] {
        guard let id = req.parameters.get("id", as: Int.self) else {
            throw Abort(.badRequest)
        }
        
        if id < 0 {
            let categories =  try await getContentFrom(file: "Categories.json", type: [Category].self)
            return categories.filter { ($0.id ?? 0) >= -id  }
        } else {
            return try await Category
                .query(on: req.db(DatabaseID.testingDB))
                .filter(\.$id >= id)
                .sort(\.$id)
                .all()
        }
    }
    
    func getLatestDailies(req: Vapor.Request) async throws -> [Daily] {
        guard let id = req.parameters.get("id", as: Int.self) else {
            throw Abort(.badRequest)
        }
        
        if id < 0 {
            let dailies =  try await getContentFrom(file: "Dailies.json", type: [Daily].self)
            return dailies.filter { ($0.id ?? 0) >= -id  }
        } else {
            return try await Daily
                .query(on: req.db(DatabaseID.testingDB))
                .filter(\.$id >= id)
                .sort(\.$id)
                .all()
        }
    }
    
    
}


