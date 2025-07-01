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
    private let database: AppDatabase
    private let repository: SourcesRepository
    
    init(database: AppDatabase, repository: SourcesRepository) {
        self.database = database
        self.repository = repository
    }
    
    func loadSources() {
        guard uiState != .loading else { return }
        uiState = .loading
        Task {
            let result = await repository.getSources()
            switch result {
            case .success(let sources):
                self.uiState = .loaded(sources, false)
            case .failure(let error):
                self.uiState = .error(GenericError(message: error.message))
            }
        }
    }
    
    func addFavouriteSource(source: NewsSource) {
        Task {
            repository.addFavouriteSource(source: source)
            if case let .loaded(sources, showOnlyFavourites) = self.uiState {
                let updatedSources = sources.map {
                    if $0.id == source.id {
                        NewsSource(id: source.id, name: source.name, description: source.description, url: source.url, category: source.category, language: source.language, country: source.country, favourite: true)
                    } else {
                        $0
                    }
                }
                uiState = .loaded(updatedSources, showOnlyFavourites)
            }
        }
    }
    
    func removeFavouriteSource(source: NewsSource) {
        Task {
            repository.removeFavouriteSource(source: source)
            if case let .loaded(sources, showOnlyFavourites) = self.uiState {
                let updatedSources = sources.map {
                    if $0.id == source.id {
                        NewsSource(id: source.id, name: source.name, description: source.description, url: source.url, category: source.category, language: source.language, country: source.country, favourite: false)
                    } else {
                        $0
                    }
                }
                uiState = .loaded(updatedSources, showOnlyFavourites)
            }
        }
    }
    
    func toggleShowOnlyFavourites() {
        if case let .loaded(sources, showOnlyFavourites) = self.uiState {
            uiState = .loaded(sources, !showOnlyFavourites)
        }
    }
    
    enum UiState: Equatable {
        case initial
        case loading
        case loaded([NewsSource], Bool)
        case error(GenericError)
        
        var sourcesToShow: [NewsSource] {
            if case let .loaded(sources, showOnlyFavourites) = self {
                if showOnlyFavourites {
                    sources.filter { $0.favourite }
                } else {
                    sources
                }
            } else {
                []
            }
        }
    }
}
