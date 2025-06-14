//
//  NewsSourcesListView.swift
//  iOS-Boilerplate
//
//  Created by Marcus Vinicius Palassi Sales on 10/06/25.
//

import SwiftUI

struct NewsSourcesListView: View {
    
    @Environment(NavigationRouter.self) var router
    @Bindable private var viewModel = NewsSourcesListViewModel()
    
    var body: some View {
        VStack {
            List(viewModel.sources) { source in
                VStack(alignment: .leading) {
                    Text(source.name)
                        .font(.title)
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
        }
        .onAppear {
            viewModel.loadSources()
        }
    }
}

#Preview {
    NewsSourcesListView()
}
