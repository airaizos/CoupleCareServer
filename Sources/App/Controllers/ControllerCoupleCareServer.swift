//
//  File.swift
//  
//
//  Created by Adrian Iraizos Mendoza on 22/8/23.
//

import Vapor
import Fluent


struct ControllerCoupleCareServer: RouteCollection,ControllerCCEndPoints {
    func boot(routes: RoutesBuilder) throws {
        let api = routes.grouped("couplecare")
        
        api.get("currentversion",use: currentVersion)
        api.get("categories", use: getCategories)
        api.get("tags",use: getTags)
        api.get("activities", use: getActivities)
        api.get("activitiesdetail", use: getActivitiesDetail)
        api.get("activitytags", use: getActivityTags)
        api.get("dailies", use: getDailies)
        api.get("dailiesdetail", use: getDailiesDetail)
        api.get("dailytags", use: getDailyTags)
        api.get("quotes", use: getQuotes)
        
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
    
    func getCategories(req:Request) async throws -> [Category] {
        try await Category
            .query(on: req.db)
            .sort(\.$name)
            .all()
    }
    
    func getTags(req:Request) async throws -> [Tag] {
        try await Tag
            .query(on: req.db)
            .sort(\.$name)
            .all()
    }
    
    func getQuotes(req:Request) async throws -> [Quote] {
        try await Quote
            .query(on: req.db)
            .all()
    }
    
    //MARK: - Activities
    
    func getActivities(req:Request) async throws -> [Activity] {
        try await Activity
            .query(on: req.db)
            .sort(\.$id)
            .all()
    }
    
    func getActivitiesDetail(req: Request) async throws -> [Activity] {
        try await Activity
            .query(on: req.db)
            .sort(\.$id)
            .with(\.$categoryId)
            .with(\.$tags)
            .all()
    }
    
    
    func getActivityTags(req:Request) async throws -> [ActivityTag] {
        try await ActivityTag
            .query(on: req.db)
            .all()
    }
    
    //MARK: Dailies
    
    func getDailies(req: Request) async throws -> [Daily] {
        try await Daily
            .query(on: req.db)
            .with(\.$tags)
            .all()
    }
    
    func getDailiesDetail(req: Request) async throws -> [Daily] {
        try await Daily
            .query(on: req.db)
            .sort(\.$id)
            .with(\.$tags)
            .all()
    }
    
    
    func getDailyTags(req:Request) async throws -> [DailyTag] {
        try await DailyTag
            .query(on: req.db)
            .all()
    }
    
}
