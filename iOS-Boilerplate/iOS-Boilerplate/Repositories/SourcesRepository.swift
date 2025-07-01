//
//  SourcesRepository.swift
//  iOS-Boilerplate
//
//  Created by User01 on 01/07/2025.
//

import Foundation

protocol SourcesRepository {
    func getSources() async -> Result<[NewsSource], GenericError>
    func favouriteSources() async -> [NewsSource]
    func addFavouriteSource(source: NewsSource)
    func removeFavouriteSource(source: NewsSource)
}

final class SourcesRepositoryImpl: SourcesRepository {
    
    private let newsApi: NewsAPI
    private let database: AppDatabase
    
    init(newsApi: NewsAPI, database: AppDatabase) {
        self.newsApi = newsApi
        self.database = database
    }
    
    func getSources() async -> Result<[NewsSource], GenericError> {
        let favourites = await favouriteSources()
        return await newsApi.getHeadlinesSources(request: GetHeadlinesSourcesRequest(category: "")).map { response in
            response.sources.map { source in
                favourites.first { source.id == $0.id } ?? source.toDomain()
            }
        }.mapError { error in
            GenericError(message: error.message)
        }
    }
    
    func favouriteSources() async -> [NewsSource] {
        return (try? await database.getAllNewsSources().map { $0.toDomain() }) ?? []
    }
    
    func addFavouriteSource(source: NewsSource) {
        var sourceEntity = source.toEntity()
        try? database.saveNewsSource(&sourceEntity)
    }
    
    func removeFavouriteSource(source: NewsSource) {
        try? database.deleteNewsSource(by: source.id)
    }
}
