//
//  NewsRepository.swift
//  iOS-Boilerplate
//
//  Created by User01 on 01/07/2025.
//

import Foundation

protocol NewsRepository {
    func getNews(query: SearchNewsQuery) async -> Result<NewsPage, GenericError>
    func getSavedArticles() async -> [ArticleNews]
    func saveArticle(article: ArticleNews)
    func deleteArticle(articleUrl: String)
    func getArticle(articleUrl: String) async -> ArticleNews?
}

final class NewsRepositoryImpl: NewsRepository {
    private let newsApi: NewsAPI
    private let database: AppDatabase
    
    init(newsApi: NewsAPI, database: AppDatabase) {
        self.newsApi = newsApi
        self.database = database
    }
    
    func getNews(query: SearchNewsQuery) async -> Result<NewsPage, GenericError> {
        return await newsApi.getNews(
            request: GetNewsRequest(
                searchType: query.searchType,
                query: query.searchTerm,
                sources: query.sources,
                page: query.page
            )
        ).map { newsResponse in
            NewsPage(articles: newsResponse.articles.map { $0.toEntity() }, totalResults: newsResponse.totalResults, page: query.page)
        }.mapError { error in
            GenericError(message: error.message)
        }
    }
    
    func getSavedArticles() async -> [ArticleNews] {
        return (try? await database.getAllArticles().map { $0.toDomain() }) ?? []
    }
    
    func saveArticle(article: ArticleNews) {
        var articleEntity = article.toEntity()
        try? database.saveArticleNews(&articleEntity)
    }
    
    func deleteArticle(articleUrl: String) {
        try? database.deleteArticle(by: articleUrl)
    }
    
    func getArticle(articleUrl: String) async -> ArticleNews? {
        return try? (await database.getArticle(by: articleUrl)).map { $0.toDomain() }
    }
}
