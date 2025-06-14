//
//  RootView.swift
//  iOS-Boilerplate
//
//  Created by Marcus Vinicius Palassi Sales on 11/06/25.
//

import SwiftUI

struct RootView: View {
    
    @Environment(NavigationRouter.self) var router
    
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
                    case .newsListScreen:
                        NewsListScreen()
                    }
                }
        }.environment(router)
    }
}

#Preview {
    RootView()
}
