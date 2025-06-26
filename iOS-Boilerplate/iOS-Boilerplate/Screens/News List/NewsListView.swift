//
//  NewsListScreen.swift
//  iOS-Boilerplate
//
//  Created by Marcus Vinicius Palassi Sales on 14/06/25.
//

import Foundation
import SwiftUI

struct NewsListView: View {
    
    @Environment(NavigationRouter.self) var router
    @Bindable var viewModel: NewsListViewModel
    
    var body: some View {
        VStack {
            switch viewModel.uiState {
            case .initial:
                EmptyView()
            case .loading:
                ProgressView()
            case .loaded(let pageData):
                List {
                    ForEach(pageData.articles) { article in
                        NewsContent(article: article)
                            .onTapGesture {
                                router.push(to: .newsDetail(article))
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    
                    if !pageData.fetchedAllResults {
                        Button("Load more news") {
                            viewModel.loadArticles()
                        }
                        .frame(maxWidth: .infinity)
                    } else {
                        ProgressView()
                            .frame(maxWidth: .infinity)
                    }
                }
                .listStyle(.plain)
                .listRowInsets(EdgeInsets())
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

fileprivate struct NewsContent: View {
    
    let article: ArticleNews
    
    var body: some View {
        VStack(alignment: .center) {
            AsyncImage(url: URL(string: article.urlToImage ?? "")) { phase in
                if let image = phase.image {
                    image.resizable()
                        .scaledToFill()
                        .frame(height: 160)
                        .frame(maxWidth: .infinity)
                        .clipped()
                }
            }
            Text(article.title)
                .padding(EdgeInsets(top: 4.0, leading: 0.0, bottom: 0.0, trailing: 0.0))
                .font(.title2)
            HStack {
                Text(article.source.name)
                    .font(.caption)
                Spacer()
                Text(article.formatPublishedDate(format: "dd/MM/yyyy"))
                    .font(.caption)
            }
            .padding(EdgeInsets(top: 4.0, leading: 0.0, bottom: 0.0, trailing: 0.0))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(16.0)
    }
}

#Preview {
    NewsListView(viewModel: NewsListViewModel())
}
