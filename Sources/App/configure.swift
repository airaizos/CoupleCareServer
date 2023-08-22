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

    //Migrations
    app.migrations.add(CreateDataSourceVersion())
    app.migrations.add(CreateCategory())
    app.migrations.add(CreateTag())
    app.migrations.add(CreateQuote())
    
    app.migrations.add(CreateActivity())
    app.migrations.add(CreateActivityTag())
    
    app.migrations.add(CreateDaily())
    app.migrations.add(CreateDailyTag())
    

    app.views.use(.leaf)

    

    // register routes
    try routes(app)
}
