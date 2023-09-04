//
//  File.swift
//  
//
//  Created by Adrian Iraizos Mendoza on 22/8/23.
//

import Vapor
import Fluent


struct ControllerCoupleCareServer: RouteCollection {
    let queryDb = CCQueryDB(dbName: DatabaseID.sqlite)
    
    func boot(routes: RoutesBuilder) throws {
        let api = routes.grouped("couplecare")
        
        api.get("currentversion",use: currentVersion)
        api.get("categories", use: queryDb.getCategories)
        api.get("tags",use: queryDb.getTags)
        api.get("quotes", use: queryDb.getQuotes)
        
        api.get("activities", use: queryDb.getActivities)
        api.get("activitiesdetail", use: queryDb.getActivitiesDetail)
        api.get("activitytags", use: queryDb.getActivityTags)
        api.get("dailies", use: queryDb.getDailies)
        api.get("dailiesdetail", use: queryDb.getDailiesDetail)
        api.get("dailytags", use: queryDb.getDailyTags)
   
        
        let latest = api.grouped("latest")
        latest.get("quotes",":id",use: queryDb.getLatestQuotes)
        latest.get("categories",":id", use: queryDb.getLatestCategories)
        latest.get("tags",":id", use: queryDb.getLatestTags)
        latest.get("activities",":id", use: queryDb.getLatestActivities)
        
        latest.get("activitiesdetail",":id",use: queryDb.getLatestActivityDetail)
        
        latest.get("activitytags",":id", use: queryDb.getLatestActivityTags)
        latest.get("dailies",":id",use: queryDb.getLatestDailies)
        latest.get("dailiesdetail",":id", use: queryDb.getLatestDailyDetail)
        latest.get("dailytags",":id",use: queryDb.getLatestDailyTags)
        
        
        let random = api.grouped("random")
        random.get("daily",use: queryDb.getRandomDaily)
    }
    
    //MARK: - General
    func currentVersion(req:Request) async throws -> Double {
        if let max = try await DataSourceVersion
            .query(on: req.db)
            .max(\.$current) {
            return max
        } else {
            throw Abort(.notFound, reason: "No se ha encontrado la versión actual")
        }
    }
    
    
    //MARK: - Filtered Values

    
}
