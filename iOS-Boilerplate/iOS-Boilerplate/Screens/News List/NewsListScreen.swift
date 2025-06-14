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
        List(viewModel.articles) { article in
            Text(article.title)
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
