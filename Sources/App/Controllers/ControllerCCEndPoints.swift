//
//  File.swift
//  
//
//  Created by Adrian Iraizos Mendoza on 27/8/23.
//

import Vapor
import Fluent



protocol ControllerCCEndPoints {
    func currentVersion(req: Request) async throws -> Double
    func getCategories(req:Request) async throws -> [Category]
    func getTags(req:Request) async throws -> [Tag]
    func getQuotes(req:Request) async throws -> [Quote]
    func getActivities(req:Request) async throws -> [Activity]
    func getActivitiesDetail(req: Request) async throws -> [Activity]
    func getActivityTags(req:Request) async throws -> [ActivityTag]
    func getDailies(req: Request) async throws -> [Daily]
    func getDailiesDetail(req: Request) async throws -> [Daily]
    func getDailyTags(req:Request) async throws -> [DailyTag]
}
