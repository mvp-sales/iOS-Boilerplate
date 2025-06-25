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
                        NewsSourcesListView()
                    case .newsListScreen(let query, let sourceId):
                        NewsListScreen(viewModel: NewsListViewModel(query: query, sourceId: sourceId))
                    case .newsDetail(let article):
                        NewsDetailView(viewModel: NewsDetailViewModel(article: article, database: appDatabase))
                    }
                }
        }.environment(router)
    }
}

#Preview {
    RootView()
}
