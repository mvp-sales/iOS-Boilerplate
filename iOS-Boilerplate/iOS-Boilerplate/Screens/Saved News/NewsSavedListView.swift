//
//  NewsSavedListView.swift
//  iOS-Boilerplate
//
//  Created by User01 on 26/06/2025.
//

import SwiftUI

struct NewsSavedListView: View {
    @Environment(NavigationRouter.self) var router
    @Bindable var viewModel: NewsSavedListViewModel
    
    var body: some View {
        VStack {
            switch viewModel.uiState {
            case .initial:
                EmptyView()
            case .loading:
                ProgressView()
            case .loaded(let articles):
                List {
                    ForEach(articles) { article in
                        NewsContent(article: article)
                            .onTapGesture {
                                router.push(to: .newsDetail(article))
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
                .listStyle(.plain)
                .listRowInsets(EdgeInsets())
            }
        }
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button{
                    router.pop()
                } label: {
                    Image(systemName: "chevron.backward")
                    Text("Saved news")
                }
            }
        }
        .onAppear {
            viewModel.loadSavedNews()
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
    NewsSavedListView(viewModel: NewsSavedListViewModel(appDatabase: AppDatabase.empty()))
}
