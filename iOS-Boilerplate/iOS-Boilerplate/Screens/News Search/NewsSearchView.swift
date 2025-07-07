//
//  NewsSearchView.swift
//  iOS-Boilerplate
//
//  Created by Marcus Vinicius Palassi Sales on 08/06/25.
//

import SwiftUI

struct NewsSearchView: View {
    @State private var searchTerm = ""
    @State private var isFavouriteSourcesOnly = false
    @Environment(NavigationRouter.self) var router
    
    var body: some View {
        VStack(spacing: 16) {
            Text("Search news by term")
                .font(.headline)
                .padding(.top, 32)
            
            TextField("Search", text: $searchTerm)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal)
            
            Toggle(isOn: $isFavouriteSourcesOnly) {
                Text("Show only from favourite sources")
            }.padding(.horizontal, 16)
            
            Button("Search news") {
                guard !searchTerm.isEmpty else { return }
                router.push(to: .newsListScreen(searchTerm, "", isFavouriteSourcesOnly))
            }.buttonStyle(.borderedProminent)
            
            Button("Saved news list") {
                router.push(to: .newsSavedList)
            }.buttonStyle(.bordered)
            
            Button("Show sources list") {
                router.push(to: .newsSourcesList)
            }.buttonStyle(.bordered)
            
            Spacer()
        }
        .navigationTitle("News search")
        .navigationBarTitleDisplayMode(.inline)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white.ignoresSafeArea())
    }
}

#Preview {
    NewsSearchView()
}
