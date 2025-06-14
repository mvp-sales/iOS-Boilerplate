//
//  NewsListScreen.swift
//  iOS-Boilerplate
//
//  Created by Marcus Vinicius Palassi Sales on 14/06/25.
//

import Foundation
import SwiftUI

struct NewsListScreen: View {
    
    @Environment(NavigationRouter.self) var router
    @Bindable var viewModel: NewsListViewModel
    
    var body: some View {
        VStack {
            switch viewModel.uiState {
            case .initial:
                EmptyView()
            case .loading:
                ProgressView()
            case .loaded(let articles):
                List(articles) { article in
                    Text(article.title)
                }
            case .error(let error):
                Text(error.message)
                Button("Retry") {
                    viewModel.loadArticles()
                }
            }
        }
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button{
                    router.pop()
                } label: {
                    Image(systemName: "chevron.backward")
                    Text("News List")
                }
            }
        }
        .onAppear {
            viewModel.loadArticles()
        }
    }
}

#Preview {
    NewsListScreen(viewModel: NewsListViewModel())
}
