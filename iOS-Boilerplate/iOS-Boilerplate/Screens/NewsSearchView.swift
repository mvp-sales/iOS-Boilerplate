//
//  NewsSearchView.swift
//  iOS-Boilerplate
//
//  Created by Marcus Vinicius Palassi Sales on 08/06/25.
//

import SwiftUI
import ComposableArchitecture

struct NewsSearchView: View {
    @State private var searchTerm = ""
    let store: StoreOf<NewsSourcesFeature>
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                Text("Search news by term")
                    .font(.headline)
                    .padding(.top, 32)
                
                TextField("Search", text: $searchTerm)
                    .textFieldStyle(.roundedBorder)
                    .padding(.horizontal)
                
                Button("Search news") {
                    print(searchTerm)
                }.buttonStyle(.borderedProminent)
                
                Button("Saved news list") {
                    print(searchTerm)
                }.buttonStyle(.bordered)
                
                Button("Show sources list") {
                    store.send(.loadSourcesFromServer(""))
                }.buttonStyle(.bordered)
                
                Text("Sources count: \(store.sources.count)")
                
                Spacer()
            }
            .navigationTitle("News search")
            .navigationBarTitleDisplayMode(.inline)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.white.ignoresSafeArea())
        }
    }
}

#Preview {
    NewsSearchView(store: Store(initialState: NewsSourcesFeature.State()) {
        NewsSourcesFeature()
      })
}
