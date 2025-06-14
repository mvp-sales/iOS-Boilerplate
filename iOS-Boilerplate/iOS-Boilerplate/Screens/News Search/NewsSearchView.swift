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
    @Environment(NavigationRouter.self) var router
    
    var body: some View {
        VStack(spacing: 16) {
            Text("Search news by term")
                .font(.headline)
                .padding(.top, 32)
            
            TextField("Search", text: $searchTerm)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal)
            
            Button("Search news") {
                guard !searchTerm.isEmpty else { return }
                router.push(to: .newsListScreen(searchTerm, ""))
            }.buttonStyle(.borderedProminent)
            
            Button("Saved news list") {

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
