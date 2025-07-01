//
//  NewsSourcesListView.swift
//  iOS-Boilerplate
//
//  Created by Marcus Vinicius Palassi Sales on 10/06/25.
//

import SwiftUI

struct NewsSourcesListView: View {
    
    @Environment(NavigationRouter.self) var router
    @Bindable var viewModel: NewsSourcesListViewModel
    
    var body: some View {
        VStack {
            switch viewModel.uiState {
            case .initial:
                EmptyView()
            case .loading:
                ProgressView()
            case .loaded(_, _):
                List(viewModel.uiState.sourcesToShow) { source in
                    VStack(alignment: .leading) {
                        HStack {
                            Text(source.name)
                                .font(.title)
                            Spacer()
                            Image(systemName: source.favourite ? "heart.fill" : "heart" )
                                .foregroundStyle(Color.red)
                                .onTapGesture {
                                    if source.favourite {
                                        viewModel.removeFavouriteSource(source: source)
                                    } else {
                                        viewModel.addFavouriteSource(source: source)
                                    }
                                }
                        }
                        Text(source.url)
                            .font(.subheadline)
                        Text(source.description)
                            .font(.caption)
                            .padding(EdgeInsets(top: 2.0, leading: 0.0, bottom: 0.0, trailing: 0.0))
                        Text("Category: \(source.category)")
                            .font(.caption)
                            .padding(EdgeInsets(top: 2.0, leading: 0.0, bottom: 2.0, trailing: 0.0))
                        HStack {
                            Text(source.country)
                                .font(.caption2)
                            Spacer()
                            Text("Language: \(source.language)")
                                .font(.caption2)
                        }
                        .frame(maxWidth: .infinity)
                    }.onTapGesture {
                        router.push(to: .newsListScreen("", source.id))
                    }
                }
            case .error(let error):
                Text(error.message)
                Button("Retry") {
                    viewModel.loadSources()
                }
            }
        }
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    router.pop()
                } label: {
                    Image(systemName: "chevron.backward")
                    Text("News Sources")
                }
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button("Show only favourites") {
                    viewModel.toggleShowOnlyFavourites()
                }
            }
        }
        .onAppear {
            viewModel.loadSources()
        }
    }
}

/*#Preview {
    NewsSourcesListView(viewModel: NewsSourcesListViewModel(database: AppDatabase.empty()))
}*/
