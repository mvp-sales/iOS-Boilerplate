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
    
    let query: String
    let sourceId: String
    let showFavouriteSourcesOnly: Bool
    private let repository: NewsRepository
    private let sourcesRepository: SourcesRepository
    
    init(
        query: String = "",
        sourceId: String = "",
        showFavouriteSourcesOnly: Bool = false,
        repository: NewsRepository,
        sourcesRepository: SourcesRepository
    ) {
        self.query = query
        self.sourceId = sourceId
        self.showFavouriteSourcesOnly = showFavouriteSourcesOnly
        self.repository = repository
        self.sourcesRepository = sourcesRepository
    }
    
    func loadArticles() {
        switch uiState {
        case .loading:
            return
        case .loaded(let loadedData):
            guard !loadedData.isLoadingMore else {
                return
            }
            uiState = .loaded(
                LoadedData(
                    articles: loadedData.articles,
                    lastLoadedPage: loadedData.lastLoadedPage,
                    isLoadingMore: true,
                    totalResultsCount: loadedData.totalResultsCount,
                    searchType: .everything
                )
            )
        default:
            uiState = .loading
        }
        
        let lastLoadedPage: Int
        if case let .loaded(loadedData) = uiState {
            lastLoadedPage = loadedData.lastLoadedPage
        } else {
            lastLoadedPage = 0
        }

        Task {
            let sources: [String]
            if !sourceId.isEmpty {
                sources = [sourceId]
            } else if showFavouriteSourcesOnly {
                sources = await sourcesRepository.favouriteSources().map { $0.id }
            } else {
                sources = []
            }
            
            let query = SearchNewsQuery(
                searchType: .everything,
                searchTerm: self.query,
                sources: sources,
                page: lastLoadedPage + 1
            )
            
            let result = await repository.getNews(query: query)
            switch result {
            case .success(let newsPage):
                if case let .loaded(loadedData) = uiState {
                    uiState = .loaded(
                        LoadedData(
                            articles: loadedData.articles + newsPage.articles,
                            lastLoadedPage: lastLoadedPage + 1,
                            isLoadingMore: false,
                            totalResultsCount: newsPage.totalResults,
                            searchType: .everything
                        )
                    )
                } else {
                    uiState = .loaded(
                        LoadedData(
                            articles: newsPage.articles,
                            lastLoadedPage: 1,
                            isLoadingMore: false,
                            totalResultsCount: newsPage.totalResults,
                            searchType: .everything
                        )
                    )
                }
            case .failure(let error):
                self.uiState = .error(GenericError(message: error.message))
            }
        }
    }
    
    enum UiState: Equatable {
        case initial
        case loading
        case loaded(LoadedData)
        case error(GenericError)
    }
    
    struct LoadedData: Equatable {
        let articles: [ArticleNews]
        let lastLoadedPage: Int
        let isLoadingMore: Bool
        let totalResultsCount: Int
        let searchType: SearchType
        
        var fetchedAllResults: Bool {
            articles.count == totalResultsCount
        }
    }
}
