//
//  AppDatabase.swift
//  iOS-Boilerplate
//
//  Created by User01 on 24/06/2025.
//

import Foundation
import GRDB

final class AppDatabase: Sendable {
    
    private let dbWriter: any DatabaseWriter
    
    init(_ dbWriter: any GRDB.DatabaseWriter) throws {
        self.dbWriter = dbWriter
        try migrator.migrate(dbWriter)
    }
    
    private var migrator: DatabaseMigrator {
        var migrator = DatabaseMigrator()
                
#if DEBUG
        // Speed up development by nuking the database when migrations change
        // See <https://swiftpackageindex.com/groue/GRDB.swift/documentation/grdb/migrations#The-eraseDatabaseOnSchemaChange-Option>
        migrator.eraseDatabaseOnSchemaChange = true
#endif
        
        migrator.registerMigration("v1") { db in
            // Create a table
            // See <https://swiftpackageindex.com/groue/GRDB.swift/documentation/grdb/databaseschema>
            try db.create(table: ArticleNewsEntity.databaseTableName) { t in
                t.autoIncrementedPrimaryKey("id")
                t.column("author", .text)
                t.column("title", .integer).notNull()
                t.column("articleDescription", .text)
                t.column("url", .text).notNull().unique().indexed()
                t.column("urlToImage", .text)
                t.column("publishedAt", .text).notNull()
                t.column("content", .text)
                t.column("sourceId", .text)
                t.column("sourceName", .text).notNull()
            }
            
            try db.create(table: NewsSourceEntity.databaseTableName) { t in
                t.autoIncrementedPrimaryKey("id")
                t.column("sourceId", .text).notNull().indexed().unique()
                t.column("name", .text).notNull()
                t.column("sourceDescription", .text).notNull()
                t.column("url", .text).notNull()
                t.column("category", .text).notNull()
                t.column("language", .text).notNull()
                t.column("country", .text).notNull()
            }
        }
        
        // Migrations for future application versions will be inserted here:
        // migrator.registerMigration(...) { db in
        //     ...
        // }
        
        return migrator
    }
}

extension AppDatabase {
    // Uncomment for enabling SQL logging
    // private static let sqlLogger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: "SQL")
    
    /// Returns a database configuration suited for `AppDatabase`.
    ///
    /// - parameter config: A base configuration.
    static func makeConfiguration(_ config: Configuration = Configuration()) -> Configuration {
        // var config = config
        //
        // Add custom SQL functions or collations, if needed:
        // config.prepareDatabase { db in
        //     db.add(function: ...)
        // }
        //
        // Uncomment for enabling SQL logging if the `SQL_TRACE` environment variable is set.
        // See <https://swiftpackageindex.com/groue/GRDB.swift/documentation/grdb/database/trace(options:_:)>
        // if ProcessInfo.processInfo.environment["SQL_TRACE"] != nil {
        //     config.prepareDatabase { db in
        //         let dbName = db.description
        //         db.trace { event in
        //             // Sensitive information (statement arguments) is not
        //             // logged unless config.publicStatementArguments is set
        //             // (see below).
        //             sqlLogger.debug("\(dbName): \(event)")
        //         }
        //     }
        // }
        //
        // #if DEBUG
        // // Protect sensitive information by enabling verbose debugging in
        // // DEBUG builds only.
        // // See <https://swiftpackageindex.com/groue/GRDB.swift/documentation/grdb/configuration/publicstatementarguments>
        // config.publicStatementArguments = true
        // #endif
        
        return config
    }
}

extension AppDatabase {
    /// Saves (inserts or updates) a player. When the method returns, the
    /// player is present in the database, and its id is not nil.
    func saveArticleNews(_ article: inout ArticleNewsEntity) throws {
        try dbWriter.write { db in
            try article.save(db)
        }
    }
    
    /// Delete the specified players
    func deleteArticle(by url: String) throws {
        _ = try dbWriter.write { db in
            try ArticleNewsEntity
                .filter(Column("url") == url)
                .deleteAll(db)
        }
    }
    
    /// Delete all players
    func deleteAllArticles() throws {
        try dbWriter.write { db in
            _ = try ArticleNewsEntity.deleteAll(db)
        }
    }
    
    func getAllArticles() async throws -> [ArticleNewsEntity] {
        try await dbWriter.read { db in
            try ArticleNewsEntity.fetchAll(db)
        }
    }
    
    func getArticle(by url: String) async throws -> ArticleNewsEntity? {
        try await dbWriter.read { db in
            try ArticleNewsEntity
                .filter(Column("url") == url)
                .fetchOne(db)
        }
    }
    
    func saveNewsSource(_ source: inout NewsSourceEntity) throws {
        try dbWriter.write { db in
            try source.save(db)
        }
    }
    
    func deleteNewsSource(by sourceId: String) throws {
        _ = try dbWriter.write { db in
            try NewsSourceEntity
                .filter(Column("sourceId") == sourceId)
                .deleteAll(db)
        }
    }
    
    func getAllNewsSources() async throws -> [NewsSourceEntity] {
        try await dbWriter.read { db in
            try NewsSourceEntity.fetchAll(db)
        }
    }
}

// MARK: - Database Access: Reads

// This demo app does not provide any specific reading method, and instead
// gives an unrestricted read-only access to the rest of the application.
// In your app, you are free to choose another path, and define focused
// reading methods.
extension AppDatabase {
    /// Provides a read-only access to the database.
    var reader: any GRDB.DatabaseReader {
        dbWriter
    }
}
