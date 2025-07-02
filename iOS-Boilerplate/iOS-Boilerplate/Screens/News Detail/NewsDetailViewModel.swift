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
    private let repository: NewsRepository
    
    init(article: ArticleNews, repository: NewsRepository) {
        self.article = article
        self.repository = repository
    }
    
    func saveArticle() {
        Task {
            repository.saveArticle(article: article)
            uiState = .loaded(true)
        }
    }
    
    func deleteArticle() {
        Task {
            repository.deleteArticle(articleUrl: article.url)
            uiState = .loaded(false)
        }
    }
    
    func getArticleSaved() {
        uiState = .loading
        Task {
            let article = await repository.getArticle(articleUrl: article.url)
            uiState = .loaded(article != nil)
        }
    }
    
    enum UiState: Equatable {
        case initial
        case loading
        case loaded(Bool)
    }
}
