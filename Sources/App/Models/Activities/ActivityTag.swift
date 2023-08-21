//
//  File.swift
//  
//
//  Created by Adrian Iraizos Mendoza on 21/8/23.
//

import Fluent
import Vapor


final class ActivityTag: Model, Content {
    static let schema:String = activityTag
    
    @ID(custom: .id) var id: Int?
    @Parent(key: "activity_id") var activity: Activity
    @Parent(key: "tag_id") var tag: Tag

    
    init() {}
    
    init(id: Int? = nil, activity:Activity, tag: Tag) throws {
        self.id = id
        self.$activity.id = try activity.requireID()
        self.$tag.id = try tag.requireID()
    }
    
    
    
}
