//
//  File.swift
//  
//
//  Created by Adrian Iraizos Mendoza on 22/8/23.
//

import Fluent
import Vapor

final class Quote: Model, Content {
    static let schema: String = quotes
    
    init() {}
    
    @ID(custom: .id)  var id: Int?
    @Field(key: "quote") var quote: String?
    @Field(key: "author") var author: String?
    
    init(id: Int? = nil, quote: String, author: String) {
        self.id = id
        self.quote = quote
        self.author = author
    }
    
    
}
