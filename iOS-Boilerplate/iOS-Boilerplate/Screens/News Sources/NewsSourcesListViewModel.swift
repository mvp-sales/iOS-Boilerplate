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
    var uiState: UiState = .initial
    private var api = NewsAPI()
    
    func loadSources() {
        guard uiState != .loading else { return }
        uiState = .loading
        Task {
            let result = await api.getHeadlinesSources(request: .init(category: ""))
            switch result {
            case .success(let response):
                //self.sources = response.sources.map { $0.toEntity() }
                //self.error = nil
                self.uiState = .loaded(response.sources.map { $0.toEntity() })
            case .failure(let error):
                //self.error = GenericError(message: error.message)
                self.uiState = .error(GenericError(message: error.message))
            }
        }
    }
    
    enum UiState: Equatable {
        case initial
        case loading
        case loaded([NewsSource])
        case error(GenericError)
    }
}
