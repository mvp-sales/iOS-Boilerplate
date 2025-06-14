//
//  NewsSourcesListViewModel.swift
//  iOS-Boilerplate
//
//  Created by Marcus Vinicius Palassi Sales on 14/06/25.
//

import Foundation

@Observable
final class NewsSourcesListViewModel {
    
    var sources: [NewsSource] = []
    var error: GenericError?
    private var api = NewsAPI()
    
    func loadSources() {
        Task {
            let result = await api.getHeadlinesSources(request: .init(category: ""))
            switch result {
            case .success(let response):
                self.sources = response.sources.map { $0.toEntity() }
                self.error = nil
            case .failure(let error):
                self.error = GenericError(message: error.message)
            }
        }
    }
}
