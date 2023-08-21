//
//  File.swift
//  
//
//  Created by Adrian Iraizos Mendoza on 21/8/23.
//

import Fluent
import Vapor


final class DailyTag: Model, Content {
    static let schema:String = dailyTag
    
    @ID(custom: .id) var id: Int?
    @Parent(key: "daily_id") var daily: Daily
    @Parent(key: "tag_id") var tag: Tag

    init() {}
    
    init(id: Int? = nil, daily:Daily, tag: Tag) throws {
        self.id = id
        self.$daily.id = try daily.requireID()
        self.$tag.id = try tag.requireID()
    }
}
