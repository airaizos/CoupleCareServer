//
//  File.swift
//  
//
//  Created by Adrian Iraizos Mendoza on 5/1/24.
//

import Fluent
import Vapor


final class User: Model, Content {
    static let schema = users
    @ID(key: .id) var id: UUID?
    @Field(key:"username") var username: String
    @Field(key: "email") var email:String

}

extension User: Authenticatable {
    
}


final class UserToken: Model, Content {
    static let schema: String = userToken
    
    @ID(key: .id) var id: UUID?
    @Field(key:"token") var token: String
    @Parent(key: "user_id") var user: User
   
    @Timestamp(key: "created",on: .create,format: .iso8601 ) var created: Date?
    
    init() { }
    
    init(id: UUID? = nil, token:String, user: User.IDValue) {
        self.id = id
        self.token = token
        self.$user.id = user
    }
}


extension UserToken: ModelTokenAuthenticatable {
    static let valueKey = \UserToken.$token
       static let userKey = \UserToken.$user

    var isValid: Bool {
        true
    }
}



//extension UserToken {
//    struct TokenResponse: Content {
//        let token:String
//    }
//    
//    func response() -> UserToken.TokenResponse {
//        UserToken.TokenResponse(token: token)
//    }
//}

//extension UserToken: ModelTokenAuthenticatable {
//
//    static var valueKey = \UserToken.$token
//    static var userKey = \UserToken.$user
//    
//    var isValid: Bool { true }
//    
//}


//extension User {
//    func generateToken() throws -> UserToken {
//        try .init(
//            user: self.requireID(), token: [UInt8].random(count: 16).base64
//        )
//    }
//}


//extension UserToken {
//    struct Migration: AsyncMigration {
//        var name: String { "CreateUserToken" }
//
//        func prepare(on database: Database) async throws {
//            try await database.schema("user_tokens")
//                .id()
//                .field("token", .string, .required)
//                .field("user_id", .uuid, .required, .references("users", "id"))
//                .unique(on: "value")
//                .create()
//        }
//
//        func revert(on database: Database) async throws {
//            try await database.schema("user_tokens").delete()
//        }
//    }
//}
