//
//  NewsListViewModel.swift
//  iOS-Boilerplate
//
//  Created by Marcus Vinicius Palassi Sales on 14/06/25.
//

import Foundation

@Observable
final class NewsListViewModel {
    var articles: [ArticleNews] = []
    var error: GenericError?
    private var api = NewsAPI()
    
    let query: String
    let sourceId: String
    
    init(query: String = "", sourceId: String = "") {
        self.query = query
        self.sourceId = sourceId
    }
    
    func loadArticles() {
        let request = GetNewsRequest(searchType: .everything, query: self.query, sources: [sourceId], page: 1)
        Task {
            let result = await api.getNews(request: request)
            switch result {
            case .success(let response):
                self.articles = response.articles.map { $0.toEntity() }
                self.error = nil
            case .failure(let error):
                self.error = GenericError(message: error.message)
            }
        }
    }
}
