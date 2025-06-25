//
//  ArticleNewsEntity.swift
//  iOS-Boilerplate
//
//  Created by User01 on 23/06/2025.
//

import Foundation
import SwiftData
import GRDB

struct ArticleNewsEntity: Codable, Identifiable, FetchableRecord, PersistableRecord, TableRecord {
    var id: Int64?
    var author: String?
    var title: String
    var articleDescription: String?
    var url: String
    var urlToImage: String?
    var publishedAt: String
    var content: String?
    var sourceId: String?
    var sourceName: String
    
    static let databaseTableName: String = "articles_news"
}

extension ArticleNewsEntity {
    func toDomain() -> ArticleNews {
        .init(
            author: author,
            title: title,
            description: articleDescription,
            url: url,
            urlToImage: urlToImage,
            publishedAt: publishedAt,
            content: content,
            source: ArticleSource(id: sourceId, name: sourceName)
        )
    }
}

extension ArticleNews {
    func toEntity() -> ArticleNewsEntity {
        .init(
            id: nil,
            author: author,
            title: title,
            articleDescription: description,
            url: url,
            urlToImage: urlToImage,
            publishedAt: publishedAt,
            content: content,
            sourceId: source.id,
            sourceName: source.name
        )
    }
}
