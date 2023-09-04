//
//  File.swift
//  
//
//  Created by Adrian Iraizos Mendoza on 27/8/23.
//

import Vapor
import Fluent



struct ControllerCCTestingServer: RouteCollection {
    let queryDb = CCQueryDB(dbName: DatabaseID.testingDB)
    
    
    func boot(routes: RoutesBuilder) throws {
        let api = routes.grouped("testing")
        
        api.get("currentversion", use: currentVersion)
        
        api.get("categories", use: queryDb.getCategories)
        api.get("tags",use: queryDb.getTags)
        api.get("quotes", use: queryDb.getQuotes)
        api.get("activities", use: queryDb.getActivities)
        api.get("activitiesdetail", use: queryDb.getActivitiesDetail)
        api.get("activitytags", use: queryDb.getActivityTags)
        api.get("dailies", use: queryDb.getDailies)
        api.get("dailiesdetail", use: queryDb.getDailiesDetail)
        api.get("dailytags", use: queryDb.getDailyTags)
    
        api.get("image", use:getImage)
        
        
        let latest = api.grouped("latest")
        latest.get("quotes",":id", use: queryDb.getLatestQuotes)
        latest.get("categories",":id", use: queryDb.getLatestCategories)
        latest.get("tags",":id", use: queryDb.getLatestTags)
        
        latest.get("activities",":id", use: queryDb.getLatestActivities)
        latest.get("quotes",":id", use: queryDb.getLatestQuotes)
        latest.get("activitytags",":id", use: queryDb.getLatestActivityTags)
      
        latest.get("dailies",":id", use: queryDb.getLatestDailies)
        latest.get("dailiesdetail",":id", use: queryDb.getLatestDailyDetail)
        latest.get("dailytags",":id",use: queryDb.getLatestDailyTags)
 
        let random = api.grouped("random")
        random.get("daily",use: queryDb.getRandomDaily)
    }
    
    //MARK - Métodos Compartidos
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
    
    func getTagsJson(req: Vapor.Request) async throws -> [Tag] {
        try await getContentFrom(file: "Tags.json", type: [Tag].self)
    }
    
    func getQuotesJson(req: Vapor.Request) async throws -> [Quote] {
        try await getContentFrom(file: "Quotes.json", type: [Quote].self)
    }
    
    func getActivitiesJson(req: Vapor.Request) async throws -> [Activity] {
        try await getContentFrom(file: "Activities.json", type: [Activity].self)
    }
    
    func getActivitiesDetailJson(req: Vapor.Request) async throws -> [Activity] {
        try await getContentFrom(file: "Activities.json", type: [Activity].self)
    }
    
    func getActivityTagsJson(req: Vapor.Request) async throws -> [ActivityTag] {
        try await getContentFrom(file: "ActivityTags.json", type: [ActivityTag].self)
    }
    
    func getDailiesJson(req: Vapor.Request) async throws -> [Daily] {
        try await getContentFrom(file: "Dailies.json", type: [Daily].self)
    }
    
    func getDailiesDetailJson(req: Vapor.Request) async throws -> [Daily] {
        try await getContentFrom(file: "Dailiesdetail.json", type: [Daily].self)
    }
    
    func getDailyTagsJson(req: Vapor.Request) async throws -> [DailyTag] {
        try await getContentFrom(file: "DailyTags.json", type: [DailyTag].self)
    }
    
    func getImage(req:Request) async throws -> View {
        return try await req.view.render("image", ["image":"http://127.0.0.1:8080/image.png"])
    }
    
    
    //MARK: Registros filtrados
    
    
    
}


