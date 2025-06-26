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
    private let appDatabase: AppDatabase
    
    init(appDatabase: AppDatabase) {
        self.appDatabase = appDatabase
    }
    
    func loadSavedNews() {
        uiState = .loading
        Task {
            let savedNews = try! await appDatabase.getAllArticles()
            self.uiState = .loaded(savedNews.map { $0.toDomain() })
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
