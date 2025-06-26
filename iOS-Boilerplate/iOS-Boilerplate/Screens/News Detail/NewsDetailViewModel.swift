//
//  NewsDetailViewModel.swift
//  iOS-Boilerplate
//
//  Created by Marcus Vinicius Palassi Sales on 15/06/25.
//

import Foundation

@Observable
final class NewsDetailViewModel {
    var uiState: UiState = .initial
    let article: ArticleNews
    private let database: AppDatabase
    
    init(article: ArticleNews, database: AppDatabase) {
        self.article = article
        self.database = database
    }
    
    func saveArticle() {
        //uiState = .loading
        var entity = article.toEntity()
        Task {
            try? database.saveArticleNews(&entity)
            uiState = .loaded(true)
        }
    }
    
    func deleteArticle() {
        //uiState = .loading
        Task {
            try? database.deleteArticle(by: article.url)
            uiState = .loaded(false)
        }
    }
    
    func getArticleSaved() {
        uiState = .loading
        Task {
            let article = try? await database.getArticle(by: article.url)
            uiState = .loaded(article != nil)
        }
    }
    
    enum UiState: Equatable {
        case initial
        case loading
        case loaded(Bool)
    }
}
