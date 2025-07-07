//
//  RootView.swift
//  iOS-Boilerplate
//
//  Created by Marcus Vinicius Palassi Sales on 11/06/25.
//

import SwiftUI

struct RootView: View {
    
    @Environment(NavigationRouter.self) var router
    @Environment(\.appDatabase) var appDatabase
    @Environment(\.api) var newsApi
    
    var body: some View {
        let pathBinding = Binding(
            get: { router.routes },
            set: { router.routes = $0 }
        )
        NavigationStack(path: pathBinding) {
            NewsSearchView()
                .navigationDestination(for: Route.self) { route in
                    switch route {
                    case .newsSourcesList:
                        NewsSourcesListView(
                            viewModel: NewsSourcesListViewModel(
                                repository: SourcesRepositoryImpl(
                                    newsApi: newsApi,
                                    database: appDatabase
                                )
                            )
                        )
                    case .newsListScreen(let query, let sourceId, let isFavouriteSourcesOnly):
                        NewsListView(
                            viewModel: NewsListViewModel(
                                query: query,
                                sourceId: sourceId,
                                showFavouriteSourcesOnly: isFavouriteSourcesOnly,
                                repository: NewsRepositoryImpl(
                                    newsApi: newsApi,
                                    database: appDatabase
                                ),
                                sourcesRepository: SourcesRepositoryImpl(
                                    newsApi: newsApi,
                                    database: appDatabase
                                )
                            )
                        )
                    case .newsDetail(let article):
                        NewsDetailView(
                            viewModel: NewsDetailViewModel(
                                article: article,
                                repository: NewsRepositoryImpl(
                                    newsApi: newsApi,
                                    database: appDatabase
                                )
                            )
                        )
                    case .newsSavedList:
                        NewsSavedListView(
                            viewModel: NewsSavedListViewModel(
                                repository: NewsRepositoryImpl(
                                    newsApi: newsApi,
                                    database: appDatabase
                                )
                            )
                        )
                    }
                }
        }.environment(router)
    }
}

#Preview {
    RootView()
}
