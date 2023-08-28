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
        
        let latest = api.grouped("latest")
        
        latest.get("categories",":id", use: getLatestCategories)
        latest.get("tags",":id", use: getLatestTags)
        latest.get("activities",":id", use: getLatestActivities)
        latest.get("activitiesdetail",":id",use: getLatestActivityDetail)
        latest.get("activitytags",":id", use: getLatestActivityTags)
        latest.get("dailies",":id",use: getLatestDailies)
        latest.get("dailiesdetail",":id", use: getLatestDailyDetail)
        latest.get("dailytags",":id",use: getLatestDailyTags)
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
            .sort(\.$id)
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
    
    
    //MARK: - Filtered Values
    
    func getLatestCategories(req:Request) async throws -> [Category] {
        guard let id = req.parameters.get("id", as: Int.self), id > 0  else {
            throw Abort(.badRequest)
        }
        
        return try await Category
            .query(on: req.db(DatabaseID.sqlite))
            .filter(\.$id >= id)
            .sort(\.$id)
            .all()
    }
    
    func getLatestTags(req:Request) async throws -> [Tag] {
        guard let id = req.parameters.get("id", as: Int.self), id > 0  else {
            throw Abort(.badRequest)
        }
        
        return try await Tag
            .query(on: req.db(DatabaseID.sqlite))
            .filter(\.$id >= id)
            .sort(\.$id)
            .all()
    }
    
    func getLatestQuotes(req:Request) async throws -> [Quote] {
        guard let id = req.parameters.get("id", as: Int.self), id > 0  else {
            throw Abort(.badRequest)
        }
        
        return try await Quote
            .query(on: req.db(DatabaseID.sqlite))
            .filter(\.$id >= id)
            .sort(\.$id)
            .all()
    }
    func getLatestActivities(req:Request) async throws -> [Activity] {
        guard let id = req.parameters.get("id", as: Int.self), id > 0  else {
            throw Abort(.badRequest)
        }
        
        return try await Activity
            .query(on: req.db(DatabaseID.sqlite))
            .filter(\.$id >= id)
            .sort(\.$id)
            .all()
    }
    
    func getLatestActivityDetail(req:Request) async throws -> [Activity] {
        guard let id = req.parameters.get("id", as: Int.self), id > 0  else {
            throw Abort(.badRequest)
        }
        
        return try await Activity
            .query(on: req.db(DatabaseID.sqlite))
            .filter(\.$id >= id)
            .sort(\.$id)
            .with(\.$categoryId)
            .with(\.$tags)
            .all()
    }
    func getLatestActivityTags(req:Request) async throws -> [ActivityTag] {
        guard let id = req.parameters.get("id", as: Int.self), id > 0  else {
            throw Abort(.badRequest)
        }
        
        return try await ActivityTag
            .query(on: req.db(DatabaseID.sqlite))
            .filter(\.$id >= id)
            .sort(\.$id)
            .all()
    }
    func getLatestDailies(req:Request) async throws -> [Daily] {
        guard let id = req.parameters.get("id", as: Int.self), id > 0  else {
            throw Abort(.badRequest)
        }
        
        return try await Daily
            .query(on: req.db(DatabaseID.sqlite))
            .filter(\.$id >= id)
            .sort(\.$id)
            .all()
    }
    
    func getLatestDailyDetail(req:Request) async throws -> [Daily] {
        guard let id = req.parameters.get("id", as: Int.self), id > 0  else {
            throw Abort(.badRequest)
        }
        
        return try await Daily
            .query(on: req.db(DatabaseID.sqlite))
            .filter(\.$id >= id)
            .sort(\.$id)
            .with(\.$tags)
            .all()
    }
    func getLatestDailyTags(req:Request) async throws -> [DailyTag] {
        guard let id = req.parameters.get("id", as: Int.self), id > 0  else {
            throw Abort(.badRequest)
        }
        
        return try await DailyTag
            .query(on: req.db(DatabaseID.sqlite))
            .filter(\.$id >= id)
            .sort(\.$id)
            .with(\.$daily)
            .with(\.$tag)
            .all()
    }
}
