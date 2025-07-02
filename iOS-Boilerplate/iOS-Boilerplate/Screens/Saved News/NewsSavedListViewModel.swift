//
//  NewsSavedListViewModel.swift
//  iOS-Boilerplate
//
//  Created by User01 on 26/06/2025.
//

import Foundation

@Observable
final class NewsSavedListViewModel {
    var uiState: UiState = .initial
    private let repository: NewsRepository
    
    init(repository: NewsRepository) {
        self.repository = repository
    }
    
    func loadSavedNews() {
        uiState = .loading
        Task {
            let savedNews = await repository.getSavedArticles()
            self.uiState = .loaded(savedNews)
        }
    }
    
    func resetState() {
        if uiState != .initial {
            uiState = .initial
        }
    }
    
    enum UiState: Equatable {
        case initial
        case loading
        case loaded([ArticleNews])
    }
}
