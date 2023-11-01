import NIOSSL
import Fluent
import FluentSQLiteDriver
import Leaf
import Vapor

// configures your application
public func configure(_ app: Application) async throws {
    // uncomment to serve files from /Public folder
     app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
   
    app.databases.use(DatabaseConfigurationFactory.sqlite(.file("couplecaredb.sqlite")), as: .sqlite)
    
    //Migrations: 8
    app.migrations.add(CreateDataSourceVersion())
    app.migrations.add(CreateCategory())
    app.migrations.add(CreateTag())
    app.migrations.add(CreateQuote())
    
    app.migrations.add(CreateActivity())
    app.migrations.add(CreateActivityTag())
    
    app.migrations.add(CreateDaily())
    app.migrations.add(CreateDailyTag())
    
    app.migrations.add(CreateSuggestedAction())
    app.migrations.add(CreateSuggestedTag())
    app.migrations.add(CreateSuggestedActionTags())

    //Testing Endpoint
    app.databases.use(.sqlite(.file("testingDB.sqlite")), as: .testingDB)
    
    app.migrations.add(CreateDataSourceVersion(), to: .testingDB)
    app.migrations.add(CreateCategory(), to: .testingDB)
    app.migrations.add(CreateTag(), to: .testingDB)
    app.migrations.add(CreateQuote(), to: .testingDB)
    
    app.migrations.add(CreateActivity(), to: .testingDB)
    app.migrations.add(CreateActivityTag(), to: .testingDB)
    
    app.migrations.add(CreateDaily(), to: .testingDB)
    app.migrations.add(CreateDailyTag(), to: .testingDB)
    
    app.migrations.add(CreateSuggestedAction(), to: .testingDB)
    app.migrations.add(CreateSuggestedTag(), to: .testingDB)
    app.migrations.add(CreateSuggestedActionTags(), to: .testingDB)
    
    
    app.views.use(.leaf)

    
    

    // register routes
    try routes(app)
}
