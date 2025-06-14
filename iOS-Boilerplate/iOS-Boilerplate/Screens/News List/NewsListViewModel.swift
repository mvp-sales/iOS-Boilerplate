//
//  NewsListViewModel.swift
//  iOS-Boilerplate
//
//  Created by Marcus Vinicius Palassi Sales on 14/06/25.
//

import Foundation

@Observable
final class NewsListViewModel {
    var uiState: UiState = .initial
    private var api = NewsAPI()
    
    let query: String
    let sourceId: String
    
    init(query: String = "", sourceId: String = "") {
        self.query = query
        self.sourceId = sourceId
    }
    
    func loadArticles() {
        uiState = .loading
        let request = GetNewsRequest(searchType: .everything, query: self.query, sources: [sourceId], page: 1)
        Task {
            let result = await api.getNews(request: request)
            switch result {
            case .success(let response):
                self.uiState = .loaded(response.articles.map { $0.toEntity() })
            case .failure(let error):
                self.uiState = .error(GenericError(message: error.message))
            }
        }
    }
    
    enum UiState: Equatable {
        case initial
        case loading
        case loaded([ArticleNews])
        case error(GenericError)
    }
}
