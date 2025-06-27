//
//  NewsSourceEntity.swift
//  iOS-Boilerplate
//
//  Created by User01 on 23/06/2025.
//

import Foundation
import SwiftData
import GRDB

struct NewsSourceEntity: Codable, Identifiable, FetchableRecord, PersistableRecord {
    var id: Int64?
    var sourceId: String
    var name: String
    var sourceDescription: String
    var url: String
    var category: String
    var language: String
    var country: String
    
    static let databaseTableName: String = "news_sources"
}

extension NewsSourceEntity {
    func toDomain() -> NewsSource {
        .init(
            id: sourceId,
            name: name,
            description: sourceDescription,
            url: url,
            category: category,
            language: language,
            country: country,
            favourite: true
        )
    }
}

extension NewsSource {
    func toEntity() -> NewsSourceEntity {
        .init(
            id: nil,
            sourceId: id,
            name: name,
            sourceDescription: description,
            url: url,
            category: category,
            language: language,
            country: country
        )
    }
}
